

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../word_repository.dart';
import '../word_response.dart';
import 'state.dart';

class DictionariesCubit extends Cubit<DictionariesCubitState> {
  final WordRepository _repository;

  DictionariesCubit(this._repository) : super(NoWordSearchState());
  final query = TextEditingController();

  Future getWordSearched(context) async {
    try {
      emit(WordSearchingState());
      final word = await _repository.getWord(query.text,context);
      if (word == null) {
        emit(ErrorState('No Input'));
      } else {

        emit(WordSearchedState(word));
        emit(NoWordSearchState());
      }
    } on Exception catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
