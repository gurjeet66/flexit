import 'package:flexit/screen/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/workout.dart';

class WorkoutListPage extends StatefulWidget {
  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final filteredWorkouts = _selectedDate == null
        ? workoutProvider.availableWorkouts
        : workoutProvider.getFilteredWorkoutsByDateAndStatus(
            _selectedDate,
            isCompleted: true,
          );

    return Scaffold(
      appBar: AppBar(
        title: Text('Workout List', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today, size: 28),
            onPressed: _selectDate,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.teal[100],
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedDate = null;
                      });
                    },
                    child: Text('All', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedDate == null ? Colors.teal : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectDate,
                    child: Text('Date', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedDate != null ? Colors.teal : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredWorkouts.isEmpty
                ? Center(child: Text('No workouts available', style: TextStyle(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
                    itemCount: filteredWorkouts.length,
                    itemBuilder: (context, index) {
                      final workout = filteredWorkouts[index];
                      final statusText = workout.isCompletedToday
                          ? 'Completed Today'
                          : 'Not Completed Today';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                workout.imagePath,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              workout.name,
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              _selectedDate == null
                                  ? statusText
                                  : 'Completed on: ${workout.date.toLocal()}',
                              style: TextStyle(fontSize: 16, color: workout.isCompletedToday ? Colors.green : Colors.red),
                            ),
                            trailing: Icon(
                              workout.isCompletedToday ? Icons.check_circle : Icons.cancel,
                              color: workout.isCompletedToday ? Colors.green : Colors.red,
                              size: 30,
                            ),
                            tileColor: workout.isCompletedToday ? Colors.green[50] : Colors.red[50],
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: workout.isCompletedToday ? Colors.green : Colors.red,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _selectDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            hintColor: Colors.teal,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
      });
    }
  }
}
