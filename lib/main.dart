import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/list_words.dart';
import 'package:framework/word_repository.dart';

import 'dictionaries_cubit/cubit.dart';
import 'dictionaries_cubit/state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DictionariesCubit(WordRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Dictionary(),
      ),
    );
  }
}

class Dictionary extends StatelessWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DictionariesCubit>();
    return BlocListener(
      listener: (context, state) {
        if (state is WordSearchedState) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => ListOfWords(word: state.word),
            ),
          );
        }
      },
      bloc: cubit,
      child: Scaffold(
        backgroundColor: Colors.white38,
        body: cubit.state is WordSearchingState
            ? getLoadingWidget()
            : cubit.state is ErrorState
                ? getErrorWidget('message')
                : cubit.state is NoWordSearchState
                    ? getDictionaryFromWidget(cubit,context)
                    : Container(),
      ),
    );
  }

  getDictionaryFromWidget(DictionariesCubit cubit,context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Dictionary App',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          const Text(
            'Search any word you want quickly ',
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: cubit.query,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {
              cubit.getWordSearched(context);
              cubit.query.clear();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Colors.green,
              ),
            ),
            child: const Text(
              'Search',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  getErrorWidget(message) {
    return Center(
      child: Text(message),
    );
  }
}
