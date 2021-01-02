import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth.dart';
import 'haberler.dart';

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();
  AutovalidateMode modeSingUp = AutovalidateMode.disabled;
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  AutovalidateMode modeLogin = AutovalidateMode.disabled;
  var authHandler = new Auth();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text("Giris Yap"),
                ),
                Tab(
                  child: Text("Kayit Ol"),
                ),
              ],
            ),
            title: Text('Giriş/Kayıt'),
          ),
          body: TabBarView(
            children: [
              getLogin(),
              getSignup(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Column(
        children: [
          Form(
            key: _loginKey,
            autovalidateMode: modeLogin,
            child: Column(
              children: [
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Colors.orange,
                    ),
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (girilenVeri) {
                    if (!girilenVeri.contains("@"))
                      return "Lütfen Bir E-mail Giriniz";
                    else
                      return null;
                  },
                  onSaved: (deger) => _email = deger,
                ),
                SizedBox(height: 40),
                TextFormField(
                  autofocus: false,
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_sharp,
                      color: Colors.orange,
                    ),
                    labelText: "Şifre",
                    border: OutlineInputBorder(),
                  ),
                  validator: (girilenVeri) {
                    if (girilenVeri.length < 6)
                      return "Lütfen 6 Harften Buyuk Şifre Giriniz";
                    else
                      return null;
                  },
                  onSaved: (deger) => _password = deger,
                ),
                SizedBox(
                  height: 40,
                ),
                RaisedButton.icon(
                    onPressed: () {
                      _loginOnayla();
                    },
                    color: Colors.blue,
                    icon: Icon(Icons.login),
                    label: Text("Giriş Yap"))
              ],
            ),
          ),
          SizedBox(height: 40,),
          /*OutlineButton(
            splashColor: Colors.grey,
            onPressed: () {

            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            highlightElevation: 0,
            borderSide: BorderSide(color: Colors.grey),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage("assets/google.png"), height: 35.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )*/
        ],
      ),
    );
  }

  Widget getSignup() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
      child: Form(
        key: _signUpKey,
        autovalidateMode: modeSingUp,
        child: Column(
          children: [
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.orange,
                ),
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              validator: (girilenVeri) {
                if (!girilenVeri.contains("@"))
                  return "Lütfen Bir E-mail Giriniz";
                else
                  return null;
              },
              onSaved: (deger) => _email = deger,
            ),
            SizedBox(height: 40),
            TextFormField(
              autofocus: false,
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_sharp,
                  color: Colors.orange,
                ),
                labelText: "Şifre",
                border: OutlineInputBorder(),
              ),
              validator: (girilenVeri) {
                if (girilenVeri.length < 6)
                  return "Lütfen 6 Harften Buyuk Şifre Giriniz";
                else
                  return null;
              },
              onSaved: (deger) => _password = deger,
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton.icon(
                onPressed: () {
                  _kayitOnayla();
                },
                color: Colors.blue,
                icon: Icon(Icons.save),
                label: Text("Kaydet"))
          ],
        ),
      ),
    );
  }

  void _kayitOnayla() {
    if (_signUpKey.currentState.validate()) {
      _signUpKey.currentState.save();
      authHandler.handleSignUp(_email, _password).then((FirebaseUser user) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => Haberler(authHandler)));
      }).catchError((e) => print(e));
    } else {
      setState(() {
        modeSingUp = AutovalidateMode.always;
      });
    }
  }

  void _loginOnayla() {
    if (_loginKey.currentState.validate()) {
      _loginKey.currentState.save();
      authHandler
          .handleSignInEmail(_email, _password)
          .then((FirebaseUser user) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => Haberler(authHandler)));
      }).catchError((e) => _showMyDialog(e.message));
    } else {
      setState(() {
        modeSingUp = AutovalidateMode.always;
      });
    }
  }

  Future<Null> _showMyDialog(String hata) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hatalı Giriş'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(hata),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
