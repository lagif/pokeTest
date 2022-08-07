import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class Pokemon {
  String? name;
  int? height;
  int? weight;
  int id;
  Sprites sprites;

  Pokemon(
      {required this.name,
      required this.id,
      required this.weight,
      required this.height,
      required this.sprites});

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonToJson(this);
}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class Sprites {
  String? back_default;
  String? back_female;
  String? back_shiny;
  String? back_shiny_female;
  String? front_default;
  String? front_female;
  String? front_shiny;
  String? front_shiny_female;

  Sprites(
      {required this.back_default,
      required this.back_female,
      required this.back_shiny,
      required this.back_shiny_female,
      required this.front_female,
      required this.front_shiny,
      required this.front_shiny_female});

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}
