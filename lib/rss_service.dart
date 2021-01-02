import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class RssService {
  final _guncel_url = "https://www.aa.com.tr/tr/rss/default?cat=guncel";
  final _spor_url = "https://www.aa.com.tr/tr/rss/default?cat=spor";
  final _ekonomi_url = "https://www.aa.com.tr/tr/rss/default?cat=ekonomi";
  final _saglik_url = "https://www.aa.com.tr/tr/rss/default?cat=saglik" ;
  final _turkiye_url = "https://www.aa.com.tr/tr/rss/default?cat=turkiye";
  final _egitim_url = "https://www.aa.com.tr/tr/rss/default?cat=egitim";
  final _dunya_url = "https://www.aa.com.tr/tr/rss/default?cat=dunya" ;

  Future<RssFeed> guncelHaberler() =>
      http.read(_guncel_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> dunyaHaberler() =>
      http.read(_dunya_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> turkiyeHaberleri() =>
      http.read(_turkiye_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> sporHaberler() =>
      http.read(_spor_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> ekonomiHaberleri() =>
      http.read(_ekonomi_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> saglikHaberleri() =>
      http.read(_saglik_url).then((xmlString) => RssFeed.parse(xmlString));

  Future<RssFeed> egitimHaberleri() =>
      http.read(_egitim_url).then((xmlString) => RssFeed.parse(xmlString));

}