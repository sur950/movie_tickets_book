import 'package:movie_tickets_book/core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      // transparent status bar
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Ticket booking app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ColorScheme(
          primary: Color(0xffF9B015),
          primaryVariant: Colors.transparent,
          secondary: Colors.transparent,
          secondaryVariant: Colors.black,
          surface: Colors.white,
          background: Colors.grey[800],
          error: Colors.red[900],
          onPrimary: Colors.transparent,
          onSecondary: Colors.transparent,
          onSurface: Colors.transparent,
          onBackground: Colors.grey[700],
          onError: Colors.red[800],
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Color(0xffF9B015),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Open-Sans",
      ),
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
