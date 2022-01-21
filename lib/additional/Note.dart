class Note {
  final _value;
  const Note._internal(this._value);
  const Note(this._value);

  @override
  toString() => '$_value';

  static bool compare(double freq, Note target){
    return (freq == target._value);
  }

  static const E2 = const Note._internal(82.41);
  static const F2 = const Note._internal(87.31);
  static const Gb2= const Note._internal(92.50);
  static const G2 = const Note._internal(98.00);

  static const A4 = const Note._internal(440.00);

}