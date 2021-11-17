import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get darkTheme {
    //1
    return ThemeData( //2
        primaryColor: const Color(0xff2a3038),
        primarySwatch: customPalette.coolGrey,
        canvasColor: const Color(0xff2a3038),
        cardColor: const Color(0xff2a2e33),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xff1a1d21),
        fontFamily: 'Montserrat',
        //3
        textTheme: ThemeData
            .dark()
            .textTheme,
        buttonTheme: ButtonThemeData( // 4
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0)),
          buttonColor: Colors.yellow,
        )
    );
  }

}

class customPalette {
  static const MaterialColor coolGrey = const MaterialColor(
    0xff2a3038, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff8fa1b4),//10%
      100: const Color(0xff7c899c),//20%
      200: const Color(0xff606c7d),//30%
      300: const Color(0xff4e5a6a),//40%
      400: const Color(0xff3e4b57),//50%
      500: const Color(0xff2f3b44),//60%
      600: const Color(0xff252e38),//70%
      700: const Color(0xff1d252d),//80%
      800: const Color(0xff131a1f),//90%
      900: const Color(0xff000000),//100%
    },
  );
}