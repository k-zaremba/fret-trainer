import 'package:flutter/material.dart';
import 'package:fretapp/utility/Note.dart';
import 'package:fretapp/widgets/App.dart';
import 'package:fretapp/widgets/Home.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool? isStarted;
  late List<Note> inGameNotes;

  toggleScreen() {
    setState(() {
      isStarted = !isStarted!;
    });
  }

  setInGameNotes(List<Note> notes) {
    setState(() {
      inGameNotes = notes;
    });
  }

  @override
  void initState() {
    isStarted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isStarted! ?  Home(
        parentScreenFunction: toggleScreen,
        parentNoteFunction: setInGameNotes,
      )
          :

          App(
            parentStateFunction: toggleScreen,
            inGameNotes: inGameNotes,)
    );
  }
}
