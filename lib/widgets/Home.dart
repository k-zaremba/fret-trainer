import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  bool? started;
  List<Note> o2 = Note.OCTAVE2;
  late List<bool> o2select;

  List<Note> o3 = Note.OCTAVE3;
  late List<bool> o3select;

  List<Note> o4 = Note.OCTAVE4;
  late List<bool> o4select;

  List<Note> o5 = Note.OCTAVE5;
  late List<bool> o5select;


  late List<bool> frets1_3;
  late List<bool> frets4_6;
  late List<bool> frets7_9;
  late List<bool> frets10_12;

  List<bool> octavesSelect = List.generate(4, (index) => true);
  List<bool> fretsSelect = List.generate(4, (index) => true);

  List<bool> tabSelect = [true, false];

  _initialize() async {

  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);


    setState(() {
      o2select = List.generate(o2.length, (index) => true);
      o3select = List.generate(o3.length, (index) => true);
      o4select = List.generate(o4.length, (index) => true);
      o5select = List.generate(o5.length, (index) => true);

      frets1_3 = List.generate(3, (index) => true);
      frets4_6 = List.generate(3, (index) => true);
      frets7_9 = List.generate(3, (index) => true);
      frets10_12 = List.generate(3, (index) => true);

      started = false;
    });
    super.initState();
  }

  void toggleScreen(int index){
    setState(() {
      if(index == 0){
        tabSelect[0] = true;
        tabSelect[1] = false;
      }else{
        tabSelect[0] = false;
        tabSelect[1] = true;
      }
    });
  }

  void setAll(bool status){
    if(tabSelect[0]){ // octaves tab active
      switchAllOctaves(status);
    }else{
      switchAllFrets(status);
    }
  }

  void switchAllFrets(bool status){
    setState(() {
      frets1_3 = List.generate(3, (index) => status);
      frets4_6 = List.generate(3, (index) => status);
      frets7_9 = List.generate(3, (index) => status);
      frets10_12 = List.generate(3, (index) => status);
      fretsSelect = List.generate(4, (index) => status);
    });
  }

  void switchAllOctaves(bool status){
    setState(() {
      o2select = List.generate(o2.length, (index) => status);
      o3select = List.generate(o3.length, (index) => status);
      o4select = List.generate(o4.length, (index) => status);
      o5select = List.generate(o5.length, (index) => status);
      octavesSelect = List.generate(4, (index) => status);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Simple flutter fft example",
        theme: ThemeData.dark(),
        color: Colors.blue,
        home: Scaffold(
          backgroundColor: Colors.white12,
          body: Center(
            child: Column(
              children: [SingleChildScrollView(
                child: SizedBox(
                  child: Column(
                    children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomToggleButtons(
                            children: [
                              SizedBox(width: 171,child : Text('NOTES', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w600, fontSize: 27), textAlign: TextAlign.center,)),
                              SizedBox(width: 171,child : Text('FRETS', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w600, fontSize: 27), textAlign: TextAlign.center,)),
                            ],

                            isSelected: tabSelect,
                            onPressed: (int index){
                              toggleScreen(index);
                            },
                            color: Colors.white38,
                            selectedColor: Colors.white,
                            fillColor: Colors.indigo,
                            renderBorder: false,
                            splashColor: Colors.white,
                      ),
                          ],
                        ),

                      SizedBox(height: 10),

                      SizedBox(
                        height: 620,
                        child:
                        tabSelect[0] ?

                        Column(
                          children: [
                            CustomToggleButtons(
                                children: [
                                  SizedBox(width: 70, child: Text('OCTAVE 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 12),)),
                                  SizedBox(width: 70, child: Text('OCTAVE 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 12),)),
                                  SizedBox(width: 70, child: Text('OCTAVE 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 12),)),
                                  SizedBox(width: 70, child: Text('OCTAVE 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 12),)),
                                ],
                                isSelected: octavesSelect,
                                onPressed: (int index){
                                  setState(() {
                                    octavesSelect[index] = !octavesSelect[index];
                                  });
                                },
                              color: Colors.white38,
                              selectedColor: Colors.white,
                              fillColor: Colors.indigo,
                              renderBorder: false,
                              splashColor: Colors.white,
                              spacing: 4,
                            ),
                            SizedBox(height: 3,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                octavesSelect[0] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o2), // tutaj daje oktawe
                                  isSelected: o2select,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o2), // tutaj daje oktawe
                                  isSelected: o2select,
                                  onPressed: (int index){
                                    setState(() {
                                      o2select[index] = !o2select[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                                ),

                                octavesSelect[1] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o3), // tutaj daje oktawe
                                  isSelected: o3select,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o3), // tutaj daje oktawe
                                  isSelected: o3select,
                                  onPressed: (int index){
                                    setState(() {
                                      o3select[index] = !o3select[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                                ),

                                octavesSelect[2] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o4), // tutaj daje oktawe
                                  isSelected: o4select,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o4), // tutaj daje oktawe
                                  isSelected: o4select,
                                  onPressed: (int index){
                                    setState(() {
                                      o4select[index] = !o4select[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                                ),

                                octavesSelect[3] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o5), // tutaj daje oktawe
                                  isSelected: o5select,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children:  notesToButtons(o5), // tutaj daje oktawe
                                  isSelected: o5select,
                                  onPressed: (int index){
                                    setState(() {
                                      o5select[index] = !o5select[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                ),


                              ],
                            ),],
                        )
              :
                        Column(
                          children: [ //TODO: FRETS
                            CustomToggleButtons(
                              children: [
                                SizedBox(width: 70, child: Text('1 - 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 17),textAlign: TextAlign.center,)),
                                SizedBox(width: 70, child: Text('4 - 6', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 17),textAlign: TextAlign.center,)),
                                SizedBox(width: 70, child: Text('7 - 9', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 17),textAlign: TextAlign.center,)),
                                SizedBox(width: 70, child: Text('10 - 12', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600, fontSize: 17),textAlign: TextAlign.center,)),
                              ],
                              isSelected: fretsSelect,
                              onPressed: (int index){
                                setState(() {
                                  fretsSelect[index] = !fretsSelect[index];
                                });
                              },
                              color: Colors.white38,
                              selectedColor: Colors.white,
                              fillColor: Colors.indigo,
                              renderBorder: false,
                              splashColor: Colors.white,
                              spacing: 4,
                            ),
                            SizedBox(height: 3,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                fretsSelect[0] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 1', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets1_3,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 1', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets1_3,
                                  onPressed: (int index){
                                    setState(() {
                                      frets1_3[index] = !frets1_3[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                ),

                                fretsSelect[1] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 6', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets4_6,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 6', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets4_6,
                                  onPressed: (int index){
                                    setState(() {
                                      frets4_6[index] = !frets4_6[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                ),

                                fretsSelect[2] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 7', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 8', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 9', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets7_9,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 7', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 8', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 9', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets7_9,
                                  onPressed: (int index){
                                    setState(() {
                                      frets7_9[index] = !frets7_9[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                ),


                                fretsSelect[3] ?
                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 10', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 11', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 12', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets10_12,
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                  disabledFillColor: Colors.black26,
                                )

                                    :

                                CustomToggleButtons(
                                  direction : Axis.vertical,
                                  children: [
                                    SizedBox(width: 70, child: Text('FRET 10', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 11', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                    SizedBox(width: 70, child: Text('FRET 12', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                                  ],
                                  isSelected: frets10_12,
                                  onPressed: (int index){
                                    setState(() {
                                      frets10_12[index] = !frets10_12[index];
                                    });
                                  },
                                  color: Colors.white38,
                                  selectedColor: Colors.white,
                                  fillColor: Colors.indigo,
                                  renderBorder: false,
                                  splashColor: Colors.white,
                                  spacing: 5.0,
                                  constraints: BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                                ),

                              ],
                            ),],
                        )


                      ),
                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              setAll(true);
                            },
                            child: Text('ALL'),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              setAll(false);
                            },
                            child: Text('NONE'),
                          ),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.indigoAccent,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              // Respond to button press
                            },
                            child: Text('START'),
                          ),
                        ],
                      )

                    ],),
                ),
              ),

              ],),
          ),
        ));
  }
}

class NoteText extends StatelessWidget {
  Note note;

  NoteText({required this.note});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 70, child: Text(note.toString(), style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)); // dostosowac szerokosc do oktaw
  }
}

List<Widget> notesToButtons(List<Note> l){
  List<Widget> w = [];
  l.map((e) => NoteText(note: e)).forEach((element) { w.add(element);});
  return w;
}
