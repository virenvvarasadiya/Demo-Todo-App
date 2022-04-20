import 'package:flutter/material.dart';

class Tasks {
  final Color color;
  final String name;
  final IconData icon;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  Tasks(this.color, this.icon, this.name, {this.endTime, this.startTime});
}
