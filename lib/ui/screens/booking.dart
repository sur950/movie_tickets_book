import 'package:movie_tickets_book/core.dart';

class Booking extends StatefulWidget {
  final VideoPlayerController playerController;
  final VideoPlayerController refPlayerController;
  final String movieName;

  Booking({this.playerController, this.refPlayerController, this.movieName});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> with TickerProviderStateMixin {
  Size get _size => MediaQuery.of(context).size;
  List<AnimationController> _dateSelectorACList = [];
  List<Animation<double>> _dateSelectorTweenList = [];

  List<AnimationController> _timeSelectorACList = [];
  List<Animation<double>> _timeSelectorTweenList = [];

  AnimationController _dateBackgroundAc;
  Animation<double> _dateBackgroundTween;

  AnimationController _cinemaScreenAc;
  Animation<double> _cinemaScreenTween;

  AnimationController _reflectionAc;
  Animation<double> _reflectionTween;

  AnimationController _payButtonAc;
  Animation<double> _payButtonTween;

  AnimationController _cinemaChairAc;
  Animation<double> _cinemaChairTween;

  int _dateIndexSelected = 1;
  int _timeIndexSelected = 1;

  // 0 is null
  // 1 is free
  // 2 is reserved
  // 3 is notavailable
  // 4 is yours
  List<List<int>> _chairStatus = [
    [1, 3, 1, 3, 2, 3, 2],
    [0, 1, 3, 1, 3, 2, 0],
    [3, 2, 3, 2, 3, 2, 3],
    [1, 3, 1, 3, 1, 3, 1],
    [0, 2, 0, 2, 0, 2, 0],
    [0, 3, 3, 2, 1, 1, 0]
  ];

  @override
  void initState() {
    super.initState();
    widget.playerController.setLooping(true);
    widget.refPlayerController.setLooping(true);
    widget.playerController.play();
    widget.refPlayerController.play();
    initializeAnimation();
  }

  void initializeAnimation() {
    // initialize dateSelector List
    for (int i = 0; i < 7; i++) {
      _dateSelectorACList.add(
        AnimationController(vsync: this, duration: Duration(milliseconds: 500)),
      );
      _dateSelectorTweenList.add(
        Tween<double>(begin: 1000, end: 0)
            .chain(CurveTween(curve: Curves.easeOutCubic))
            .animate(_dateSelectorACList[i]),
      );
      Future.delayed(Duration(milliseconds: i * 50 + 170), () {
        _dateSelectorACList[i].forward();
      });
    }

    // initialize dateSelector Background
    _dateBackgroundAc = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    _dateBackgroundTween = Tween<double>(begin: 1000, end: 0)
        .chain(CurveTween(curve: Curves.easeOutCubic))
        .animate(_dateBackgroundAc);
    Future.delayed(Duration(milliseconds: 150), () {
      _dateBackgroundAc.forward();
    });

    // initialize timeSelector List
    for (int i = 0; i < 3; i++) {
      _timeSelectorACList.add(
        AnimationController(vsync: this, duration: Duration(milliseconds: 500)),
      );
      _timeSelectorTweenList.add(
        Tween<double>(begin: 1000, end: 0)
            .chain(CurveTween(curve: Curves.easeOutCubic))
            .animate(_timeSelectorACList[i]),
      );
      Future.delayed(Duration(milliseconds: i * 25 + 100), () {
        _timeSelectorACList[i].forward();
      });
    }

    // initialize cinemaScreen
    _cinemaScreenAc = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    _cinemaScreenTween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_cinemaScreenAc);
    Future.delayed(Duration(milliseconds: 800), () {
      _cinemaScreenAc.forward();
    });

    // initialize reflection
    _reflectionAc = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _reflectionTween = Tween<double>(begin: 0, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_reflectionAc);
    Future.delayed(Duration(milliseconds: 1800), () {
      _reflectionAc.forward();
    });

    // paybutton
    _payButtonAc = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _payButtonTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.easeInOutQuart))
        .animate(_payButtonAc);
    Future.delayed(Duration(milliseconds: 800), () {
      _payButtonAc.forward();
    });

    // chair
    _cinemaChairAc = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );
    _cinemaChairTween = Tween<double>(begin: -1, end: 0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(_cinemaChairAc);
    Future.delayed(Duration(milliseconds: 1200), () {
      _cinemaChairAc.forward();
    });
  }

  @override
  void dispose() {
    _dateSelectorACList.forEach((ele) => ele?.dispose());
    _timeSelectorACList.forEach((ele) => ele?.dispose());
    _dateBackgroundAc?.dispose();
    _cinemaScreenAc?.dispose();
    _reflectionAc?.dispose();
    _payButtonAc?.dispose();
    _cinemaChairAc?.dispose();
    widget?.playerController?.pause();
    widget?.refPlayerController?.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(children: <Widget>[
          _appBar(),
          _dateSelector(),
          _timeSelector(),
          _screenRoom(),
          _payButton()
        ]),
      ),
    );
  }

  Widget _appBar() {
    return Expanded(
      flex: 8,
      child: Container(
        width: _size.width,
        padding: EdgeInsets.zero,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              widget.movieName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Positioned(
              left: 24,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateSelector() {
    DateTime now = DateTime.now();

    return Expanded(
      flex: 13,
      child: Container(
        width: _size.width,
        padding: EdgeInsets.only(left: 32),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            AnimatedBuilder(
              animation: _dateBackgroundAc,
              builder: (ctx, child) {
                return Transform.translate(
                  offset: Offset(_dateBackgroundTween.value, 0),
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: _size.width,
              child: ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  var date = now.add(Duration(days: index));
                  return AnimatedBuilder(
                    animation: _dateSelectorACList[index],
                    builder: (ctx, child) {
                      return Transform.translate(
                        offset: Offset(_dateSelectorTweenList[index].value, 0),
                        child: child,
                      );
                    },
                    child: GestureDetector(
                      onTap: () => setState(() {
                        _dateIndexSelected = index;
                      }),
                      child: Container(
                        padding: EdgeInsets.all(4),
                        margin: EdgeInsets.symmetric(
                          vertical: _size.height * 0.025,
                          horizontal: 12,
                        ),
                        width: 44,
                        decoration: BoxDecoration(
                          color: _dateIndexSelected == index
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Enums().dayFormat(date.weekday),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: index == _dateIndexSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant
                                    : Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            Text(
                              date.day.toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                height: 1,
                                color: index == _dateIndexSelected
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryVariant
                                    : Theme.of(context).colorScheme.surface,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSelector() {
    List<List> time = [
      ["02.30", 45],
      ["06.30", 45],
      ["10.00", 45]
    ];

    return Expanded(
      flex: 17,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: _size.height * .035),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (ctx, index) {
            return AnimatedBuilder(
              animation: _timeSelectorACList[index],
              builder: (ctx, child) {
                return Transform.translate(
                  offset: Offset(_timeSelectorTweenList[index].value, 0),
                  child: child,
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: index == 0 ? 32 : 0),
                child: GestureDetector(
                  onTap: () => setState(() {
                    _timeIndexSelected = index;
                  }),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (index == _timeIndexSelected)
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surface,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: time[index][0],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: (index == _timeIndexSelected)
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.surface,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' PM',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: (index == _timeIndexSelected)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surface,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "IDR ${time[index][1]}K",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _screenRoom() {
    return Expanded(
      flex: 47,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SizedBox(width: _size.width),
          Container(
            padding: EdgeInsets.only(top: 18),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: widget.refPlayerController.value.initialized
                    ? AnimatedBuilder(
                        animation: _reflectionAc,
                        builder: (ctx, child) => Opacity(
                            opacity: _reflectionTween.value, child: child),
                        child: AspectRatio(
                          aspectRatio: 0.5,
                          child: VideoPlayer(widget.refPlayerController),
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
          Positioned(
            top: 48,
            child: ClipPath(
              clipper: CustomVideoClipper2(),
              child: AnimatedBuilder(
                animation: _reflectionAc,
                builder: (ctx, child) =>
                    Opacity(opacity: _reflectionTween.value, child: child),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.85,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.grey[300], Colors.transparent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: _size.height * 0.02,
            child: AnimatedBuilder(
              animation: _cinemaChairTween,
              builder: (ctx, child) => Transform.translate(
                offset: Offset(0, _cinemaChairTween.value * 100),
                child: Opacity(
                  opacity: _cinemaChairTween.value + 1,
                  child: child,
                ),
              ),
              child: Container(width: _size.width, child: _listChairs()),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: <Widget>[
                  Center(
                    child: widget.playerController.value.initialized
                        ? AnimatedBuilder(
                            animation: _cinemaScreenAc,
                            builder: (ctx, child) {
                              double perspective =
                                  0.004 * _cinemaScreenTween.value;

                              return AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Transform(
                                  alignment: Alignment.topCenter,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, perspective)
                                    ..rotateX(_cinemaScreenTween.value),
                                  child: ClipPath(
                                    clipper: CustomVideoClipper(
                                      curveValue: _cinemaScreenTween.value,
                                    ),
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: VideoPlayer(widget.playerController),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _payButton() {
    return Expanded(
      flex: 13,
      child: AnimatedBuilder(
        animation: _payButtonAc,
        builder: (ctx, child) {
          double opacity() {
            if (_payButtonTween.value + 1 < 0.2) {
              return (_payButtonTween.value + 1) * 5;
            }
            return 1;
          }

          return Transform.translate(
            offset: Offset(0, _payButtonTween.value * 200),
            child: Opacity(opacity: opacity(), child: child),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _chairCategory(Theme.of(context).colorScheme.surface, "FREE"),
                  _chairCategory(
                      Theme.of(context).colorScheme.primary, "YOURS"),
                  _chairCategory(
                      Theme.of(context).colorScheme.onBackground, "RESERVED"),
                  _chairCategory(
                      Theme.of(context).colorScheme.onError, "NOT AVAILABLE"),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(32, 2, 32, 8),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.primary),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                onPressed: () {
                  Toast.show(
                    "Liked it? Could you buy me a cup of Cofee Paypal - @suresh950",
                    context,
                    duration: 5,
                    textColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    backgroundRadius: 3,
                  );
                },
                child: Container(
                  width: _size.width - 64,
                  height: _size.height * .05,
                  child: Center(
                    child: Text(
                      'Pay',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chairCategory(Color color, String category) {
    return Row(
      children: <Widget>[
        Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        Text(
          category,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontFamily: "Bebas-Neue",
          ),
        ),
      ],
    );
  }

  Widget _listChairs() {
    // 0 is null
    // 1 is free
    // 2 is reserved
    // 3 is notavailable
    // 4 is yours

    return Container(
      child: Column(
        children: <Widget>[
          for (int i = 0; i < 6; i++)
            Container(
              margin: EdgeInsets.only(top: i == 3 ? _size.height * 0.02 : 0),
              child: Row(
                children: <Widget>[
                  for (int x = 0; x < 9; x++)
                    Expanded(
                      flex: x == 0 || x == 8 ? 2 : 1,
                      child: x == 0 ||
                              x == 8 ||
                              (i == 0 && x == 1) ||
                              (i == 0 && x == 7) ||
                              (i == 3 && x == 1) ||
                              (i == 3 && x == 7) ||
                              (i == 5 && x == 1) ||
                              (i == 5 && x == 7)
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                if (_chairStatus[i][x - 1] == 1) {
                                  setState(() {
                                    _chairStatus[i][x - 1] = 4;
                                  });
                                } else if (_chairStatus[i][x - 1] == 4) {
                                  setState(() {
                                    _chairStatus[i][x - 1] = 1;
                                  });
                                }
                              },
                              child: Container(
                                height: _size.width / 11 - 10,
                                margin: EdgeInsets.all(5),
                                child: _chairStatus[i][x - 1] == 1
                                    ? TicketsLayout().whiteChair(context)
                                    : _chairStatus[i][x - 1] == 2
                                        ? TicketsLayout().greyChair(context)
                                        : _chairStatus[i][x - 1] == 3
                                            ? TicketsLayout().redChair(context)
                                            : TicketsLayout()
                                                .yellowChair(context),
                              ),
                            ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
