import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:person_app_with_bloc/load_action.dart';
import 'package:person_app_with_bloc/repository.dart';

import '../model.dart';

part 'persons_event.dart';
part 'persons_state.dart';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonsUrl, Iterable<Person>> _cache = {};
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
          final persons = await getPerson(url.urlString);
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
