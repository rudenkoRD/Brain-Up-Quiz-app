class Pair extends Object{
  String _first, _second;
  Pair(this._first, this._second);

  String get first => _first;
  String get second => _second;

  set first(newValue) => _first = newValue;
  set second(newValue) => _second = newValue;

  @override
  String toString() {
    return '{$_first : $_second}';
  }
}