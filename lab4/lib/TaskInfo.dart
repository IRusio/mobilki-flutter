import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';

class TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;
  RoundedProgressBarTheme theme = RoundedProgressBarTheme.purple;
  TaskInfo({this.name, this.link});
}
