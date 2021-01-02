import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/haber_card.dart';
import 'package:news_app/rss_service.dart';
import 'package:webfeed/domain/rss_feed.dart';

class KategoriHaber extends StatefulWidget {
  final String secim;
  KategoriHaber(this.secim);

  @override
  _KategoriHaberState createState() => _KategoriHaberState();
}

class _KategoriHaberState extends State<KategoriHaber> {

  RssService rss ;
  Future<RssFeed> future ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rss=RssService();
    future = rss.guncelHaberler();
  }

  @override
  void didUpdateWidget(KategoriHaber oldWidget) {
    switch(widget.secim)
    {
      case "guncel":
        future = rss.guncelHaberler();
        break;
      case "dunya":
        future = rss.dunyaHaberler();
        break;
      case "turkiye":
        future = rss.turkiyeHaberleri();
        break;
      case "spor":
        future = rss.sporHaberler();
        break;
      case "ekonomi":
        future = rss.ekonomiHaberleri();
        break;
      case "saglik":
        future = rss.saglikHaberleri();
        break;
      case "egitim":
        future = rss.egitimHaberleri();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.secim[0].toUpperCase() + widget.secim.substring(1) + " Haberler",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: future,
            // ignore: missing_return
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                          itemCount: snapshot.data.items.length,
                          itemBuilder: (context, index) {
                            final feed = snapshot.data.items[index];
                            return HaberCard(
                                title: feed.title, url: feed.imageUrl,web_view_url: feed.link,);
                          });
                    }
                  }
                  break;
                case ConnectionState.none:
                case ConnectionState.active:
                case ConnectionState.waiting:
                default:
                  return Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ),
      ],
    );
  }
}
