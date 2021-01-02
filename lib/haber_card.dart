import 'package:flutter/material.dart';
import 'package:news_app/web_view.dart';

class HaberCard extends StatelessWidget {
  final String title;
  final String url;
  final String web_view_url;

  HaberCard({this.title, this.url, this.web_view_url});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WebViewPage(web_view_url,title)));
          },
          child: Stack(
            children: <Widget>[
              Container(
                width: 350,
                height: 380,
                color: Colors.white,
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
