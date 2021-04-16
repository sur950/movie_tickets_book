import 'package:flutter/material.dart';

class MovieResponse {
  int id;
  String name;
  List<String> genre;
  double rating;
  String storyLine;
  Image image;
  Image imageText;
  String videoPath;
  String videoReflectionPath;
  List<MovieCastResponse> castList = <MovieCastResponse>[];

  MovieResponse({
    this.id,
    this.genre,
    this.name,
    this.rating,
    this.storyLine,
    this.image,
    this.imageText,
    this.castList,
    this.videoPath,
    this.videoReflectionPath,
  });
}

class MovieCastResponse {
  String name;
  Image image;

  MovieCastResponse({this.name, this.image});
}
