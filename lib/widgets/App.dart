import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:fretapp/utility/NoteValidator.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:fretapp/widgets/AnimCircle.dart';

class App extends StatefulWidget {
  final Function() parentStateFunction;
  List<Note> inGameNotes;
  App({required this.parentStateFunction, required this.inGameNotes});

  @override
  AppState createState() => AppState(parentStateFunction);
}

class AppState extends State<App> {
  AppState(Function() fun) : callParent = fun;

  Function() callParent;
  final CircleController myController = CircleController();

  List<Note>? notesList;
  List<double>? notesFreq;
  NoteValidator? noteValidator;

  double? frequency;
  String? note;
  int? octave;
  bool? isRecording;
  bool? started;

  Note? currentNote;
  Note? targetNote;
  bool? isOnNote;
  int? timeOnNote;

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
            setState(() => {
              frequency = data[1] as double,
              note = data[2] as String,
              octave = data[5] as int,
              currentNote = noteValidator?.findClosestNote(frequency!),
              myController.setNote(currentNote!),
              isOnNote = targetNote == currentNote,
            },

            ),
            if(isOnNote!){
                setState(() => {
                  timeOnNote = (timeOnNote! + 1),
                })
            },

            if(timeOnNote! >= 10){
              setState(() => {
                targetNote = noteValidator!.getTarget(targetNote!),
                isOnNote = false,
                timeOnNote = 0,
              })
            },

            if(!isOnNote!){
              if(timeOnNote! > 0){
                setState(() => {
                  timeOnNote = (timeOnNote! - 1),
                }),
              },
              if(timeOnNote == 0)
                myController.reset(),
            },

            if(timeOnNote==1){
              myController.resize(40.0, const Color(0xFF30BD00).withOpacity(0.8)),
            }else if(timeOnNote==4){
              myController.resize(70.0, const Color(0xFF30BD00).withOpacity(0.6)),
            }else if(timeOnNote==7){
              myController.resize(100.0, const Color(0xFF30BD00).withOpacity(0.4)),
            },

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

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    List<Note> notes = widget.inGameNotes;

    noteValidator = NoteValidator(notes);
    targetNote = noteValidator!.getTarget(Note.NULL);
    currentNote = Note.NULL;
    isOnNote = false;
    timeOnNote = 0;

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    started = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        color: Colors.blue,
        home: Scaffold(
          backgroundColor: Colors.white12,
          body: Center(
            child: Column(
              children: [SizedBox(
                height: 550,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                  started!
                      ? const SizedBox(
                        height: 40,
                        child: Text(
                        "TARGET",
                        style: TextStyle(fontSize: 25, letterSpacing: 5)),
                      )
                      : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 10),

                    started!
                        ? SizedBox(
                          height: 80,
                          child: Text(
                          '$targetNote',
                          style: const TextStyle(fontSize: 60)),
                        )
                        : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 40),

                    started!
                        ? const Text(
                        "YOUR NOTE",
                        style: TextStyle(fontSize: 18, letterSpacing: 5))
                        : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 10),

                    started!
                        ? SizedBox(
                      width: 300,
                      height: 70,
                      child: Center(
                        child: AnimCircle(
                          circleController: myController,
                        ),
                      ),
                    )
                        : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 10),

                    started!
                        ? Text(frequency!.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 18, letterSpacing: 3))
                        : const SizedBox(width: 0, height: 0,),

                  ],),
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RawMaterialButton(
                        onPressed: () {
                          callParent();
                        },
                        child: const Text('BACK',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 40 )
                        )
                    ),

                    RawMaterialButton(
                        onPressed: () {
                          _initialize();
                          setState(() {
                            started = !started!;
                          });
                        },
                        child: const Text('START',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 40 )
                        )
                    ),
                  ],
                ),

            ],),
          ),
        ));
  }
}
