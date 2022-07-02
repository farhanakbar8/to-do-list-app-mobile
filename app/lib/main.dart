import 'dart:convert';

import 'package:app/addEvents.dart';
import 'package:app/updateEvents.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Gready!'),
      routes: <String, WidgetBuilder>{
        '/addEvents': (BuildContext context) => const AddEvents()
      },
    );
  }
}

Future<List> getData() async {
  final response =
      await http.get(Uri.parse('http://192.168.1.14/api/getData.php'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List> futureData;

  @override
  void initState() {
    super.initState();
    futureData = getData();
  }

  @override
  Widget build(BuildContext context) {
    print("masuk situ");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Center(
          child: ImageIcon(
            AssetImage('assets/logo.png'),
            size: 90,
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: FutureBuilder<List>(
          future: futureData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return EventsScreen(
              //   events: snapshot.data!,
              // );
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 20, right: 20, left: 20),
                        height: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            )
                          ],
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: index % 2 == 0
                              ? const Color.fromRGBO(98, 182, 203, 1)
                              : const Color.fromRGBO(139, 111, 169, 1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data![index]['eventName'],
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.white),
                            ),
                            Text(
                              snapshot.data![index]['timeDate'],
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateEvents(
                                    id: snapshot.data![index]['id'],
                                    name: snapshot.data![index]['eventName'],
                                    description: snapshot.data![index]
                                        ['eventDesc'],
                                    time: snapshot.data![index]
                                        ['timeDate']))).then((_) {
                          futureData = getData();
                          setState(() {});
                        });
                      },
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        onPressed: () {
          Navigator.pushNamed(context, '/addEvents').then((_) {
            futureData = getData();
            setState(() {});
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

// class EventsScreen extends StatelessWidget {
//   final List events;
//   const EventsScreen({super.key, required this.events});
//   @override
//   Widget build(BuildContext context) {
//     print("masuk sini");
    // return ListView.builder(
    //     itemCount: events.isEmpty ? 0 : events.length,
    //     itemBuilder: (context, index) {
    //       return InkWell(
    //         child: Container(
    //           margin: const EdgeInsets.only(top: 20, right: 20, left: 20),
    //           height: 100,
    //           decoration: BoxDecoration(
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.10),
    //                 spreadRadius: 5,
    //                 blurRadius: 7,
    //                 offset: const Offset(0, 3),
    //               )
    //             ],
    //             borderRadius: const BorderRadius.only(
    //                 bottomLeft: Radius.circular(30),
    //                 topRight: Radius.circular(30),
    //                 topLeft: Radius.circular(10),
    //                 bottomRight: Radius.circular(10)),
    //             color: index % 2 == 0
    //                 ? const Color.fromRGBO(98, 182, 203, 1)
    //                 : const Color.fromRGBO(139, 111, 169, 1),
    //           ),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Text(
    //                 events[index]['eventName'],
    //                 style: const TextStyle(fontSize: 25, color: Colors.white),
    //               ),
    //               Text(
    //                 events[index]['timeDate'],
    //                 style: const TextStyle(fontSize: 15, color: Colors.white),
    //               )
    //             ],
    //           ),
    //         ),
    //         onTap: () {
    //           Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                   builder: (context) => UpdateEvents(
    //                       id: events[index]['id'],
    //                       name: events[index]['eventName'],
    //                       description: events[index]['eventDesc'],
    //                       time: events[index]['timeDate']))).then((_) {});
    //         },
    //       );
    //     });
//   }
// }
