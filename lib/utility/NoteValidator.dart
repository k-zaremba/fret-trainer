import 'dart:math';

import 'package:fretapp/utility/Note.dart';

void main() {

  List<Note> notes = Note.getNotesList([Note.FRET1, Note.FRET2, Note.FRET3]);
  notes.sort((a, b) => a.freq().compareTo(b.freq()));
  notes = notes.toSet().toList();

  NoteValidator validator = NoteValidator(notes);
  print(validator.getAllFreqs());
  double fr = 670.0;
  print(validator.findClosestNoteFromAll(fr).freq());
 // print(validator.findClosestNoteFromAll(fr));
}

class NoteValidator {
  List<Note>? _allNotes;
  List<double>? _allFreq;
  List<Note>? _notesList;
  List<double>? _notesFreq;

  NoteValidator(List<Note> notesList){
    _notesList =  notesList;
    _notesFreq = Note.getNotesFrequencies(notesList);
    _allNotes = Note.getNotesList([Note.OCTAVE2, Note.OCTAVE3, Note.OCTAVE4, Note.OCTAVE5]);
    _allFreq = Note.getNotesFrequencies(_allNotes!);
  }

  @override
  String toString() {
    return _notesList.toString();
  }

  List<double>? freqs() {
    return _notesFreq;
  }

  String getAllNotes(){
    return _allNotes.toString();
  }

  List<double>? getAllFreqs(){
    return _allFreq;
  }

  Note getTarget(Note currentTarget){
    final _random = Random(); // add to random different than current (Note currentTarget)
    Note next = currentTarget;

    if(_notesList!.length < 2){
      return _notesList![_random.nextInt(_notesList!.length)];
    }

    while(next == currentTarget.freq()){
      next = _notesList![_random.nextInt(_notesList!.length)];
    }
    return next;
  }

  Note findClosestNote(double userFreq) {
    int mid = 0;
    int min = 0;
    int max = _notesFreq!.length - 1;

    while (max >= min) {
      mid = ((max + min) / 2).floor();

      if (userFreq == _notesFreq![mid]) {
        return _notesList![mid];
      } else if (userFreq > _notesFreq![mid]) {
        min = mid + 1;
      } else {
        if(mid == 0) {
          break;
        }
        if(userFreq > _notesFreq![mid - 1]){
          break;
        }
        max = mid - 1;
      }
    }

    if (mid > 0) {
      double lowerAbs = (_notesFreq![mid - 1] - userFreq).abs();
      double higherAbs = (_notesFreq![mid] - userFreq).abs();

      if(mid == _notesFreq!.length - 1){
        double tolerance = (_notesFreq![mid] - _notesFreq![mid - 1]) / 2;
        if(tolerance < higherAbs) { // tolerance f[len] - f[len-1] / 2
          return Note.NULL;
        }
      }

      if (lowerAbs < higherAbs) {
        return _notesList![mid - 1];
      } else {
        return _notesList![mid];
      }

    }

    if (mid == 0) {
      double lowerAbs = (_notesFreq![mid] - userFreq).abs();
      double higherAbs = (_notesFreq![mid + 1] - userFreq).abs();
      double tolerance = (_notesFreq![mid + 1] - _notesFreq![mid]) / 2;

      if(lowerAbs > tolerance){ // tolerance f[1] - f[0] / 2
        return Note.NULL;
      }

      if (lowerAbs < higherAbs) {
        return _notesList![mid];
      } else {
        return _notesList![mid + 1];
      }
    }

    return Note.NULL;
  }

  Note findClosestNoteFromAll(double userFreq) {
    int mid = 0;
    int min = 0;
    int max = _allFreq!.length - 1;

    while (max >= min) {


      mid = ((max + min) / 2).floor();
      // print("mid: $mid");
      // print("min: $min");
      // print("max: $max");
      // print(_allFreq![mid]);
      // print("------");

      if (userFreq == _allFreq![mid]) {
        return _allNotes![mid];
      } else if (userFreq > _allFreq![mid]) {
        min = mid + 1;
      } else {
        if(mid == 0) {
          break;
        }
        if(userFreq > _allFreq![mid - 1]){
          break;
        }
        max = mid - 1;
      }
    }

    if (mid == _allFreq!.length - 1) { //TODO: sprawdzic warunek na tolerance nizej
      double lowerAbs = (_allFreq![mid - 1] - userFreq).abs();
      double higherAbs = (_allFreq![mid] - userFreq).abs();
      double tolerance = (_allFreq![mid] - _allFreq![mid - 1]) / 2;

      if(higherAbs > tolerance && lowerAbs > tolerance){ // tolerance f[36] - f[35] / 2
        return Note.NULL;
      }

      if (lowerAbs < higherAbs) {
        return _allNotes![mid - 1];
      } else {
        return _allNotes![mid];
      }
    }

    if (mid > 0) {
      double lowerAbs = (_allFreq![mid - 1] - userFreq).abs();
      double higherAbs = (_allFreq![mid] - userFreq).abs();

      if(mid == _allFreq!.length - 1){
        double tolerance = (_allFreq![mid] - _allFreq![mid - 1]) / 2;
        if(tolerance < higherAbs) { // tolerance f[len] - f[len-1] / 2
          return Note.NULL;
        }
      }

      if (lowerAbs < higherAbs) {
        return _allNotes![mid - 1];
      } else {
        return _allNotes![mid];
      }

    }

    if (mid == 0) {
      double lowerAbs = (_allFreq![mid] - userFreq).abs();
      double higherAbs = (_allFreq![mid + 1] - userFreq).abs();
      double tolerance = (_allFreq![mid + 1] - _allFreq![mid]) / 2;

      if(lowerAbs > tolerance){ // tolerance f[1] - f[0] / 2
        return Note.NULL;
      }

      if (lowerAbs < higherAbs) {
        return _allNotes![mid];
      } else {
        return _allNotes![mid + 1];
      }
    }

    return Note.NULL;
  }
}