import 'package:flutter/material.dart';

import 'auth.dart';
import 'login_signup.dart';

class Ayarlar extends StatefulWidget {
  static List<String> kategoriler = [
    "guncel",
    "dunya",
    "turkiye",
    "spor",
    "ekonomi",
    "saglik",
    "egitim"
  ];
  Auth authHandler;

  Ayarlar(this.authHandler);

  @override
  _AyarlarState createState() => _AyarlarState();
}

class _AyarlarState extends State<Ayarlar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Geliştirici : Yahya Öztemir", style: TextStyle(fontSize: 24)),
            Text(
              "Hesabınızdan Çıkış Yapmak İçin ",
              style: TextStyle(fontSize: 24),
            ),
            RaisedButton(
              onPressed: () {
                widget.authHandler.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginSignupPage()),
                    (route) => false);
              },
              child: Text("Cikis Yap"),
            ),
          ],
        ),
      ),
    );
  }
}
