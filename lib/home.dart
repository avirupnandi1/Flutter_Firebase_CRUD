import 'package:flutter/material.dart';

import 'pages/ListStudent.dart';
import 'pages/addstudent.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 217, 12),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Flutter Firestore CRUD',
            style: TextStyle(color: Colors.black54),
          ),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddStudentPage(),
                        ))
                  },
              child: Text(
                "Add",
                style: TextStyle(fontSize: 18.5),
              ))
        ]),
      ),
      body: ListStudentPage(),
      backgroundColor: Color.fromARGB(255, 223, 251, 252),
    );
  }
}
