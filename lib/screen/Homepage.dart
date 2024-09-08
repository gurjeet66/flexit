import 'package:flexit/screen/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/workout.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    workoutProvider.addDefaultWorkouts();
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout Tracker'),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        padding: EdgeInsets.all(10.0),
        itemCount: workoutProvider.availableWorkouts.length,
        itemBuilder: (context, index) {
          final workout = workoutProvider.availableWorkouts[index];
          return GestureDetector(
            onTap: () {
              _showPopupMenu(context, workout);
            },
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                      child: Image.asset(
                        workout.imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        if (workout.value != null) ...[
                          Text(
                            'Value: ${workout.value}',
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                        ] else ...[
                          Text(
                            'Value: Not Assigned',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              workout.isCompletedToday ? Icons.check_circle : Icons.cancel,
                              color: workout.isCompletedToday ? Colors.green : Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              workout.isCompletedToday ? 'Done' : 'Not Done',
                              style: TextStyle(color: workout.isCompletedToday ? Colors.green : Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Chart',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/workout-list');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chart');
          }
        },
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Workout workout) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Options for ${workout.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: Colors.blue),
                title: Text('Assign Value'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showValueDialog(context, workout);
                },
              ),
              ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Update Status'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showStatusDialog(context, workout);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showValueDialog(BuildContext context, Workout workout) {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
    final valueController = TextEditingController();

    if (workout.value != null) {
      valueController.text = workout.value.toString();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Assign Value to ${workout.name}'),
          content: TextField(
            controller: valueController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Value (1 to 100)'),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final value = int.tryParse(valueController.text);
                if (value != null && value >= 1 && value <= 100) {
                  final updatedWorkout = workout.copyWith(value: value);
                  workoutProvider.updateWorkout(updatedWorkout);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter a valid value between 1 and 100'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showStatusDialog(BuildContext context, Workout workout) {
    final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Status for ${workout.name}'),
          content: Text('Mark this workout as ${workout.isCompletedToday ? 'not completed' : 'completed'} today?'),
          actions: [
            TextButton(
              onPressed: () {
                final updatedWorkout = workout.copyWith(isCompletedToday: !workout.isCompletedToday);
                workoutProvider.updateWorkout(updatedWorkout);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
