class Where{
  String _where, _what, _date;
  int _id;

  Where(this._where, this._what, this._date, this._id);

  String get where => _where;

  set where(String value) {
    _where = value;
  }

  get what => _what;

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  get date => _date;

  set date(value) {
    _date = value;
  }

  set what(value) {
    _what = value;
  }
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['what'] = _what;
    map['where'] = _where;
    map['date'] = _date;

    return map;
  }

  // Extract a Note object from a Map object
  Where.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._what = map['what'];
    this._where = map['where'];
    this._date = map['date'];
  }
}