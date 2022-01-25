class Note {
  final double _value;
  final String _name;

  const Note._internal(this._name, this._value);

  @override
  toString() => _name;


  @override
  bool operator ==(Object other) {
    if (other is Note) {
      return (other.freq() == _value);
    }

    final o = other as double;
    return (o == _value);
  }

  double freq(){
    return _value;
  }

  static List<double> getNotesFrequencies(List<Note> notes){
    List<double> freqList = [];
    notes.forEach((note) {
        freqList.add(note.freq());
      });
    return freqList;
  }

  static List<Note> getNotesList(List octaves){
    List<Note> notesList = [];
    octaves.forEach((element) {
      element.forEach((note) {
        notesList.add(note);
      });
    });
    return notesList;
  }


  static const OCTAVE2 = [E2, F2, FsGb2, G2, GsAb2, A2, AsBb2, B2];
  static const OCTAVE3 = [C3, CsDb3, D3, DsEb3, E3, F3, FsGb3, G3, GsAb3, A3, AsBb3, B3];
  static const OCTAVE4 = [C4, CsDb4, D4, DsEb4, E4, F4, FsGb4, G4, GsAb4, A4, AsBb4, B4];
  static const OCTAVE5 = [C5, CsDb5, D5, DsEb5, E5];
  static const OCTAVE6 = [C6, CsDb6, D6, DsEb6, E6, F6, FsGb6, G6, GsAb6, A6, AsBb6, B6];

  static const FRET1 = [F2, AsBb2, DsEb3, GsAb3, C4, F4];
  static const FRET2 = [FsGb2, B2, E3, A3, CsDb4, FsGb4];
  static const FRET3 = [G2, C3, F3, AsBb3, D4, G4];
  static const FRET4 = [GsAb2, CsDb3, FsGb3, B3, DsEb4, GsAb4];
  static const FRET5 = [A2, D3, G3, C4, E4, A4];
  static const FRET6 = [AsBb2, DsEb3, GsAb3, CsDb4, F4, AsBb4];
  static const FRET7 = [B2, E3, A3, D4, FsGb4, B4];
  static const FRET8 = [C3, F3, AsBb3, DsEb4, G4, C5];
  static const FRET9 = [CsDb3, FsGb3, B3, E4, GsAb4, CsDb5];
  static const FRET10 = [D3, G3, C4, F4, A4, D5];
  static const FRET11 = [DsEb3, GsAb3, CsDb4, FsGb4, AsBb4, DsEb5];
  static const FRET12 = [E3, A3, D4, G4, B4, E5];

  static const NULL = Note._internal('-', 0);

  // PART OF OCTAVE 2
  static const E2 = Note._internal('E2', 82.41);
  static const F2 = Note._internal('F2', 87.31);
  static const FsGb2 = Note._internal('F♯2 / G♭2', 92.50);
  static const G2 = Note._internal('G2', 98.0);
  static const GsAb2 = Note._internal('G♯2 / A♭2', 103.83);
  static const A2 = Note._internal('A2', 110.0);
  static const AsBb2 = Note._internal('A♯2 / B♭2', 116.54);
  static const B2 = Note._internal('B2', 123.47);

  // OCTAVE 3
  static const C3 = Note._internal('C3', 130.81);
  static const CsDb3 = Note._internal('C♯3 / D♭3', 138.59);
  static const D3 = Note._internal('D3', 146.83);
  static const DsEb3 = Note._internal('D♯3 / E♭3', 155.56);
  static const E3 = Note._internal('E3', 164.81);
  static const F3 = Note._internal('F3', 174.61);
  static const FsGb3 = Note._internal('F♯3 / G♭3', 185.0);
  static const G3 = Note._internal('G3', 196.0);
  static const GsAb3 = Note._internal('G♯3 / A♭3', 207.65);
  static const A3 = Note._internal('A3', 220.0);
  static const AsBb3 = Note._internal('A♯3 / B♭3', 233.08);
  static const B3 = Note._internal('B3', 246.94);

  // OCTAVE 4
  static const C4 = Note._internal('C4', 261.63);
  static const CsDb4 = Note._internal('C♯4 / D♭4', 277.18);
  static const D4 = Note._internal('D4', 293.66);
  static const DsEb4 = Note._internal('D♯4 / E♭4', 311.13);
  static const E4 = Note._internal('E4', 329.63);
  static const F4 = Note._internal('F4', 349.23);
  static const FsGb4 = Note._internal('F♯4 / G♭4', 369.99);
  static const G4 = Note._internal('G4', 392.0);
  static const GsAb4 = Note._internal('G♯4 / A♭4', 415.30);
  static const A4 = Note._internal('A4', 440.0);
  static const AsBb4 = Note._internal('A♯4 / B♭4', 466.16);
  static const B4 = Note._internal('B4', 493.88);

  // OCTAVE 5
  static const C5 = Note._internal('C5', 523.25);
  static const CsDb5 = Note._internal('C♯5 / D♭5', 554.37);
  static const D5 = Note._internal('D5', 587.33);
  static const DsEb5 = Note._internal('D♯5 / E♭5', 622.25);
  static const E5 = Note._internal('E5', 659.25);
  static const F5 = Note._internal('F5', 698.46);
  static const FsGb5 = Note._internal('F♯5 / G♭5', 739.99);
  static const G5 = Note._internal('G5', 783.99);
  static const GsAb5 = Note._internal('G♯5 / A♭5', 830.61);
  static const A5 = Note._internal('A5', 880.00);
  static const AsBb5 = Note._internal('A♯5 / B♭5', 932.33);
  static const B5 = Note._internal('B5', 987.77);

  // OCTAVE 6
  static const C6 = Note._internal('C6', 1046.50);
  static const CsDb6 = Note._internal('C♯6 / D♭6', 1108.73);
  static const D6 = Note._internal('D6', 1174.66);
  static const DsEb6 = Note._internal('D♯6 / E♭6', 1244.51);
  static const E6 = Note._internal('E6', 1318.51);
  static const F6 = Note._internal('F6', 1396.91);
  static const FsGb6 = Note._internal('F♯6 / G♭6', 1479.98);
  static const G6 = Note._internal('G6', 1567.98);
  static const GsAb6 = Note._internal('G♯6 / A♭6', 1661.22);
  static const A6 = Note._internal('A6', 1760.0);
  static const AsBb6 = Note._internal('A♯6 / B♭6', 1864.66);
  static const B6 = Note._internal('B6', 1975.53);

}