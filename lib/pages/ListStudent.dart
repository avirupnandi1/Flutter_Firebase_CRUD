import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'updateStudentPage.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({super.key});

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream documentStream = FirebaseFirestore.instance
      .collection('students')
      .doc('ABC123')
      .snapshots();

  CollectionReference students =
      FirebaseFirestore.instance.collection('students');

  final Stream<QuerySnapshot> studentStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  Future<void> deleteUser(id) {
    return students
        .doc(id)
        .delete()
        .then((value) => print('user Deleted'))
        .catchError((error) => print("Failed to delete user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          final List storedocs = [];

          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Table(
                    border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      1: FixedColumnWidth(140),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text("Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ))),
                          TableCell(
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text("Email",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ))),
                          TableCell(
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                    child: Text("Action",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )))
                        ],
                      ),
                      for (var i = 0; i < storedocs.length; i++) ...[
                        TableRow(
                          children: [
                            TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['name'],
                                        style: TextStyle(fontSize: 17.0)))),
                            TableCell(
                                child: Center(
                                    child: Text(storedocs[i]['email'],
                                        style: TextStyle(fontSize: 17.0)))),
                            TableCell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateStudentPage(
                                                          id: storedocs[i]
                                                              ['id']),
                                                ))
                                          },
                                      icon: Icon(
                                          color: Colors.orange, Icons.edit)),
                                  IconButton(
                                    onPressed: () =>
                                        {deleteUser(storedocs[i]['id'])},
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]
                    ],
                  )));
        });
  }
}
