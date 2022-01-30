import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:fretapp/utility/NoteValidator.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:fretapp/widgets/Sprite.dart';

class App extends StatefulWidget {
  final Function() parentStateFunction;
  List<Note> inGameNotes;
  App({required this.parentStateFunction, required this.inGameNotes});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  late Function() callParent;
  final SpriteController myController = SpriteController();

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
  double? counter;

  FlutterFft flutterFft = new FlutterFft();

  _initialize() async {
    // Keep asking for mic permission until accepted
    while (!(await flutterFft.checkPermission())) {
      flutterFft.requestPermission();
      // IF DENY QUIT PROGRAM
    }

    // await flutterFft.checkPermissions();
    await flutterFft.startRecorder();
    setState(() => isRecording = flutterFft.getIsRecording);
    flutterFft.onRecorderStateChanged.listen(
              (data) => {
            print("Changed state, received: $data"),
            setState(() => {
              frequency = data[1] as double,
              note = data[2] as String,
              octave = data[5] as int,
              currentNote = noteValidator?.findClosestNoteFromAll(frequency!),
              myController.setNote(currentNote!),
              isOnNote = targetNote == currentNote,
            },),


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

            if(timeOnNote==2){
              myController.resize(90.0),
            }else if(timeOnNote==5){
              myController.resize(105.0),
            }else if(timeOnNote==7){
              myController.resize(120.0),
            }else if(timeOnNote==9){
              myController.resize(135.0),
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

  void startTimer() async {
    setState(() {
      counter = 0;
    });

      Timer.periodic(const Duration(milliseconds: 100), (timer) {
          if(counter! < 10){setState(() {
            counter = (counter! + 0.1);
          });}else{
            timer.cancel();
            getTarget(currentNote!);
            super.dispose();
          }
      });
  }

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    callParent = widget.parentStateFunction;
    List<Note> notes = widget.inGameNotes;

    noteValidator = NoteValidator(notes);
    targetNote = noteValidator!.getTarget(Note.NULL);
    currentNote = Note.NULL;
    isOnNote = false;
    timeOnNote = 0;
    counter = 0;

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    started = false;


    print(noteValidator);
    print(noteValidator?.freqs());

    super.initState();
  }

  Note getTarget(Note currNote){
    startTimer();
    return noteValidator!.getTarget(currNote);
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
                      height: 150,
                      child: Center(
                        child: SpriteAnimation(
                          spriteController: myController,
                        ),
                      ),
                    )
                        : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 10),

                    started!
                        ? Text(frequency!.toStringAsFixed(2),
                        style: const TextStyle(fontSize: 18, letterSpacing: 3))
                        : const SizedBox(width: 0, height: 0,),

                    const SizedBox(height: 20),
                    //
                    // started!
                    //     ? Text(counter!.toStringAsFixed(1),
                    //     style: const TextStyle(fontSize: 18, letterSpacing: 3))
                    //     : const SizedBox(width: 0, height: 0,),

                  ],),
              ),

                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    !started! ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          _initialize();
                          setState(() {
                            started = !started!;
                          });
                          // Respond to button press
                        },
                        child: const Text('START'),
                    )
                        :

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        callParent();
                        flutterFft.stopRecorder();
                        // Respond to button press
                      },
                      child: const Text('BACK'),
                    ),
                  ],
                ),

            ],),
          ),
        ));
  }
}
