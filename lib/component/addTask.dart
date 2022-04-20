import 'package:demo/models/taks.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class AddTask extends StatefulWidget {
  AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  Color? taskColor;
  IconData? taskIcon;
  String? task;
  TextEditingController taskController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  static const SizedBox heightSizedBox = SizedBox(
    height: 10,
  );

  static const SizedBox widthSizedBox = SizedBox(
    width: 10,
  );

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Task Name"),
          heightSizedBox,
          TextFormField(
            controller: taskController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Add task Name';
              }
              if (value.length < 4) {
                return 'Task Name is too short';
              }
              return null;
            },
            onSaved: (value) {
              task = value;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task',
              hintText: 'Exercise',
            ),
          ),
          heightSizedBox,
          Row(
            children: [
              const Text("Task Priority"),
              widthSizedBox,
              Expanded(
                child: DropdownButtonFormField<Color>(
                  value: taskColor,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      size: 20,
                    ),
                  ),
                  onChanged: (Color? newValue) {
                    setState(() {
                      taskColor = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select task color";
                    }
                    return null;
                  },
                  items: takColors.map<DropdownMenuItem<Color>>(
                    (Color value) {
                      return DropdownMenuItem<Color>(
                        value: value,
                        child: Container(color: value, height: 20, width: 20),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text("Task Icon"),
              widthSizedBox,
              Expanded(
                child: DropdownButtonFormField<IconData>(
                  value: taskIcon,
                  icon: const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      size: 20,
                    ),
                  ),
                  onChanged: (IconData? newValue) {
                    setState(() {
                      taskIcon = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select task Icon";
                    }
                    return null;
                  },
                  items: tasIcons.map<DropdownMenuItem<IconData>>(
                    (IconData value) {
                      return DropdownMenuItem<IconData>(
                        value: value,
                        child: Icon(value),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          heightSizedBox,
          Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: _addtask,
              child: const Text(
                "Add Task",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    ));
  }

  _addtask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pop(
        context,
        Tasks(taskColor!, taskIcon!, task!),
      );
    }
  }
}
