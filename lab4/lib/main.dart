import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:lab4/DownloadFileService.dart';
import 'package:lab4/TaskInfo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Download Meneager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Download Meneager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key) {
    downloadFileService = new DownloadFileService();
    downloadFileService.bindBackgroundIsolate();

  }
  final String title;
  DownloadFileService downloadFileService;
  Timer _timer;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();
  @override
  _MyHomePageState createState() {
    FlutterDownloader.registerCallback(DownloadFileService.downloadCallback);
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final linkController = TextEditingController();

  void startTimer() {
    const halfOfSecond = const Duration( milliseconds: 500);
    widget._timer = new Timer.periodic(halfOfSecond, (timer) => setState((){

      widget.downloadFileService.tasks.forEach((task) {
        if(task != null){
          task.theme = task.status == DownloadTaskStatus.complete?
          RoundedProgressBarTheme.green:
          task.status == DownloadTaskStatus.running?
          RoundedProgressBarTheme.yellow:
          task.status ==  DownloadTaskStatus.failed?
          RoundedProgressBarTheme.midnight:
          task.status ==  DownloadTaskStatus.paused?
          RoundedProgressBarTheme.blue:
          task.status ==  DownloadTaskStatus.canceled?
          RoundedProgressBarTheme.red:
          RoundedProgressBarTheme.purple;
        }
      });
    }));
  }

  @override
  void initState() {
    startTimer();
    widget.downloadFileService.bindBackgroundIsolate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                width: 350,
                child: TextField(
                  decoration:
                  InputDecoration(
                    helperText: "Insert Link To Download Page",
                  ),
                  keyboardType: TextInputType.text,
                  controller: linkController,

                ),
              ),
              OutlineButton(
                  child: Text("Download"),
                  onPressed: linkController.text.length != 0?() {
                    var name = linkController.text.split('/');
//                    var task = new TaskInfo(name: "xD", link: "https://yuml.me/ab1ef363.png");
                    var task = new TaskInfo(name: name[name.length-1], link: linkController.text);
                    setState(() {
                      widget.downloadFileService.requestDownload(task);
                      widget.downloadFileService.bindBackgroundIsolate();
                    });

                  }: (){},
                  borderSide: BorderSide(color: Colors.blueAccent),
                  shape: StadiumBorder(),
                  textColor: Colors.blueAccent,
                  color: Colors.blueAccent,
                  splashColor: Colors.blueAccent,
                  highlightColor: Colors.lightBlue,
                  focusColor: Colors.blueAccent,
                  hoverColor: Colors.blueAccent
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.downloadFileService.deleteAll();
                },
              ),
              BuildDownloadsTab(widget.downloadFileService.tasks),
            ],
          ),
        )
    );
  }

  Widget BuildDownloadsTab(List<TaskInfo> tasks){
    return Expanded(
      child: tasks.length > 0? ListView.builder(
          itemCount: tasks.length,
            itemBuilder: (BuildContext context, int index){
              return TaskObject(tasks[index]);
            }
        ): Text("there is no download History")
    );
  }

  Widget TaskObject(TaskInfo task){


    var file = File(widget.downloadFileService.localPath+"/"+task.name);

    return Builder(
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(task.name),
              ],
              mainAxisAlignment: MainAxisAlignment.center,

              ),
            Column(
              children: <Widget>[
                RoundedProgressBar(
                    childCenter: file.existsSync() == true?
                    Text("${task.progress}% | ${(file.lengthSync()/(1024*1024)).round()}MB",
                        style: TextStyle(color: Colors.white)):
                    Text("${task.progress}% ",
                        style: TextStyle(color: Colors.white))
                    ,
                    percent: task.progress>=0? task.progress * 1.0: 0,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    theme: task.theme
                ),
                OptionsWidget(task),
                Divider(
                  color: Colors.black,
                )
              ],
            )
          ],
        );
      },
    );
  }

  Widget OptionsWidget(TaskInfo task)
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        task.status == DownloadTaskStatus.failed?IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            widget.downloadFileService.retryDownload(task);
          },
        ): Container(),
        task.status == DownloadTaskStatus.paused?IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            widget.downloadFileService.resumeDownload(task);
          },
        ): Container(),
        task.status == DownloadTaskStatus.running?IconButton(
          icon: Icon(Icons.pause),
          onPressed: () {
            widget.downloadFileService.pauseDownload(task);
          },
        ): Container(),
        task.status == DownloadTaskStatus.complete?IconButton(
          icon: Icon(Icons.insert_drive_file),
          onPressed: () {
            widget.downloadFileService.openDownloadedFile(task);
          },
        ): Container(),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            widget.downloadFileService.delete(task);
          },
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            widget.downloadFileService.remove(task);
          },
        ),


      ],
    );
  }
}
