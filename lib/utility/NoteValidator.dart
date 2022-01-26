import 'dart:math';

import 'package:fretapp/utility/Note.dart';

void main() {
  List<Note> notesList = Note.getNotesList([Note.OCTAVE2, Note.OCTAVE3, Note.OCTAVE4, Note.OCTAVE5, Note.OCTAVE6]);

  NoteValidator validator = NoteValidator(notesList);
  print(validator.freqs());
  print(validator.findClosestNote(500.0).freq());
  print(validator.getTarget(Note.NULL));
}

class NoteValidator {
  List<Note>? _notesList;
  List<double>? _notesFreq;

  NoteValidator(List<Note> notesList){
    _notesList =  notesList;
    _notesFreq = Note.getNotesFrequencies(notesList);
  }

  @override
  String toString() {
    return _notesList.toString();
  }

  List<double>? freqs() {
    return _notesFreq;
  }

  Note getTarget(Note currentTarget){
    final _random = Random(); // add to random different than current (Note currentTarget)
    Note next = currentTarget;
    while(next==currentTarget.freq()){
      print('1');
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
}