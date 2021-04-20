import 'package:movie_tickets_book/core.dart';

class MoviesData {
  MoviesData._();
  static MoviesData _instance = MoviesData._();
  factory MoviesData() => _instance;

  List<MovieResponse> data = [
    MovieResponse(
      id: 0,
      name: AllConstants().movie1Name,
      rating: AllConstants().movie1Rating,
      genre: [AllConstants().family, AllConstants().adventure],
      storyLine: AllConstants().movie1StoryLine,
      image: Image.asset(AllImagesAndVideos().movie1Poster),
      imageText: Image.asset(AllImagesAndVideos().movie1Banner),
      videoPath: AllImagesAndVideos().movie1Trailer,
      videoReflectionPath: AllImagesAndVideos().movie1TrailerReflection,
      castList: [
        MovieCastResponse(
          name: AllConstants().movie1Cast1Name,
          image: Image.asset(AllImagesAndVideos().movie1Cast1Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie1Cast2Name,
          image: Image.asset(AllImagesAndVideos().movie1Cast2Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie1Cast3Name,
          image: Image.asset(AllImagesAndVideos().movie1Cast3Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie1Cast4Name,
          image: Image.asset(AllImagesAndVideos().movie1Cast4Image),
        )
      ],
    ),
    MovieResponse(
      id: 1,
      name: AllConstants().movie2Name,
      rating: AllConstants().movie2Rating,
      genre: [AllConstants().action, AllConstants().adventure],
      storyLine: AllConstants().movie2StoryLine,
      image: Image.asset(AllImagesAndVideos().movie2Poster),
      imageText: Image.asset(AllImagesAndVideos().movie2Banner),
      videoPath: AllImagesAndVideos().movie2Trailer,
      videoReflectionPath: AllImagesAndVideos().movie2TrailerReflection,
      castList: [
        MovieCastResponse(
          name: AllConstants().movie2Cast1Name,
          image: Image.asset(AllImagesAndVideos().movie2Cast1Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie2Cast2Name,
          image: Image.asset(AllImagesAndVideos().movie2Cast2Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie2Cast3Name,
          image: Image.asset(AllImagesAndVideos().movie2Cast3Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie2Cast4Name,
          image: Image.asset(AllImagesAndVideos().movie2Cast4Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie2Cast5Name,
          image: Image.asset(AllImagesAndVideos().movie2Cast5Image),
        )
      ],
    ),
    MovieResponse(
      id: 2,
      name: AllConstants().movie3Name,
      rating: AllConstants().movie3Rating,
      genre: [AllConstants().action, AllConstants().adventure],
      storyLine: AllConstants().movie3StoryLine,
      image: Image.asset(AllImagesAndVideos().movie3Poster),
      imageText: Image.asset(AllImagesAndVideos().movie3Banner),
      videoPath: AllImagesAndVideos().movie3Trailer,
      videoReflectionPath: AllImagesAndVideos().movie3TrailerReflection,
      castList: [
        MovieCastResponse(
          name: AllConstants().movie3Cast1Name,
          image: Image.asset(AllImagesAndVideos().movie3Cast1Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie3Cast2Name,
          image: Image.asset(AllImagesAndVideos().movie3Cast2Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie3Cast3Name,
          image: Image.asset(AllImagesAndVideos().movie3Cast3Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie3Cast4Name,
          image: Image.asset(AllImagesAndVideos().movie3Cast4Image),
        )
      ],
    ),
    MovieResponse(
      id: 3,
      name: AllConstants().movie4Name,
      rating: AllConstants().movie4Rating,
      genre: [AllConstants().action, AllConstants().adventure],
      storyLine: AllConstants().movie4StoryLine,
      image: Image.asset(AllImagesAndVideos().movie4Poster),
      imageText: Image.asset(AllImagesAndVideos().movie4Banner),
      videoPath: AllImagesAndVideos().movie4Trailer,
      videoReflectionPath: AllImagesAndVideos().movie4TrailerReflection,
      castList: [
        MovieCastResponse(
          name: AllConstants().movie4Cast1Name,
          image: Image.asset(AllImagesAndVideos().movie4Cast1Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie4Cast2Name,
          image: Image.asset(AllImagesAndVideos().movie4Cast2Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie4Cast3Name,
          image: Image.asset(AllImagesAndVideos().movie4Cast3Image),
        ),
        MovieCastResponse(
          name: AllConstants().movie4Cast4Name,
          image: Image.asset(AllImagesAndVideos().movie4Cast4Image),
        )
      ],
    ),
  ];
}
