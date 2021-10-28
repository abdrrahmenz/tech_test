import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_test/data/repository/repository.dart';
import 'package:tech_test/ui/getting_start/getting_start.dart';
import 'package:tech_test/utils/app_colors.dart';

import 'bloc/topic_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopicBloc(FakeTopicRepository()),
      child: MaterialApp(
        title: 'Tech test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: colorPrimary,
          accentColor: colorSecondary,
          textTheme: GoogleFonts.merriweatherTextTheme(),
          appBarTheme: AppBarTheme(
            backgroundColor: colorPrimary,
            centerTitle: true,
          ),
        ),
        home: GettingStart(),
      ),
    );
  }
}
