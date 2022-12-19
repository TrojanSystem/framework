import '../word_response.dart';

abstract class DictionariesCubitState {}

class NoWordSearchState extends DictionariesCubitState {}

class WordSearchingState extends DictionariesCubitState {}

class WordSearchedState extends DictionariesCubitState {
  final List<WordResponse> word;

  WordSearchedState(this.word);
}

class ErrorState extends DictionariesCubitState {
  final String message;
  ErrorState(this.message);
}
