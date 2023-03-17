import 'dart:convert';
import 'dart:io';
import 'model.dart';


Future<Iterable<Person>> getPerson(String url) async => await HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => jsonDecode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));


