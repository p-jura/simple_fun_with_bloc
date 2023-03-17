import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:person_app_with_bloc/bloc/persons_bloc.dart';

import 'package:person_app_with_bloc/model.dart';

const mockedPersons1 = [
  Person(
    name: 'Name',
    age: 20,
  ),
  Person(
    name: 'Surname',
    age: 30,
  ),
];

const mockedPersons2 = [
  Person(
    name: 'Name',
    age: 20,
  ),
  Person(
    name: 'Surname',
    age: 30,
  ),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons1);

void main() {
  group(
    'testing bloc',
    () {
      late PersonsBloc bloc;
      setUp(
        () {
          bloc = PersonsBloc();
        },
      );
      blocTest<PersonsBloc, FetchResult?>(
        'Should return null as initial state',
        build: () => bloc,
        verify: (bloc) => expect(
          bloc.state,
          null,
        ),
      );
      blocTest<PersonsBloc, FetchResult?>(
        'Should retrieve person from first iterable as FetchResult',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'any',
              loader: mockGetPersons1,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'any',
              loader: mockGetPersons1,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPersons1, isRetrivedFromeCache: false),
          const FetchResult(
              persons: mockedPersons1, isRetrivedFromeCache: true),
        ],
      );
      blocTest<PersonsBloc, FetchResult?>(
        'Should retrieve person from second iterable as FetchResult',
        build: () => bloc,
        act: (bloc) {
          bloc.add(
            const LoadPersonsAction(
              url: 'any',
              loader: mockGetPersons2,
            ),
          );
          bloc.add(
            const LoadPersonsAction(
              url: 'any',
              loader: mockGetPersons2,
            ),
          );
        },
        expect: () => [
          const FetchResult(
              persons: mockedPersons2, isRetrivedFromeCache: false),
          const FetchResult(
              persons: mockedPersons2, isRetrivedFromeCache: true),
        ],
      );
    },
  );
}
