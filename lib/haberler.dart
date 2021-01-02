import 'package:flutter/material.dart';
import 'package:news_app/kategori_haber.dart';
import 'auth.dart';
import 'ayar.dart';

class Haberler extends StatefulWidget {
  Auth authHandler ;
  Haberler(this.authHandler);

  @override
  _HaberlerState createState() => _HaberlerState();
}

class _HaberlerState extends State<Haberler> {
  String secim = "guncel";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(),
      appBar: AppBar(
        title: Text("Haberler"),
        actions: [

          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Ayarlar(widget.authHandler)));
            },
            icon: Icon(Icons.settings, size: 35,),
            padding: EdgeInsets.only(right: 15),
          ),
        ],
      ),
      body: KategoriHaber(secim),
    );
  }

  Drawer getDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: CircleAvatar(
              child: Text("Kategoriler"),
              radius: 50,
              backgroundColor: Colors.grey,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Ayarlar.kategoriler.length,
              itemBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          secim = Ayarlar.kategoriler[index];
                          Navigator.pop(context);
                        });
                      },
                      leading: Image.asset(
                        "assets/" + Ayarlar.kategoriler[index] + ".png",
                        fit: BoxFit.contain,
                      ),
                      title: Text(Ayarlar.kategoriler[index][0].toUpperCase() +
                          Ayarlar.kategoriler[index].substring(1)),
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
            ),
          )
        ],
      ),
    );
  }
}
