import 'package:flutter/material.dart';
import 'file:///D:/FlutterProject/sqflite_mahasiswa/lib/helper/db_helper.dart';
import 'package:sqflitemahasiswa/model/model_mahasiswa.dart';

class FormMahasiswa extends StatefulWidget {
  final ModelMahasiswa modelMahasiswa;
  FormMahasiswa({this.modelMahasiswa});
  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DatabaseHelper db = DatabaseHelper();
  TextEditingController _firstname;
  TextEditingController _lastname;
  TextEditingController _nim;
  TextEditingController _jurusan;
  TextEditingController _prodi;
  TextEditingController _email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firstname = TextEditingController(text: widget.modelMahasiswa.firstname);
    _lastname = TextEditingController(text: widget.modelMahasiswa.lastname);
    _nim = TextEditingController(text: widget.modelMahasiswa.nim);
    _jurusan = TextEditingController(text: widget.modelMahasiswa.jurusan);
    _prodi = TextEditingController(text: widget.modelMahasiswa.prodi);
    _email = TextEditingController(text: widget.modelMahasiswa.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
        backgroundColor: Colors.pink,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: _firstname,
            decoration: InputDecoration(
                labelText: 'First Name',),
          ),
          TextField(
            controller: _lastname,
            decoration: InputDecoration(
                labelText: 'Last Name',),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: _nim,
            decoration: InputDecoration(
                labelText: 'NIM',),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _jurusan,
            decoration: InputDecoration(
                labelText: 'Jurusan',),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _prodi,
            decoration: InputDecoration(
                labelText: 'Prodi',),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
                labelText: 'Email',),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton(
            color: Colors.cyan,
            child: (widget.modelMahasiswa.id != null)
                ? Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  )
                : Text(
                    'Add',
                    style: TextStyle(color: Colors.white),
                  ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              if (widget.modelMahasiswa.id != null) {
                db
                    .updateMahasiswa(ModelMahasiswa.fromMap({
                  'id': widget.modelMahasiswa.id,
                  'firstname': _firstname.text,
                  'lastname': _lastname.text,
                  'nim': _nim.text,
                  'jurusan': _jurusan.text,
                  'prodi': _prodi.text,
                  'email': _email.text
                }))
                    .then((_) {
                  Navigator.pop(context, 'update');
                });
              } else {
                db
                    .saveMahasiswa(ModelMahasiswa(
                        _firstname.text,
                        _lastname.text,
                        _nim.text,
                        _jurusan.text,
                        _prodi.text,
                        _email.text))
                    .then((_) {
                  Navigator.pop(context, 'save');
                });
              }
            },
          )
        ],
      ),
    );
  }
}
