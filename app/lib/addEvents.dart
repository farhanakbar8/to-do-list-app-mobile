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
  bool isName = false;
  bool isDesc = false;
  bool isDateTime = false;
  @override
  void dispose() {
    fieldEventName.dispose();
    fieldEventDesc.dispose();
    fieldTimeDate.dispose();
    super.dispose();
  }

  Future _saveData(String name, String desc, String timeDate) async {
    var url = 'http://192.168.1.14/api/saveData.php';
    final response = await http.post(Uri.parse(url),
        body: {"eventName": name, "eventDesc": desc, "timeDate": timeDate});
    var res = response.body;

    if (res == "true") {
      print('in');
      Navigator.pop(context);
    } else {
      // ignore: avoid_print
      print("Error: $res");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          margin: const EdgeInsets.only(left: 80),
          child: const Text(
            'Add Events',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blue[600]),
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
                child: const Text('Submit'),
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
                    _saveData(fieldEventName.text, fieldEventDesc.text,
                        fieldTimeDate.text);
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.red),
                child: const Text('Clear'),
                onPressed: () {
                  fieldEventName.clear();
                  fieldEventDesc.clear();
                  fieldTimeDate.clear();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
