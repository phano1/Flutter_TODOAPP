import 'package:flutter/material.dart';

void main() => runApp(TodoApp()); // Run the TodoApp when the app starts

class TodoApp extends StatelessWidget {
  // Constructor for TodoApp widget. The Key parameter is added for widget identity.
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp widget to start the app, and set the home screen to TodoHome widget
    return MaterialApp(
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  // Constructor for TodoHome widget, inheriting from StatefulWidget
  const TodoHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoHomeState createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  // List to hold the tasks
  final List<String> _tasks = [];
  // Controller to manage the text input for new tasks
  final TextEditingController _controller = TextEditingController();

  // A list of colors to assign to each task
  final List<Color> taskColors = [
    const Color.fromARGB(255, 241, 173, 161),
    const Color.fromARGB(255, 151, 185, 169),
    const Color.fromARGB(255, 224, 205, 179),
    const Color.fromARGB(255, 225, 235, 198),
    const Color.fromARGB(255, 209, 185, 238),
  ];

  // Function to add a new task to the list
  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(_controller.text); // Add the task to the list
      });
      _controller.clear(); // Clear the text field after adding
    }
  }

  // Function to remove a task at a specific index
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove the task at the given index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with a title
      appBar: AppBar(title: Text("To-Do App")),
      body: Column(
        children: [
          // Text input field and button to add a new task
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller, // Text controller for input field
                    decoration: InputDecoration(hintText: "Enter a task"),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add), // Add button to add a task
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          // ListView to display the tasks with background colors
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length, // Number of tasks in the list
              itemBuilder: (context, index) {
                // Use a different background color for each task
                Color taskColor = taskColors[index % taskColors.length];
                return Container(
                  // Add margin to create space between tasks
                  margin: const EdgeInsets.symmetric(vertical: 4.0), // Vertical gap between tasks
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0), // Adjust padding for task size
                  decoration: BoxDecoration(
                    color: taskColor, // Set the background color for each task
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(_tasks[index]), // Display task text
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.white), // Delete button
                      onPressed: () => _removeTask(index), // Remove task on press
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
}
