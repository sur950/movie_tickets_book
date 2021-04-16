import 'package:movie_tickets_book/core.dart';

class TicketsLayout {
  TicketsLayout._();
  static TicketsLayout _instance = TicketsLayout._();
  factory TicketsLayout() => _instance;

  Widget greyChair(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        child: SvgPicture.asset(AllImagesAndVideos().chairLight),
      ),
    );
  }

  Widget redChair(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.error),
        child: SvgPicture.asset(AllImagesAndVideos().chairLight),
      ),
    );
  }

  Widget whiteChair(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        child: SvgPicture.asset(AllImagesAndVideos().chairDark),
      ),
    );
  }

  Widget yellowChair(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
        child: SvgPicture.asset(AllImagesAndVideos().chairDark),
      ),
    );
  }

  Widget genresFormat(List<String> genres, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(genres.length, (index) {
        return (index < genres.length - 1)
            ? Row(
                children: <Widget>[
                  Text(
                    genres[index],
                    style: TextStyle(color: color, fontSize: 12),
                  ),
                  Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              )
            : Text(genres[index], style: TextStyle(color: color, fontSize: 12));
      }),
    );
  }

  Widget starRating(double rating, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return (index < (rating / 2).round())
            ? _star(true, context)
            : _star(false, context);
      }),
    );
  }

  Widget _star(bool fill, BuildContext context) {
    return Container(
      child: Icon(
        Icons.star,
        size: 18,
        color: fill ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
    );
  }
}
