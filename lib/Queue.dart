import 'package:flutter/material.dart';
import 'package:flutter_swipable/flutter_swipable.dart';
import 'package:moovi/Movie.dart';
import 'Movie.dart';
import 'MovieCard.dart';

class Queue extends StatefulWidget {
  const Queue({Key? key}) : super(key: key);

  @override
  _QueueState createState() => _QueueState();
}

class _QueueState extends State<Queue> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  //movie list as a field? get using Chris's generateQueue()

  //These are just sample cards for now
  List<MovieCard> cardsList = [
    MovieCard(Movie("2001: A Space Odyssey","https://m.media-amazon.com/images/M/MV5BMmNlYzRiNDctZWNhMi00MzI4LThkZTctMTUzMmZkMmFmNThmXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_UX67_CR0,0,67,98_AL_.jpg","G",8.3,"149 min","Adventure, Sci-Fi", "After discovering a mysterious artifact buried beneath the Lunar surface, mankind sets off on a quest to find its origins with help from intelligent supercomputer H.A.L. 9000.")),
    MovieCard(Movie("Howl's Moving Castle","https://m.media-amazon.com/images/M/MV5BNmM4YTFmMmItMGE3Yy00MmRkLTlmZGEtMzZlOTQzYjk3MzA2XkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_UX67_CR0,0,67,98_AL_.jpg","PG",8.2,"119 min","Animation, Adventure, Family", "When an unconfident young woman is cursed with an old body by a spiteful witch, her only chance of breaking the spell lies with a self-indulgent yet insecure young wizard and his companions in his legged, walking castle."))
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9, height: MediaQuery.of(context).size.height * 0.7,
        child: Stack(
            children: cardsList
        )
    );
  }

  updateCardsList(){
    //add the next 10 movies to the back of the list
  }
}
