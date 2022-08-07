import 'package:flutter/material.dart';
import 'package:poketest/repository/pokemons_repository.dart';
import 'package:poketest/view/list_screen.dart';
import 'package:poketest/view/list_screen_viewmodel.dart';
import 'package:poketest/view/pokemon_screen.dart';
import 'package:poketest/view/pokemon_screen_viewmodel.dart';
import 'package:poketest/view/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(app());
}

Widget app() {
  return MultiProvider(
    providers: [
      Provider<PokemonsRepository>(
        create: (BuildContext context) => PokemonsRepositoryImpl(Dio()),
      ),
      ChangeNotifierProvider<ListScreenViewModel>(
          create: (BuildContext context) => ListScreenViewModel(context.read())),
      ChangeNotifierProvider<PokemonScreenViewModel>(
          create: (BuildContext context) => PokemonScreenViewModel(context.read()))
    ],
    child: const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "",
      theme: CustomTheme.defaultTheme,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const PokeListScreen(),
        'PokemonScreen': (_) => const PokemonScreen()
      },
    );
  }
}