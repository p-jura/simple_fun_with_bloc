// ignore_for_file: constant_identifier_names

part of 'persons_bloc.dart';

@immutable
abstract class LoadAction {
  const LoadAction();
}

// this url adress should be swoped on your local url.
const YOUR_LAN_URL = 'http://192.168.0.10';

const PERSONS1_URL = '$YOUR_LAN_URL:5500/api/persons1.json';
const PERSONS2_URL = '$YOUR_LAN_URL:5500/api/persons2.json';

typedef PersonLoader = Future<Iterable<Person>> Function(String url);


@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonLoader loader;
  const LoadPersonsAction({required this.url, required this.loader}) : super();
}
