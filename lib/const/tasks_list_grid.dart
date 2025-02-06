import 'package:flutter/material.dart';
import 'package:it_way_bd/const/styel.dart';
import 'package:it_way_bd/models/task_model.dart';
import 'package:it_way_bd/providers/task_provider.dart';

GridView task_grid(int getColumns(BuildContext context), BuildContext context,
      TaskProvider taskProvider) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: getColumns(context), // Dynamic columns
        crossAxisSpacing: 16.0, // Space between columns
        mainAxisSpacing: 16.0, // Space between rows
        childAspectRatio: 1.0, // Aspect ratio of grid items
      ),
      itemCount: taskProvider.tasks.length,
      itemBuilder: (context, index) {
        Task task = taskProvider.tasks[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                const Color.fromARGB(255, 154, 87, 249),
                Colors.white,
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  style: myStyle(18, Colors.black, FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Checkbox(
                  value: task.completed,
                  onChanged: (bool? value) {
                    taskProvider.toggleTaskCompletion(task.id, value!);
                  },
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ListView task_list(TaskProvider taskProvider) {
    return ListView.builder(
      itemCount: taskProvider.tasks.length,
      itemBuilder: (context, index) {
        Task task = taskProvider.tasks[index];
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [const Color.fromARGB(255, 154, 87, 249), Colors.white],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft),
          ),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                task.title,
                style: myStyle(18, Colors.black, FontWeight.w500),
              ),
              trailing: Checkbox(
                value: task.completed,
                onChanged: (bool? value) {
                  taskProvider.toggleTaskCompletion(task.id, value!);
                },
                activeColor: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }