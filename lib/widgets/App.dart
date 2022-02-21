import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:fretapp/utility/NoteValidator.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:fretapp/widgets/Sprite.dart';

class App extends StatefulWidget {
  final Function() parentStateFunction;
  List<Note> inGameNotes;
  int timeToAnswer;

  App({required this.parentStateFunction, required this.inGameNotes, required this.timeToAnswer});

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
  int? timeToAnswer;

  Note? currentNote;
  Note? targetNote;
  bool? isOnNote;
  int? timeOnNote;
  double? correctTimestamp;
  double? fullCounter;
  int? correctNum;
  int? incorrectNum;
  bool noteChanged = true;
  double _width = 150;
  Duration? _duration;
  bool? timeIndicator;

  startShrinking(){
    setState(() {
      _duration = Duration(microseconds: (timeToAnswer! * 1000000) - 100000);
      _width = 0;
    });
  }

  startGrowing() {
    setState(() {
      _duration = Duration(microseconds: 1);
      _width = 150;
    });
  }

  restartBar() async {
    startGrowing();
    await Future.delayed(const Duration(microseconds: 100000));
    startShrinking();
  }

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
                correctNum = correctNum! + 1,
                isOnNote = false,
                timeOnNote = 0,
                correctTimestamp = fullCounter,
                noteChanged = true
              }),
              restartBar()
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
      correctTimestamp = 0;
      fullCounter = 0;
      noteChanged = true;
    });
    restartBar();

    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if(started!){setState(() {
        fullCounter = (fullCounter! + 0.1);

        if(((fullCounter! - correctTimestamp!) % timeToAnswer!).toInt() == 0){
          if(!noteChanged){
            setState(() => {
              noteChanged = true,
              targetNote = noteValidator!.getTarget(targetNote!),
              isOnNote = false,
              timeOnNote = 0,
              incorrectNum = incorrectNum! + 1,
            });
            restartBar();
          }
        }else{
          setState(() {
            noteChanged = false;
          });
        }
      });}else{
        timer.cancel();
        super.dispose();
      }
    });
  }

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    callParent = widget.parentStateFunction;
    List<Note> notes = widget.inGameNotes;
    timeToAnswer = widget.timeToAnswer;
    _duration = Duration(seconds: widget.timeToAnswer);

    noteValidator = NoteValidator(notes);
    targetNote = noteValidator!.getTarget(Note.NULL);
    currentNote = Note.NULL;
    isOnNote = false;
    timeOnNote = 0;
    correctTimestamp = 0;
    fullCounter = 0;
    correctNum = 0;
    incorrectNum = 0;
    _width = 150;

    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;
    started = false;
    timeIndicator = true;


    print(noteValidator);
    print(noteValidator?.freqs());

    super.initState();
  }

  Note getTarget(Note currNote){
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
                  const SizedBox(height: 90),
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

                  const SizedBox(height: 25),

                  (started! && timeIndicator!)
                      ? AnimatedContainer(duration: _duration! ,height: 5, width:_width, color: Colors.white,)
                      : const SizedBox(width: 1, height: 5,),

                  const SizedBox(height: 25),

                  started!
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("$incorrectNum", style: const TextStyle(fontSize: 18, letterSpacing: 3, color: Colors.redAccent)),
                          Text(" / ", style: const TextStyle(fontSize: 18, letterSpacing: 3)),
                          Text("$correctNum",
                          style: const TextStyle(fontSize: 18, letterSpacing: 3, color: Colors.green)),
                        ],
                      )
                      : const SizedBox(width: 0, height: 0,),

                ],),
            ),

              const SizedBox(height: 80,),
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
                        startTimer();
                        // Respond to button press
                      },
                      child: const Text('START'),
                  )
                      :
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey,
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
                  )
                ],

              ),
              const SizedBox(height: 25),

              started!
                  ? Text('${(fullCounter! / 60).floor().toStringAsFixed(0)}:${(fullCounter! % 60).toInt().toStringAsFixed(0).padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 15, letterSpacing: 3, color: Colors.blueGrey))
                  : const SizedBox(width: 0, height: 0,),
          ],),
            ),
        ));
  }
}
