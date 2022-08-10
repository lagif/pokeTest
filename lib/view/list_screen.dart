import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:poketest/model/page.dart';
import 'package:poketest/view/list_screen_viewmodel.dart';
import 'package:poketest/view/pokemon_screen_viewmodel.dart';
import 'package:poketest/view/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


class PokeListScreen extends StatefulWidget {
  const PokeListScreen({Key? key}) : super(key: key);

  @override
  PokeListScreenState createState() => PokeListScreenState();

}


class PokeListScreenState extends State<PokeListScreen>  {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListScreenViewModel>.value(
        value: context.watch<ListScreenViewModel>(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Pokemons'),
            ),
            body: SafeArea(child: _contents(context))
        )
    );
  }

  Widget _contents(BuildContext context) {
    return LazyLoadScrollView(
      scrollOffset: 100,
      isLoading: Provider.of<ListScreenViewModel>(context, listen: false).isLoading,
      onEndOfPage: () => Provider.of<ListScreenViewModel>(context, listen: false).getPokemons(),
      child: RefreshIndicator(
        onRefresh: () => Provider.of<ListScreenViewModel>(context, listen: false).refresh(),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            List<PokemonShort> pokemons = Provider.of<ListScreenViewModel>(context, listen: false).pokemons;
            return _listItem(context, pokemons[index], index + 1);
          },
          itemCount: Provider.of<ListScreenViewModel>(context, listen: false).pokemons.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(color: CustomColors.deepPurple,);
          },
        ),
      ),
    );
  }

  Widget _listItem(BuildContext context, PokemonShort pokemon, int index) {
    return ListTile(
      title: Text(
        "$index. ${pokemon.name ?? ""}",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: const Icon(Icons.account_circle_outlined, color: CustomColors.deepPurple),
      onTap: () {
        Provider.of<PokemonScreenViewModel>(context, listen: false).updatePokemon(pokemon.name ?? "");
        Navigator.pushNamed(context, "PokemonScreen");
      },
    );
  }
}
