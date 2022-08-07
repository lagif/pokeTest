import 'package:flutter/foundation.dart';
import 'package:poketest/model/pokemon.dart';
import 'package:poketest/repository/pokemons_repository.dart';

class PokemonScreenViewModel extends ChangeNotifier {
  final PokemonsRepository _pokemonsRepository;

  PokemonScreenViewModel(this._pokemonsRepository);

  Pokemon? _pokemon;
  Pokemon? get pokemon => _pokemon;
  bool _loading = false;
  bool get isLoading => _loading;

  Future<void> updatePokemon(String newName) async {
    try {
      _loading = true;
      notifyListeners();
      _pokemon = await _pokemonsRepository.getPokemon(newName);
      _loading = false;
     notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  refresh() {
    if (pokemon != null && pokemon?.name != null) {
      updatePokemon(pokemon!.name!);
    }
  }

}