import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sqflitemahasiswa/DetailPage.dart';
import 'package:sqflitemahasiswa/db_helper.dart';
import 'package:sqflitemahasiswa/form_mahasiswa.dart';
import 'package:sqflitemahasiswa/model/model_mahasiswa.dart';

class ListMahasiswa extends StatefulWidget {
  @override
  _ListMahasiswaState createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {
  List<ModelMahasiswa> items = List();
  DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db.getAllMahasiswa().then((mahasiswas) {
      setState(() {
        mahasiswas.forEach((mahasiswa) {
          items.add(ModelMahasiswa.fromMap(mahasiswa));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIST MAHASISWA', style: TextStyle(letterSpacing: 2),),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            contentPadding: EdgeInsets.only(left: 16),
            title: Text(
              '${items[index].firstname} ${items[index].lastname}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            subtitle: Text(
              '${items[index].email}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            onTap: () {
              _navigateToMahasiswa(context, items[index]);
            },
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red,),
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.ERROR,
                  animType: AnimType.BOTTOMSLIDE,
                  title: 'Warning',
                  desc: 'Do You Want to delete ${items[index].firstname}',
                  btnCancelOnPress: (){},
                  btnOkOnPress: () {
                    _deleteMahasiswa(context, items[index], index);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListMahasiswa()));
                  }
                ).show();

//                AlertDialog hapus = AlertDialog(
//                  backgroundColor: Colors.blue,
//                  title: Text('INFORMATION', textAlign: TextAlign.center, style: TextStyle(letterSpacing: 2, color: Colors.white, fontWeight: FontWeight.bold),),
//                  content: Container(
//                    height: 40.0,
//                    child: Column(
//                      children: <Widget>[
//                        Text(
//                            'Apakah anda yakin ingin hapus data ${items[index].firstname}')
//                      ],
//                    ),
//                  ),
//                  actions: <Widget>[
//                    FlatButton(
//                      child: Text('YES'),
//                      onPressed: () {
//                        _deleteMahasiswa(context, items[index], index);
//                        Navigator.pop(context);
//                      },
//                    ),
//                    FlatButton(
//                      child: Text('NO'),
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                    )
//                  ],
//                );
//                showDialog(context: context, child: hapus);
              },
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                            firstname: items[index].firstname,
                            lastname: items[index].lastname,
                            nim: items[index].nim,
                            jurusan: items[index].jurusan,
                            prodi: items[index].prodi,
                            email: items[index].email)));
              },
              icon: Icon(Icons.visibility),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        onPressed: () {
          _createMahasiswa(context);
        },
      ),
    );
  }

  _deleteMahasiswa(
      BuildContext context, ModelMahasiswa mahasiswa, int position) {
    db.deleteMahasiswa(mahasiswa.id).then((mahasiswas) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToMahasiswa(
      BuildContext context, ModelMahasiswa mahasiswa) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormMahasiswa(modelMahasiswa: mahasiswa,
                )));
    if (result == 'update') {
      db.getAllMahasiswa().then((mahasiswas) {
        setState(() {
          items.clear();
          mahasiswas.forEach((mahasiswa) {
            items.add(ModelMahasiswa.fromMap(mahasiswa));
          });
        });
      });
    }
  }

  void _createMahasiswa(BuildContext context) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                FormMahasiswa(modelMahasiswa: ModelMahasiswa('','','','','','')
                )));

    if (result == 'save') {
      db.getAllMahasiswa().then((mahasiswas) {
        setState(() {
          items.clear();
          mahasiswas.forEach((mahasiswa) {
            items.add(ModelMahasiswa.fromMap(mahasiswa));
          });
        });
      });
    }
  }
}
