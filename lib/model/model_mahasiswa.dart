class ModelMahasiswa {
  int _id;
  String _firstName;
  String _lastName;
  String _nim;
  String _jurusan;
  String _prodi;
  String _email;

  ModelMahasiswa(this._firstName, this._lastName, this._nim, this._jurusan,
      this._prodi, this._email);

  ModelMahasiswa.map(dynamic mhs) {
    this._id = mhs['id'];
    this._firstName = mhs['firstname'];
    this._lastName = mhs['lastname'];
    this._nim = mhs['nim'];
    this._jurusan = mhs['jurusan'];
    this._prodi = mhs['prodi'];
    this._email = mhs['email'];
  }

  int get id => _id;
  String get firstname => _firstName;
  String get lastname => _lastName;
  String get nim => _nim;
  String get jurusan => _jurusan;
  String get prodi => _prodi;
  String get email => _email;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstname'] = _firstName;
    map['lastname'] = _lastName;
    map['nim'] = _nim;
    map['jurusan'] = _jurusan;
    map['prodi'] = _prodi;
    map['email'] = _email;
    return map;
  }

  ModelMahasiswa.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstname'];
    this._lastName = map['lastname'];
    this._nim = map['nim'];
    this._jurusan = map['jurusan'];
    this._prodi = map['prodi'];
    this._email = map['email'];
  }
}
