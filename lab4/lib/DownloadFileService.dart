import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';


import 'TaskInfo.dart';
import 'main.dart';

class DownloadFileService{
  List<TaskInfo> tasks;
  String _localPath;
  ReceivePort _port = new ReceivePort();

  DownloadFileService(){
    tasks = [];
    configLocalPath();
  }
  void bindBackgroundIsolate()
  {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    if(!isSuccess){
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      final task = tasks?.firstWhere((task) => task.taskId == id);
      if(task != null){
       task.status = status;
       task.progress = progress;
      }
    });
  }

  void unbindBackgroundIsolate(){
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress){
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  void requestDownload(TaskInfo task) async {

    var status = await Permission.storage.status;
    if(status.isDenied || status.isUndetermined)
    {
      Permission.storage.request();
    }
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link,
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true
    );
    tasks.add(task);
  }

    void cancelDownload(TaskInfo task) async {
      await FlutterDownloader.cancel(taskId: task.taskId);
    }

    void pauseDownload(TaskInfo task) async {
      await FlutterDownloader.pause(taskId: task.taskId);
    }

    void resumeDownload(TaskInfo task) async {
      var newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
      task.taskId = newTaskId;
    }

    void retryDownload(TaskInfo task) async {
      var newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
      task.taskId = newTaskId;
    }

    Future<bool> openDownloadedFile(TaskInfo task) async {
      return FlutterDownloader.open(taskId: task.taskId);
    }

    void delete(TaskInfo task) async {
      await FlutterDownloader.remove(taskId: task.taskId, shouldDeleteContent: true);
      tasks.remove(task);
    }


  Future<String> _findLocalPath() async {
    final directory =  await getExternalStorageDirectory();
    return directory.path;
  }

    void configLocalPath() async {
      _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
    }
}