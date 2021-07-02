
import 'package:flutter/cupertino.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.title,
    @required this.image,
    @required this.body,
  });
}

List<BoardingModel> boarding = [
  BoardingModel(
    image: 'assets/images/board1.jpg',
    title: 'YOU CAN',
    body: 'Don’t let mental blocks control you. Set yourself free'
  ),
  BoardingModel(
    image: 'assets/images/board2.jpg',
    title: 'The bird dares to break the shell',
    body: 'When the shell breaks open , the bird can fly openly'
  ),
  BoardingModel(
    image: 'assets/images/board3.jpg',
    title: 'Just be you!',
    body: 'Never allow anyone to define you!',
  ),
];