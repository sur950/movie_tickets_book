import 'package:movie_tickets_book/core.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer _timer;
  int _seconds = 2;
  Size get _size => MediaQuery.of(context).size;
  double get _width => _size.width;
  double get _height => _size.height;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _startTimer() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) => setState(
        () {
          if (_seconds <= 0) {
            timer.cancel();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
          } else
            _seconds = _seconds - 1;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5C4DB1),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: _height * 0.17),
            Text(
              "Open sourced by",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
            SizedBox(height: 10),
            Image.asset(
              AllImagesAndVideos().vardaanLogo,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: _width * 0.4,
            ),
            SizedBox(height: _height * 0.42),
            Image.asset(
              AllImagesAndVideos().safeAndsecure,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: _width * 0.3,
            ),
            SizedBox(height: 10),
            Image.asset(
              AllImagesAndVideos().madeInIndia,
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: _width * 0.35,
            ),
          ],
        ),
      ),
    );
  }
}
