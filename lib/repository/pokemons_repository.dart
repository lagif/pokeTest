import 'package:poketest/api/api_client.dart';
import 'package:poketest/api/app_config.dart';
import 'package:poketest/model/page.dart';
import 'package:dio/dio.dart';
import 'package:poketest/model/pokemon.dart';
import 'package:logger/logger.dart';

abstract class PokemonsRepository {
  Future<PokePage> getPokemons({int offset = 0, int limit = AppConfig.pageSize });
  Future<Pokemon> getPokemon(String name);
}

class PokemonsRepositoryImpl implements PokemonsRepository {

  final _logger = Logger();
  late final ApiClient _apiClient;

  PokemonsRepositoryImpl(this._apiClient);

  @override
  Future<PokePage> getPokemons({int offset = 0, int limit = AppConfig.pageSize }) async {
    _logger.log(Level.info, "Getting page on offset $offset with limit $limit");
    return await _apiClient.getPokemons(offset: offset, limit: limit).catchError((Object e) => _handleErrors(e));
  }

  @override
  Future<Pokemon> getPokemon(String name) async {
    _logger.log(Level.info, "Getting $name");
    return await _apiClient.getPokemon(name).catchError((Object e) => _handleErrors(e));
  }

  _handleErrors(Object error) {
    switch (error.runtimeType) {
      case DioError:
        final res = (error as DioError).response;
        _logger.e("Got error : ${res?.statusCode} -> ${res?.statusMessage}");
        break;
      default:
        throw error;
    }
  }

}