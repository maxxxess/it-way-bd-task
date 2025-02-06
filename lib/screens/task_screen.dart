import 'package:flutter/material.dart';
import 'package:it_way_bd/const/styel.dart';
import 'package:it_way_bd/const/tasks_list_grid.dart';

import 'package:it_way_bd/providers/task_provider.dart';
import 'package:it_way_bd/widgets/custom_addbutton.dart';
import 'package:it_way_bd/widgets/custom_search.dart';
import 'package:it_way_bd/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _isGridView = true; // Boolean to toggle between ListView and GridView

  @override
  Widget build(BuildContext context) {
    // Fetch tasks when the screen is loaded
    Provider.of<TaskProvider>(context, listen: false).fetchTasks();

    // Search tasks based on the query
    _searchTasks() {
      String query = _searchController.text;
      Provider.of<TaskProvider>(context, listen: false).searchTasks(query);
    }

    _taskadd() async {
      if (_controller.text.isNotEmpty) {
        print("Add button pressed, text is not empty");
        // Add task and show SnackBar
        Provider.of<TaskProvider>(context, listen: false)
            .addTask(_controller.text)
            .then((_) {
          print("Task added successfully");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Task added successfully"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }).catchError((error) {
          print("Failed to add task: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to add task: $error"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 2),
            ),
          );
        });

        // Clear the text field
        _controller.clear();
      } else {
        print("Text field is empty");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Text field is empty",style: myStyle(20, Colors.black),),
            backgroundColor: Colors.blueAccent,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    // Determine the number of columns based on screen width
    int getColumns(BuildContext context) {
      double width = MediaQuery.of(context).size.width;

      if (width >= 1200) {
        return 4; // PC screen (larger devices)
      } else if (width >= 800) {
        return 3; // Tablet
      } else {
        return 2; // Mobile
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        bottomOpacity: 1,
        shadowColor: Colors.black,
        title: Text('Task Manager',
            style: myStyle(22, Colors.white, FontWeight.w600)),
        backgroundColor: Color.fromARGB(255, 129, 40, 255),
        actions: [
          // Search button in the AppBar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                  searchController: _searchController,
                  onSearch: _searchTasks,
                  tasks:
                      Provider.of<TaskProvider>(context, listen: false).tasks,
                ),
              );
            },
            color: Colors.white,
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Toggle Button to switch between ListView and GridView

                Expanded(
                  child: Consumer<TaskProvider>(
                    builder: (context, taskProvider, child) {
                      if (taskProvider.tasks.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (_isGridView) {
                        return task_grid(getColumns, context, taskProvider);//method of task_list_grid.dart.it shows all task n Gridview.builder
                      } else {
                        // ListView
                        return task_list(taskProvider);//method of task_list_grid.dart.it shows all task n Listview.builder
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            child: CustomButton(
              circle: false,
              isIcon: true,
              height: 40,
              width: 40,
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView; // Toggle between grid and list
                });
              },
              backclr: Color.fromARGB(255, 129, 40, 255),
              icon: Icon(
                _isGridView ? Icons.grid_on : Icons.list,
                color: Colors.white,
                size: 26,
              ),
            ),
            bottom: 85,
            right: 40,
          ),
          Positioned(
            bottom: 35,
            right: 40,
            child: CustomButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Add Task'),
                      content: CustomTextField(
                          label: 'Enter the task',
                          hintText: 'Enter the task',
                          controller: _controller),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        CustomButton(
                          height: 30,
                          width: 40,
                          onPressed: () {
                            _taskadd();
                            Navigator.pop(context);
                          },
                          backclr: Color.fromARGB(255, 129, 40, 255),
                          text: 'Add',
                          iconclr: Colors.white,
                          circle: false,
                        )
                      ],
                    );//shows the task details in Alertdialog
                  },
                );
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backclr: Color.fromARGB(255, 129, 40, 255),
              iconclr: Colors.white,
              height: 40,
              width: 40,
              isIcon: true,
            ),
          ),
        ],
      ),
    );
  }

  
}
