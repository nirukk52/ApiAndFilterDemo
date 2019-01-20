import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies_streams/blocs/BlocProvider.dart';
import 'package:movies_streams/blocs/MainFreightBloc.dart';
import 'package:movies_streams/screen/FreightsListScreen.dart';
import 'package:movies_streams/theme/ColorPalette.dart';
import 'package:movies_streams/widgets/frate_widget.dart';

Future<void> main() async {
//  debugPrintRebuildDirtyWidgets = true;
//  debugger();
  return runApp(
      BlocProvider<MainFreightBloc>(
        bloc: MainFreightBloc(),
        child: BlocProvider<MainFreightBloc>(
          bloc: MainFreightBloc(),
          child: MyApp(),
        ),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Main Freight Quotes',
      theme: ThemeData(
        primarySwatch: ColorPalette.primaryBlue,
      ),
      home: FreightsListScreen(),
    );
  }
}
