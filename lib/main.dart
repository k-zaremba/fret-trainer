import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:fretapp/additional/Note.dart';

import 'additional/Note.dart';

void main() => runApp(Application());

class Application extends StatefulWidget {
  @override
  ApplicationState createState() => ApplicationState();
}

class ApplicationState extends State<Application> {
  double? frequency;
  String? note;
  int? octave;
  bool? isRecording;


  FlutterFft flutterFft = new FlutterFft();

  _initialize() async {
    print("Starting recorder...");
    // print("Before");
    // bool hasPermission = await flutterFft.checkPermission();
    // print("After: " + hasPermission.toString());

    // Keep asking for mic permission until accepted
    while (!(await flutterFft.checkPermission())) {
      flutterFft.requestPermission();
      // IF DENY QUIT PROGRAM
    }

    // await flutterFft.checkPermissions();
    await flutterFft.startRecorder();
    print("Recorder started...");
    setState(() => isRecording = flutterFft.getIsRecording);

    flutterFft.onRecorderStateChanged.listen(
            (data) => {
          print("Changed state, received: $data"),
          setState(
                () => {
              frequency = data[1] as double,
              note = data[2] as String,
              octave = data[5] as int,
            },
          ),
          flutterFft.setNote = note!,
          flutterFft.setFrequency = frequency!,
          flutterFft.setOctave = octave!,
          print("Octave: ${octave!.toString()}")
        },
        onError: (err) {
          print("Error: $err");
        },
        onDone: () => {print("Isdone")});
  }

  @override
  void initState() {

    if(Note.compare(440.0, Note.A4)) {
      print('right');
    }

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Simple flutter fft example",
        theme: ThemeData.dark(),
        color: Colors.blue,
        home: Scaffold(
          backgroundColor: Colors.purple,
          appBar: AppBar(title: Text('checking'),),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isRecording!
                    ? Text("Current note: ${note!},${octave!.toString()}",
                    style: TextStyle(fontSize: 30))
                    : Text("Not Recording", style: TextStyle(fontSize: 35)),
                isRecording!
                    ? Text(
                    "Current frequency: ${frequency!.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 30))
                    : Text("Not Recording", style: TextStyle(fontSize: 35)),

                     Text('${Note.A4.runtimeType}'),

              ],
            ),
          ),
        ));
  }
}
