import 'package:flutter/material.dart';

class Chartpage extends StatelessWidget {
  const Chartpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
      )
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:flutter_charts/flutter_charts.dart'; // Ensure this import matches the library
// import 'package:provider/provider.dart';
// import '../providers/workout_provider.dart';

// class ChartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final workoutProvider = Provider.of<WorkoutProvider>(context);

//     // Prepare chart data
//     final data = workoutProvider.workouts.map((workout) {
//       return ChartData(
//         workout.name,
//         workout.value,
//         workout.value > 50 ? Colors.green : Colors.red,
//       );
//     }).toList();

//     return Scaffold(
//       appBar: AppBar(title: Text('Workout Chart')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: LineChart(
//                 data: data,
//                 xAxis: (data) => data.name,
//                 yAxis: (data) => data.value,
//                 lineColor: (data) => data.color,
//                 animate: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChartData {
//   final String name;
//   final double value;
//   final Color color;

//   ChartData(this.name, this.value, this.color);
// }
