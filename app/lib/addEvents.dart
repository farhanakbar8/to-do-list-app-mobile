import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEvents extends StatefulWidget {
  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final fieldEventName = TextEditingController();
  final fieldEventDesc = TextEditingController();
  final fieldTimeDate = TextEditingController();
  @override
  void dispose() {
    fieldEventName.dispose();
    fieldEventDesc.dispose();
    fieldTimeDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Events'),
      ),
    );
  }
}
