import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  String firstname, lastname, nim, jurusan, prodi, email;

  DetailPage(
      {this.firstname,
      this.lastname,
      this.nim,
      this.jurusan,
      this.prodi,
      this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'First Name : $firstname',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                Text(
                  'Last Name : $lastname',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                Text(
                  'NIM : $nim',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                Text(
                  'Jurusan : $jurusan',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                Text(
                  'Prodi: $prodi',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 5,),
                Text(
                  'Email : $email',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
      ),
    );
  }
}
