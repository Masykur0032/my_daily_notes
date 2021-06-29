class Note {
  int _id;
  String _title;
  String _body;
  String _date;

  int get id => _id;

  String get title => this._title;
  set title(String value) => this._title = value;

  String get body => this._body;
  set body(String value) => this._body = value;

  String get date => this._date;
  set date(String value) => this._date = value;

  Note(this._title, this._body, this._date);

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._body = map['body'];
    this._date = map['date'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['body'] = body;
    map['date'] = date;
    return map;
  }
}
