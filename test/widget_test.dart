
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poketest/api/api_client.dart';
import 'package:poketest/api/app_config.dart';
import 'package:poketest/model/page.dart';
import 'package:poketest/model/pokemon.dart';
import 'package:poketest/repository/pokemons_repository.dart';

String _fixture(String name, String path) => File('$path$name').readAsStringSync();

extension Fixture on String {
  Map<String, dynamic> toFixture({String path = 'test/fixtures/'}) =>
      json.decode(_fixture(this, path)) as Map<String, dynamic>;
}

class MockApiClient extends Mock implements ApiClient {}


void main() {
  late PokemonsRepositoryImpl repository;

  final PokePage mockPageZero = PokePage.fromJson('page_zero.json'.toFixture());
  final PokePage mockLastPage = PokePage.fromJson('page_last.json'.toFixture());
  final Pokemon mockPokemonResource = Pokemon.fromJson('ditto.json'.toFixture());

  late ApiClient apiClient;

  setUp(() async {
    registerFallbackValue(Uri());
    apiClient = MockApiClient();
    repository = PokemonsRepositoryImpl(apiClient);
  });

  group('get pokemon pages', () {
    test(
      'should perform a GET request on /pokemon',
          () async {
        when(
              () => apiClient.getPokemons(),
        ).thenAnswer(
              (_) async => mockPageZero,
        );

        final response = await repository.getPokemons();
        // assert
        verify(() => apiClient.getPokemons());
        verifyNoMoreInteractions(apiClient);
        expect(response, mockPageZero);
        expect(response.isFirst(), true);
        expect(response.results.length, 20);
      },
    );

    test(
      'should perform a GET request on /pokemon last page',
          () async {
        when(
              () => apiClient.getPokemons(offset: 1140, limit: AppConfig.pageSize),
        ).thenAnswer(
              (_) async => mockLastPage,
        );

        final response = await repository.getPokemons(offset: 1140, limit: AppConfig.pageSize);
        // assert
        verify(() => apiClient.getPokemons(offset: 1140, limit: AppConfig.pageSize));
        verifyNoMoreInteractions(apiClient);
        expect(response, mockLastPage);
        expect(response.isLast(), true);
        expect(response.results.length, 14);
      },
    );

    test(
      'should perform a GET request on /ditto pokemon',
          () async {
        when(
              () => apiClient.getPokemon("ditto"),
        ).thenAnswer(
              (_) async => mockPokemonResource,
        );

        final response = await repository.getPokemon("ditto");
        // assert
        verify(() => apiClient.getPokemon("ditto"));
        verifyNoMoreInteractions(apiClient);
        expect(response, mockPokemonResource);
        expect(response.name, "ditto");
      },
    );

    test(
      'should perform a GET request on /unknown_pokemon pokemon',
          () async {
        when(
              () => apiClient.getPokemon("unknown_pokemon"),
        ).thenAnswer(
              (_) async { throw Exception(); },
        );

        try {
          await repository.getPokemon("unknown_pokemon");
        } catch (e) {
          // assert
          verify(() => apiClient.getPokemon("unknown_pokemon"));
          expect(apiClient.getPokemon("unknown_pokemon"), throwsException);
        }
      },
    );

  });



}
