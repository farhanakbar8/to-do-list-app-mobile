import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEvents extends StatefulWidget {
  const AddEvents({Key? key}) : super(key: key);

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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(left: 80),
          child: const Text('Add Events', style: TextStyle(color: Colors.blue),),
        ),
        iconTheme: IconThemeData(
          color: Colors.blue[600]
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: fieldEventName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Event Name"
              ),   
            ) 
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: fieldEventDesc,
              maxLines: 5,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                labelText: "Event Description"
              ),   
            ) 
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextFormField(
              controller: fieldTimeDate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "When?"
              ),   
            ) 
          ),
          ButtonBar(
            buttonPadding: const EdgeInsets.only(right: 30),
            children: [
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: (){},
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
                child: const Text('Clear'),
                onPressed: (){},
              )
            ],
          )
        ],
      ),
    );
  }
}
