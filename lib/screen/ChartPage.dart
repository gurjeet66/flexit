import 'package:fl_chart/fl_chart.dart';
import 'package:flexit/screen/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final completedWorkouts = workoutProvider.getFilteredWorkouts(isCompleted: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Progress Chart'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workout Progress',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            completedWorkouts.isEmpty
                ? Center(
                    child: Text(
                      'No completed workouts to display',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : Expanded(
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 100,
                        barTouchData: BarTouchData(enabled: true),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            margin: 16,
                            getTitles: (double value) {
                              int index = value.toInt();
                              return completedWorkouts[index].name;
                            },
                          ),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTextStyles: (context, value) => TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            margin: 16,
                            interval: 20,
                            reservedSize: 30,
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        barGroups: completedWorkouts.asMap().entries.map((entry) {
                          int index = entry.key;
                          Workout workout = entry.value;
                          return BarChartGroupData(
                            x: index,
                            barRods: [
                              BarChartRodData(
                                y: workout.value?.toDouble() ?? 0.0, // Handle null value
                                colors: [Colors.teal],
                                width: 22,
                                borderRadius: BorderRadius.circular(4),
                                backDrawRodData: BackgroundBarChartRodData(
                                  show: true,
                                  y: 100,
                                  colors: [Colors.grey[300]!],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
