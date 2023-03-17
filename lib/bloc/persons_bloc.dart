
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import '../model.dart';

part 'persons_event.dart';
part 'persons_state.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {

  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          // we have the value in the _cache
          final cachedPersons = _cache[url];
          final result = FetchResult(
            persons: cachedPersons!,
            isRetrivedFromeCache: true,
          );
          emit(result);
        } else {
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;
          final result = FetchResult(
            persons: persons,
            isRetrivedFromeCache: false,
          );
          emit(result);
        }
      },
    );
  }
}
