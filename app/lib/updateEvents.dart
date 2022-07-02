import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateEvents extends StatefulWidget {
  final String id;
  final String name;
  final String description;
  final String time;

  const UpdateEvents(
      {Key? key,
      required this.id,
      required this.name,
      required this.description,
      required this.time})
      : super(key: key);

  @override
  _UpdateEventsState createState() => _UpdateEventsState();
}

class _UpdateEventsState extends State<UpdateEvents> {
  final fieldEventName = TextEditingController();
  final fieldEventDesc = TextEditingController();
  final fieldTimeDate = TextEditingController();
  bool isName = false;
  bool isDesc = false;
  bool isDateTime = false;

  Future updateData(
      String id, String name, String desc, String timeDate) async {
    var url = 'http://192.168.1.14/api/updateEvent.php';
    final response = await http.post(Uri.parse(url), body: {
      "id": id,
      "eventName": name,
      "eventDesc": desc,
      "timeDate": timeDate
    });
    var res = response.body;

    if (res == "true") {
      print('in');
    } else {
      // ignore: avoid_print
      print("Error: $res");
    }
  }

  Future deleteEvent() async {
    var url = 'http://192.168.1.14/api/deleteEvent.php';
    final response = await http.post(Uri.parse(url), body: {"id": widget.id});
    var res = response.body;
    if (res == "true") {
      print('hapus');
    } else {
      // ignore: avoid_print
      print("Error: $res");
    }
  }

  @override
  void dispose() {
    fieldEventName.dispose();
    fieldEventDesc.dispose();
    fieldTimeDate.dispose();
    super.dispose();
  }

  @override
  void initState() {
    fieldEventName.text = widget.name;
    fieldEventDesc.text = widget.description;
    fieldTimeDate.text = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Events"),
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: fieldEventName,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Event Name",
                    errorText: isName ? "Event Name can't be empty!" : null),
              )),
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: fieldEventDesc,
                maxLines: 4,
                decoration: InputDecoration(
                    alignLabelWithHint: true,
                    border: const OutlineInputBorder(),
                    labelText: "Event Description",
                    errorText:
                        isDesc ? "Event Description can't be empty!" : null),
              )),
          Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                controller: fieldTimeDate,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "When?",
                    errorText: isDateTime ? "Event Time can't be empty" : null),
              )),
          ButtonBar(
            buttonPadding: const EdgeInsets.only(right: 30),
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    fieldEventName.text.isEmpty
                        ? isName = true
                        : isName = false;
                    fieldEventDesc.text.isEmpty
                        ? isDesc = true
                        : isDesc = false;
                    fieldTimeDate.text.isEmpty
                        ? isDateTime = true
                        : isDateTime = false;
                  });
                  if (!isName && !isDesc && !isDateTime) {
                    updateData(widget.id, fieldEventName.text,
                        fieldEventDesc.text, fieldTimeDate.text);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: const Text('Save'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Delete'),
                onPressed: () {
                  // fieldEventName.clear();
                  // fieldEventDesc.clear();
                  // fieldTimeDate.clear();
                  deleteEvent();
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
