import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http_services.dart';
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
      final word = await _repository.getWord(query.text, context);
      if (word == null) {
        emit(ErrorState('No Input', context, Icons.remove_shopping_cart));
        emit(NoWordSearchState());
      } else {
        emit(WordSearchedState(word));
        emit(NoWordSearchState());
      }
    } on SocketException catch (e) {
      emit(ErrorState(e.toString(), context, Icons.wifi_off));
      emit(NoWordSearchState());
    } on HttpService catch (e) {
      emit(ErrorState(e.toString(), context, Icons.http_outlined));
      emit(NoWordSearchState());
    } on FormatException catch (e) {
      emit(ErrorState(e.toString(), context, Icons.error));
      emit(NoWordSearchState());
    }
  }
}
