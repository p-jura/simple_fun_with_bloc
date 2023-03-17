part of 'persons_bloc.dart';

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetrivedFromeCache;
  const FetchResult({
    required this.persons,
    required this.isRetrivedFromeCache,
  });
  @override
  String toString() =>
      'FetchResult (isRetrivedFromeCache = $isRetrivedFromeCache), persons $persons';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrivedFromeCache == other.isRetrivedFromeCache;

  @override
  int get hashCode => Object.hash(
        persons,
        isRetrivedFromeCache,
      );
}
