import 'package:movie_tickets_book/core.dart';

class Details extends StatefulWidget {
  final MovieResponse movie;
  final Size size;
  const Details({Key key, this.movie, this.size}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  Size get _size => MediaQuery.of(context).size;
  RubberAnimationController _rubberAnimationController;
  ScrollController _rubberScrollController;
  VideoPlayerController _movieController;
  VideoPlayerController _refPlayerController;

  @override
  void initState() {
    super.initState();
    _rubberScrollController = ScrollController();
    _rubberAnimationController = RubberAnimationController(
      vsync: this,
      lowerBoundValue:
          AnimationControllerValue(pixel: widget.size.height * 0.75),
      dismissable: false,
      upperBoundValue: AnimationControllerValue(percentage: 0.9),
      duration: Duration(milliseconds: 300),
      springDescription: SpringDescription.withDampingRatio(
          mass: 1, stiffness: Stiffness.LOW, ratio: DampingRatio.LOW_BOUNCY),
    );

    _movieController = VideoPlayerController.asset(widget.movie.videoPath)
      ..initialize();
    _refPlayerController =
        VideoPlayerController.asset(widget.movie.videoReflectionPath)
          ..initialize();
  }

  @override
  void dispose() {
    _rubberScrollController?.dispose();
    _rubberAnimationController?.dispose();
    _movieController?.dispose();
    _refPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _background(widget.movie.image),
          _rubberView(),
          _bookButton(context),
          _backButton(context),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
      left: 16,
      top: MediaQuery.of(context).padding.top + 16,
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
    );
  }

  Widget _rubberView() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 250),
      tween: Tween<double>(begin: _size.height / 2, end: 0),
      builder: (_, value, child) =>
          Transform.translate(offset: Offset(0, value), child: child),
      child: RubberBottomSheet(
        scrollController: _rubberScrollController,
        animationController: _rubberAnimationController,
        lowerLayer: Container(color: Colors.transparent),
        upperLayer: Column(
          children: <Widget>[
            SizedBox(
              child: Center(
                child: Image(
                  image: widget.movie.imageText.image,
                  width: _size.width / 2,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(24),
                  controller: _rubberScrollController,
                  children: <Widget>[
                    Text(
                      widget.movie.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    TicketsLayout()
                        .genresFormat(widget.movie.genre, Colors.black),
                    SizedBox(height: 8),
                    Text(
                      widget.movie.rating.toString(),
                      style: TextStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    TicketsLayout().starRating(widget.movie.rating, context),
                    SizedBox(height: 28),
                    Text(
                      'Story Line',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      widget.movie.storyLine,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                    _viewCast(),
                    SizedBox(height: 68)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewCast() {
    return Container(
      width: _size.width,
      height: 140,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movie.castList.length,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: _size.width / 6,
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                      image: widget.movie.castList[index].image.image,
                      width: _size.width / 6,
                      height: _size.height / 10,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.movie.castList[index].name,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _bookButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: _size.width * 0.9,
        height: _size.height * 0.08,
        margin: EdgeInsets.symmetric(vertical: _size.width * 0.05),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (ctx, a1, a2) => Booking(
                movieName: widget.movie.name,
                playerController: _movieController,
                refPlayerController: _refPlayerController,
              ),
            ),
          ),
          child: Text(
            'Book Ticket',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _background(Image background) {
    return Positioned(
      top: -48,
      bottom: 0,
      child: TweenAnimationBuilder(
        duration: Duration(milliseconds: 250),
        tween: Tween<double>(begin: .25, end: 1),
        builder: (_, value, child) =>
            Transform.scale(scale: value, child: child),
        child: Image(
          fit: BoxFit.cover,
          image: background.image,
          width: _size.width,
          height: _size.height,
        ),
      ),
    );
  }
}
