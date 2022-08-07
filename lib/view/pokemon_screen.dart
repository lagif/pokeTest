import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:poketest/model/pokemon.dart';
import 'package:poketest/view/pokemon_screen_viewmodel.dart';
import 'package:poketest/view/utils/theme.dart';
import 'package:provider/provider.dart';


class PokemonScreen extends StatefulWidget {
  const PokemonScreen({Key? key}) : super(key: key);

  @override
  PokemonScreenState createState() => PokemonScreenState();

}

class PokemonScreenState extends State<PokemonScreen> {

  final CarouselController _buttonCarouselController = CarouselController();

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
    return ChangeNotifierProvider<PokemonScreenViewModel>.value(
        value: context.watch<PokemonScreenViewModel>(),
        child: Scaffold(
            appBar: AppBar(
              title: Text(Provider.of<PokemonScreenViewModel>(context, listen: false).pokemon?.name ?? ""),
            ),
            body: _contents(context)
        )
    );
  }

  Widget _contents(BuildContext context) {
    final Pokemon? pokemon = Provider.of<PokemonScreenViewModel>(context, listen: false).pokemon;
    if (pokemon == null) {
      return const SizedBox.shrink();
    }
    if (Provider.of<PokemonScreenViewModel>(context, listen: false).isLoading) {
      return Container(
      child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              Center(
                child: CircularProgressIndicator(
                  strokeWidth: CustomTheme.circleSpinnerStroke,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          )
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImageCarousel(pokemon),
        _listItem(context, "Height", "${pokemon.height ?? ""}"),
        _listItem(context, "Weight", "${pokemon.weight ?? ""}"),
      ],
    );
  }

  Widget _buildImageCarousel(Pokemon? pokemon) {
    final Sprites? sprites = pokemon?.sprites;
    if (sprites == null) {
      return const SizedBox.shrink();
    }

    var images = [
      sprites.front_default,
      sprites.back_default,
      sprites.back_female,
      sprites.back_shiny,
      sprites.back_shiny_female,
      sprites.front_female,
      sprites.front_shiny,
      sprites.front_shiny_female
    ].where((element) => element != null).toList();

    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          viewportFraction: 0.5,
          aspectRatio: 2.0,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true
      ),
      carouselController: _buttonCarouselController,
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: _buildNetworkImage(i ?? ""),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildNetworkImage(String imageUrl) {
    return Image.network(
      imageUrl,
      fit: BoxFit.fitWidth,
      loadingBuilder: (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }else {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        }
      },
    );
  }

  Widget _listItem(BuildContext context, String? leading, String? title) {
    return ListTile(
      title: Text(
        title ?? "",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: Text(
        leading ?? "",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}