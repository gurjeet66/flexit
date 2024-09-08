import 'package:flexit/screen/ChartPage.dart';
import 'package:flexit/screen/Homepage.dart';
import 'package:flexit/screen/WorkoutListPage.dart';
import 'package:flexit/screen/workout_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WorkoutProvider()..addDefaultWorkouts()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workout Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/workout-list': (context) => WorkoutListPage(),
          '/chart': (context) => ChartPage(), // Define route for WorkoutListPage
        },
      ),
    );
  }
}
