import 'package:demo/models/taks.dart';
import 'package:flutter/material.dart';

import 'component/addTask.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tasks> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text("No Task Added Yet"),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(
                      tasks[index].icon,
                      color: tasks[index].color,
                    ),
                    title: Text(tasks[index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (tasks[index].startTime != null)
                          Text(
                              "Start Time ${tasks[index].startTime!.hour.toString()}:${tasks[index].startTime!.minute.toString()}"),
                        if (tasks[index].endTime != null)
                          Text(
                              "End Time ${tasks[index].endTime!.hour.toString()}:${tasks[index].endTime!.minute.toString()} "),
                      ],
                    ),
                    trailing: TextButton(
                      onPressed: () => _timerManage(index),
                      child: Text(
                        tasks[index].startTime == null
                            ? "Start Time"
                            : tasks[index].endTime == null
                                ? "End Time"
                                : "",
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  _timerManage(int index) {
    setState(() {
      if (tasks[index].startTime == null) {
        tasks[index].startTime = TimeOfDay.now();
      } else {
        tasks[index].endTime = TimeOfDay.now();
      }
    });
  }

  _addTask() async {
    var task = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Task'),
          content: AddTask(),
        );
      },
    );
    if (task != null) {
      setState(() {
        tasks.add(task);
      });
    }
  }
}
