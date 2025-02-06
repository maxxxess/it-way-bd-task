import 'package:flutter/material.dart';
import 'package:it_way_bd/const/styel.dart';
import 'package:it_way_bd/models/task_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final TextEditingController searchController;
  final Function onSearch;
  final List<Task> tasks;

  CustomSearchDelegate(
      {required this.searchController,
      required this.onSearch,
      required this.tasks});

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Filter tasks based on the search query (match the first letter)
    List<Task> filteredTasks = tasks
        .where(
            (task) => task.title.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        Task task = filteredTasks[index];

        return Padding(
          padding: const EdgeInsets.all(12),
          child: ListTile(
            title: Text(task.title),
            onTap: () {
              // Show the task details in a dialog
              Future.delayed(Duration(milliseconds: 100), () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color.fromARGB(255, 226, 207, 253),
                    title: Text(task.title),
                    content: Text(
                      'Task ID: ${task.id}\nCompleted: ${task.completed ? "Yes" : "No"}',
                      style: myStyle(18, Colors.black, FontWeight.w500),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(
                          'Close',
                          style: myStyle(18, Colors.black, FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                );
              });
              close(
                  context, null); // Close the search bar after selecting a task
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 159, 93, 250),
    ); // We handle the results in the suggestions list
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          searchController.clear();
          onSearch();
          close(context, null);
        },
      ),
    ];
  }
}
