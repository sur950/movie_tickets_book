import 'package:movie_tickets_book/core.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  ScrollController _movieController, _bgController;
  double _maxTranslation = 65;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _bgController = ScrollController();
    _movieController = ScrollController()
      ..addListener(() => _addRemoveListener());
  }

  @override
  void dispose() {
    _movieController?.removeListener(() => _addRemoveListener());
    _movieController?.dispose();
    _bgController?.dispose();
    super.dispose();
  }

  _addRemoveListener() {
    _bgController.jumpTo(_movieController.offset * (_size.width / _itemWidth));
  }

  Size get _size => MediaQuery.of(context).size;
  double get _itemWidth => _size.width / 2 + 48;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[_bgList(), _moviesList(), _bookButton(context)],
      ),
    );
  }

  Widget _bgList() {
    return ListView.builder(
      controller: _bgController,
      padding: EdgeInsets.zero,
      reverse: true,
      itemCount: MoviesData().data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        MovieResponse _res = MoviesData().data[index];

        return Container(
          width: _size.width,
          height: _size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Positioned(
                left: -_size.width / 3,
                right: -_size.width / 3,
                child: Image(image: _res.image.image, fit: BoxFit.cover),
              ),
              Container(color: Colors.grey.withOpacity(0.6)),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.9),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.95)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.5, 0.9],
                  ),
                ),
              ),
              Container(
                height: _size.height * 0.25,
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Align(
                  alignment: Alignment.center,
                  child: Image(
                    width: _size.width / 1.8,
                    image: _res.imageText.image,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _moviesList() {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 700),
      tween: Tween<double>(begin: 600, end: 0),
      curve: Curves.easeOutCubic,
      builder: (_, value, child) {
        return Transform.translate(
          offset: Offset(value, 0),
          child: child,
        );
      },
      child: Container(
        height: _size.height * .75,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return true;
          },
          child: ScrollSnapList(
            listController: _movieController,
            onItemFocus: (item) => _currentIndex = item,
            itemSize: _itemWidth,
            padding: EdgeInsets.zero,
            itemCount: MoviesData().data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _singleItem(index),
          ),
        ),
      ),
    );
  }

  Widget _singleItem(int index) {
    MovieResponse _res = MoviesData().data[index];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: <Widget>[
          AnimatedBuilder(
            animation: _movieController,
            builder: (ctx, child) {
              double activeOffset = index * _itemWidth;
              double translate =
                  _movieTranslate(_movieController.offset, activeOffset);
              return SizedBox(height: translate);
            },
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image(image: _res.image.image, width: _size.width / 2),
          ),
          SizedBox(height: _size.height * 0.02),
          AnimatedBuilder(
            animation: _movieController,
            builder: (context, child) {
              double activeOffset = index * _itemWidth;
              double opacity = _movieDescriptionOpacity(
                  _movieController.offset, activeOffset);

              return Opacity(
                opacity: opacity / 100,
                child: Column(
                  children: <Widget>[
                    Text(
                      _res.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _size.width / 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.01),
                    TicketsLayout().genresFormat(_res.genre, Colors.white),
                    SizedBox(height: _size.height * 0.01),
                    Text(
                      _res.rating.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _size.width / 16,
                      ),
                    ),
                    SizedBox(height: _size.height * 0.005),
                    TicketsLayout().starRating(_res.rating, context),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _bookButton(BuildContext context) {
    return Container(
      height: _size.height * .10,
      margin: EdgeInsets.symmetric(horizontal: 32),
      child: Align(
        alignment: Alignment.topCenter,
        child: FlatButton(
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (ctx, a1, a2) =>
                  Details(movie: MoviesData().data[_currentIndex], size: _size),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: _size.height * 0.08,
            alignment: Alignment.center,
            child: Text(
              'Book Ticket',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _movieDescriptionOpacity(double offset, double activeOffset) {
    double opacity;
    if (_movieController.offset + _itemWidth <= activeOffset) {
      opacity = 0;
    } else if (_movieController.offset <= activeOffset) {
      opacity = ((_movieController.offset - (activeOffset - _itemWidth)) /
          _itemWidth *
          100);
    } else if (_movieController.offset < activeOffset + _itemWidth) {
      opacity = 100 -
          (((_movieController.offset - (activeOffset - _itemWidth)) /
                  _itemWidth *
                  100) -
              100);
    } else {
      opacity = 0;
    }
    return opacity;
  }

  double _movieTranslate(double offset, double activeOffset) {
    double translate;
    if (_movieController.offset + _itemWidth <= activeOffset) {
      translate = _maxTranslation;
    } else if (_movieController.offset <= activeOffset) {
      translate = _maxTranslation -
          ((_movieController.offset - (activeOffset - _itemWidth)) /
              _itemWidth *
              _maxTranslation);
    } else if (_movieController.offset < activeOffset + _itemWidth) {
      translate = ((_movieController.offset - (activeOffset - _itemWidth)) /
              _itemWidth *
              _maxTranslation) -
          _maxTranslation;
    } else {
      translate = _maxTranslation;
    }
    return translate;
  }
}
