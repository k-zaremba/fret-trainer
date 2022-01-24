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


  late List<bool> octavesSelect = List.generate(4, (index) => true);


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
      started = false;

    });
    super.initState();
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
                      SizedBox(height: 10),

                      CustomToggleButtons(
                          children: [
                            SizedBox(width: 72, child: Text('OCTAVE 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),)),
                            SizedBox(width: 72, child: Text('OCTAVE 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),)),
                            SizedBox(width: 72, child: Text('OCTAVE 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),)),
                            SizedBox(width: 72, child: Text('OCTAVE 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),)),
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
                      ),
                      SizedBox(height: 10),

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
                                  started = !started!;
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
                      ),

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
    return SizedBox(width: 70, child: Text(note.toString(), style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),)); // dostosowac szerokosc do oktaw
  }
}

List<Widget> notesToButtons(List<Note> l){
  List<Widget> w = [];
  l.map((e) => NoteText(note: e)).forEach((element) { w.add(element);});
  return w;
}
