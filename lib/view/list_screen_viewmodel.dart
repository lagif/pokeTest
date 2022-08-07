import 'package:flutter/foundation.dart';
import 'package:poketest/api/app_config.dart';
import 'package:poketest/model/page.dart';
import 'package:poketest/repository/pokemons_repository.dart';

class ListScreenViewModel extends ChangeNotifier {
  final PokemonsRepository _pokemonsRepository;
  PokePage currentPage = PokePage.empty();

  ListScreenViewModel(this._pokemonsRepository) {
    getPokemons();
  }

  List<PokemonShort> _pokemons = [];
  List<PokemonShort> get pokemons => _pokemons;
  bool _loading = false;
  bool get isLoading => _loading;
  bool get isFinish => currentPage.isLast() || (currentPage.count <= _pokemons.length && currentPage.count > 0);

  Future<bool> getPokemons() async {
    try {
      if (currentPage.isEmpty()) {
        _pokemons = [];
      }

      if (isFinish) {
        return false;
      }

      final offset = currentPage.isEmpty() ? 0 : currentPage.nextParameter("offset");
      final limit = currentPage.isEmpty() ? AppConfig.pageSize : currentPage.nextParameter("limit");

      _loading = true;
      notifyListeners();

      currentPage = await _pokemonsRepository.getPokemons(offset: offset, limit: limit);
      _pokemons.addAll(currentPage.results);

      _loading = false;
       notifyListeners();

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void>refresh() async {
    currentPage = PokePage.empty();
    _pokemons = [];
    await getPokemons();
  }
}