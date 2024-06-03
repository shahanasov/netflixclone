import 'package:flutter/material.dart';
import 'package:netflix/widgets/bottom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ButtonStyle(
        //         backgroundColor: Color.fromRGBO(0, 0, 0, 0))),
        // unselectedWidgetColor: Colors.white,
        // primaryColorLight: Colors.white,
        // primaryColorDark: Colors.white,
        // cardColor: Colors.white,
        // hintColor: Colors.white,
        // indicatorColor: Colors.white,
        // hoverColor: Colors.white,
        // highlightColor: Colors.white,
        // focusColor: Colors.white,
        // brightness: Brightness.light,
        // primaryColor: Colors.white,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
        //     .copyWith(secondary: Colors.white),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const BottomBar(),
    );
  }
}
