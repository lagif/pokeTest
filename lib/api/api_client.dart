import 'package:poketest/api/app_config.dart';
import 'package:poketest/model/page.dart';
import 'package:poketest/model/pokemon.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/pokemon")
  Future<PokePage> getPokemons({@Query("offset") int offset = 0, @Query("limit") int limit = AppConfig.pageSize});

  @GET("/pokemon/{name}")
  Future<Pokemon> getPokemon(@Path() String name);

}
