import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:person_app_with_bloc/bloc/persons_bloc.dart';
import 'package:person_app_with_bloc/load_action.dart';
import 'package:person_app_with_bloc/repository.dart';
import 'dart:developer'  as devtools show log;
void main() {
  runApp(const MyApp());
  
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

extension Log on Object{
  void log() => devtools.log(toString());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons App with Bloc'),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<PersonsBloc>()
                        .add(LoadPersonsAction(url: PersonsUrl.person1));
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Load json #1'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context
                        .read<PersonsBloc>()
                        .add(LoadPersonsAction(url: PersonsUrl.person2));
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Load json #2'),
                ),
              ],
            ),
            BlocBuilder<PersonsBloc, FetchResult?>(
              buildWhen: (previousResult, currentResult) {
                return previousResult?.persons != currentResult?.persons;
              },
              builder: (_, fetchResult) {
                final persons = fetchResult?.persons;
                fetchResult?.log();
                if (persons == null) {
                  return const Center(
                    child: Text('Load data using buttons'),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: persons.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          title: Text('Name: ${persons[index]?.name}'),
                          trailing: Text('Age: ${persons[index]?.age}'),
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
