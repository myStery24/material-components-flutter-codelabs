// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'supplemental/cut_corners_border.dart';
import 'model/product.dart';

import 'colors.dart';
import 'home.dart';
import 'login.dart';
import 'backdrop.dart';
import 'category_menu_page.dart';

// Convert ShrineApp to stateful widget (104)
class ShrineApp extends StatefulWidget {
  const ShrineApp({Key? key}) : super(key: key);

  /// Make ShrineAppState class private
  @override
  _ShrineAppState createState() => _ShrineAppState();
  // State<ShrineApp> createState() => _ShrineAppState();
}

class _ShrineAppState extends State<ShrineApp> {
  // Add a variable to _ShrineAppState for the selected Category and a callback when it's tapped
  Category _currentCategory = Category.all;

  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shrine',
      // Change home: to a Backdrop with a HomePage frontLayer (104)
      home: Backdrop(
        // Make currentCategory field take _currentCategory (104)
        currentCategory: _currentCategory,
        // Pass _currentCategory for frontLayer (104)
        frontLayer: HomePage(category: _currentCategory),
        // frontLayer: HomePage(),
        // Change backLayer field value to CategoryMenuPage (104)
        backLayer: CategoryMenuPage(
          currentCategory: _currentCategory,
          onCategoryTap: _onCategoryTap,
        ),
        frontTitle: Text('SHRINE'),
        backTitle: Text('MENU'),
      ),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
      // Add a theme (103)
      theme: _kShrineTheme,
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name != '/login') {
      return null;
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => const LoginPage(),
      fullscreenDialog: true,
    );
  }
}

// Build a Shrine Theme (103)
final ThemeData _kShrineTheme = _buildShrineTheme();

ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    // Add the text themes (103)
    textTheme: _buildShrineTextTheme(base.textTheme),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: kShrinePink100,
    ),
    // TODO: Add the icon themes (103)
    // Decorate the inputs (103)
    inputDecorationTheme: const InputDecorationTheme(
      focusedBorder: CutCornersBorder(
        borderSide: BorderSide(
          width: 2.0,
          color: kShrineBrown900,
        ),
      ),
      border: CutCornersBorder(), // previously OutlineInputBorder()
    ),
  );
}

// Different Shrine Theme (103)
// ThemeData _buildShrineTheme() {
//   final ThemeData base = ThemeData.light();
//   return base.copyWith(
//     colorScheme: base.colorScheme.copyWith(
//       primary: kShrinePurple,
//       secondary: kShrinePurple,
//       error: kShrineErrorRed,
//     ),
//     scaffoldBackgroundColor: kShrineSurfaceWhite,
//     textTheme: _buildShrineTextTheme(base.textTheme),
//     textSelectionTheme: const TextSelectionThemeData(
//       selectionColor: kShrinePurple,
//     ),
//     inputDecorationTheme: const InputDecorationTheme(
//       focusedBorder: CutCornersBorder(
//         borderSide: BorderSide(
//           width: 2.0,
//           color: kShrinePurple,
//         ),
//       ),
//       border: CutCornersBorder(),
//     ),
//   );
// }

// Build a Shrine Text Theme (103)
TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: kShrineBrown900,
        bodyColor: kShrineBrown900,
      );
}
