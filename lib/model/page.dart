import 'package:json_annotation/json_annotation.dart';
import 'package:poketest/api/app_config.dart';

part 'page.g.dart';


@JsonSerializable(explicitToJson: true, includeIfNull: true)
class PokePage {
  String? next;
  int count;
  String? previous;
  List<PokemonShort> results;

  PokePage({required this.count, this.previous, this.next, required this.results});

  factory PokePage.fromJson(Map<String, dynamic> json) => _$PokePageFromJson(json);
  Map<String, dynamic> toJson() => _$PokePageToJson(this);

  factory PokePage.empty() {
    return PokePage(count: 0, previous: null, next: null, results: []);
  }

  bool isLast() => !isEmpty() && (next == null || count == 0);
  bool isFirst() => previous == null;
  bool isEmpty() => previous == null && next == null;

  int nextParameter(String parameter) {
    if (next != null && (next?.isNotEmpty ?? false) ) {
      final uri = Uri.parse(next!);
      return int.parse(uri.queryParameters[parameter] ?? "0");
    }
    return 0;
  }

}

@JsonSerializable(explicitToJson: true, includeIfNull: true)
class PokemonShort {
  String? name;
  String? url;

  PokemonShort({this.name, this.url});

  factory PokemonShort.fromJson(Map<String, dynamic> json) => _$PokemonShortFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonShortToJson(this);

}



