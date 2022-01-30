import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:customtogglebuttons/customtogglebuttons.dart';

class Home extends StatefulWidget {
  final Function() parentScreenFunction;
  final Function(List<Note>) parentNoteFunction;

  Home({required this.parentScreenFunction, required this.parentNoteFunction});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  late Function() parentScreenFunction;
  late Function(List<Note>) parentNoteFunction;

  bool? started;
  List<Note> o2 = Note.OCTAVE2;
  late List<bool> o2select;

  List<Note> o3 = Note.OCTAVE3;
  late List<bool> o3select;

  List<Note> o4 = Note.OCTAVE4;
  late List<bool> o4select;

  List<Note> o5 = Note.OCTAVE5;
  late List<bool> o5select;


  late List<bool> frets1_3select;
  late List<bool> frets4_6select;
  late List<bool> frets7_9select;
  late List<bool> frets10_12select;

  List<bool> octavesSelect = List.generate(4, (index) => true);
  List<bool> fretsSelect = List.generate(4, (index) => true);

  List<bool> tabSelect = [true, false];

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    setState(() {
      parentNoteFunction = widget.parentNoteFunction;
      parentScreenFunction = widget.parentScreenFunction;
      o2select = List.generate(o2.length, (index) => true);
      o3select = List.generate(o3.length, (index) => true);
      o4select = List.generate(o4.length, (index) => true);
      o5select = List.generate(o5.length, (index) => true);

      frets1_3select = List.generate(3, (index) => true);
      frets4_6select = List.generate(3, (index) => true);
      frets7_9select = List.generate(3, (index) => true);
      frets10_12select = List.generate(3, (index) => true);

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
      frets1_3select = List.generate(3, (index) => status);
      frets4_6select = List.generate(3, (index) => status);
      frets7_9select = List.generate(3, (index) => status);
      frets10_12select = List.generate(3, (index) => status);
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

  void proceed(){
    List<List<Note>> chosenNotesLists= [];
    if(tabSelect[0]){ // octaves tab active
      List<List<Note>> octaves = [o2, o3, o4, o5];
      List<List<bool>> selects = [o2select, o3select, o4select, o5select];

      for(int i = 0; i < octavesSelect.length; i++){
        if(octavesSelect[i]){ // octave is chosen
          chosenNotesLists.add(octaves[i]);
        }else{
          List<Note> chosenFromOctave = [];
          for(int j = 0; j < octaves[i].length; j++){
            if(selects[i][j] == true){
              chosenFromOctave.add(octaves[i][j]);
            }
          }
          chosenNotesLists.add(chosenFromOctave);
        }
       }
      }else{  // frets tab active
        List<List<Note>> frets1_3 = [Note.FRET1, Note.FRET2, Note.FRET3];
        List<List<Note>> frets4_6 = [Note.FRET4, Note.FRET5, Note.FRET6];
        List<List<Note>> frets7_9 = [Note.FRET7, Note.FRET8, Note.FRET9];
        List<List<Note>> frets10_12 = [Note.FRET10, Note.FRET11, Note.FRET12];
        List<List<bool>> selects = [frets1_3select, frets4_6select, frets7_9select, frets10_12select];
        List<List<List<Note>>> frets = [frets1_3, frets4_6, frets7_9, frets10_12];

        for(int i = 0; i < fretsSelect.length; i++){
          if(fretsSelect[i]){ // fret is chosen
            for (List<Note> fret in frets[i]) {chosenNotesLists.add(fret);}
          }else{
            List<Note> chosenFromFretRange = [];
            for(int j = 0; j < frets[i].length; j++){
              if(selects[i][j] == true){
                for (Note fretNote in frets[i][j]) {chosenFromFretRange.add(fretNote);}
              }
            }
            chosenNotesLists.add(chosenFromFretRange);
          }
        }
    }

    List<Note> notes = Note.getNotesList(chosenNotesLists);
    notes.sort((a, b) => a.freq().compareTo(b.freq()));
    notes = notes.toSet().toList();
    parentNoteFunction(notes);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        color: Colors.blue,
        home: Scaffold(
          backgroundColor: Colors.white12,
          body: Column(
            children: [

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomToggleButtons(
                children: const [
                  SizedBox(width: 173,child : Text('NOTES', style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.w600, fontSize: 27), textAlign: TextAlign.center,)),
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

                const SizedBox(height: 10),

                SizedBox(
            height: 620,
            child:
            tabSelect[0] ?

            Column(
              children: [
                CustomToggleButtons(
                    children: const [
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
                const SizedBox(height: 3,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    octavesSelect[0] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o2),
                      isSelected: o2select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o2),
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
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                    ),

                    octavesSelect[1] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o3),
                      isSelected: o3select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o3),
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
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                    ),

                    octavesSelect[2] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o4),
                      isSelected: o4select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
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
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),

                    ),

                    octavesSelect[3] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o5),
                      isSelected: o5select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children:  notesToButtons(o5),
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
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                    ),


                  ],
                ),],
            )
            :
            Column(
              children: [
                CustomToggleButtons(
                  children: const [
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
                const SizedBox(height: 3,),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    fretsSelect[0] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 1', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets1_3select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 1', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 2', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 3', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets1_3select,
                      onPressed: (int index){
                        setState(() {
                          frets1_3select[index] = !frets1_3select[index];
                        });
                      },
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                    ),

                    fretsSelect[1] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 6', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets4_6select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 4', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 5', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 6', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets4_6select,
                      onPressed: (int index){
                        setState(() {
                          frets4_6select[index] = !frets4_6select[index];
                        });
                      },
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                    ),

                    fretsSelect[2] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 7', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 8', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 9', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets7_9select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 7', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 8', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 9', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets7_9select,
                      onPressed: (int index){
                        setState(() {
                          frets7_9select[index] = !frets7_9select[index];
                        });
                      },
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                    ),


                    fretsSelect[3] ?
                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 10', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 11', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 12', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets10_12select,
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                      disabledFillColor: Colors.black26,
                    )

                        :

                    CustomToggleButtons(
                      direction : Axis.vertical,
                      children: const [
                        SizedBox(width: 70, child: Text('FRET 10', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 11', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                        SizedBox(width: 70, child: Text('FRET 12', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600),textAlign: TextAlign.center,)),
                      ],
                      isSelected: frets10_12select,
                      onPressed: (int index){
                        setState(() {
                          frets10_12select[index] = !frets10_12select[index];
                        });
                      },
                      color: Colors.white38,
                      selectedColor: Colors.white,
                      fillColor: Colors.indigo,
                      renderBorder: false,
                      splashColor: Colors.white,
                      spacing: 5.0,
                      constraints: const BoxConstraints(minWidth: 40.0, minHeight: 42.0),
                    ),

                  ],
                ),],
            )


                ),

                SizedBox(height: 31,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setAll(true);
                      },
                      child: const Text('ALL'),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        setAll(false);
                      },
                      child: const Text('NONE'),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        proceed();
                        parentScreenFunction();

                        // Respond to button press
                      },
                      child: const Text('NEXT'),
                    ),
                  ],
                ),

            ],),
        ));
  }
}

class NoteText extends StatelessWidget {
  Note note;

  NoteText({required this.note});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 70, child: Text(note.toString(), style: const TextStyle(letterSpacing: 1, fontWeight: FontWeight.w600), textAlign: TextAlign.center,)); // dostosowac szerokosc do oktaw
  }
}

List<Widget> notesToButtons(List<Note> l){
  List<Widget> w = [];
  l.map((e) => NoteText(note: e)).forEach((element) { w.add(element);});
  return w;
}
