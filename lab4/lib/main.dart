import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  DownloadFileService downloadFileService = new DownloadFileService();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

                ),
              ),
              OutlineButton(
                  child: Text("Download"),
                  onPressed: () {
                      widget.downloadFileService.requestDownload(new TaskInfo(name: "xD", link: "https://yuml.me/ab1ef363.png"));
                      setState((){});
                  },
                  borderSide: BorderSide(color: Colors.blueAccent),
                  shape: StadiumBorder(),
                  textColor: Colors.blueAccent,
                  color: Colors.blueAccent,
                  splashColor: Colors.blueAccent,
                  highlightColor: Colors.lightBlue,
                  focusColor: Colors.blueAccent,
                  hoverColor: Colors.blueAccent
              ),
              buildDownloadsTab(widget.downloadFileService.tasks),
            ],
          ),
        )
    );
  }

  Widget buildDownloadsTab(List<TaskInfo> tasks){
    return Expanded(
      child: tasks.length > 0? ListView.builder(
          itemCount: widget.downloadFileService.tasks.length,
            itemBuilder: (BuildContext context, int index){
              return TaskObject(tasks[index]);
            }
        ): Text("there is no download History")
    );
  }
  Widget TaskObject(TaskInfo task){
    return Builder(
      builder: (BuildContext context) {
        return Container(
          child: Text(task.link),
        );
      },
    );
  }
}
