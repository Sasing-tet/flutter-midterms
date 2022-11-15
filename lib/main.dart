// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        // elevatedButtonTheme: const
      ),
      home: const MyHomePage(title: 'Flutter Midterms'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> todo = [];
  final TextController = TextEditingController();
  int? todoIndex;
  IconData buttonIcon = Icons.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        toolbarHeight: 100,
        title: Row(
          children: [
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.tealAccent, width: 1),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  hintText: 'Enter To Do List...'),
              controller: TextController,
            )),
            SizedBox(width: 10),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: TextController,
              builder: (context, value, child) {
                return ElevatedButton(
                  onPressed: value.text.isNotEmpty
                      ? () {
                          setState(() {
                            if (todoIndex != null) {
                              todo[todoIndex!] = TextController.text;
                              todoIndex = null;
                              buttonIcon = Icons.add;
                            } else {
                              todo.add(TextController.text);
                            }
                            TextController.clear();
                            print(todo);
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13)),
                  child: Icon(buttonIcon),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: todo.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 6, right: 6, left: 6),
              child: Card(
                child: ListTile(
                  title: Text(todo[index]),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        color: Color.fromARGB(255, 121, 219, 8),
                        onPressed: () {
                          todoIndex = index;
                          setState(() {
                            TextController.text = todo[index];
                            buttonIcon = Icons.save;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Color.fromARGB(255, 228, 28, 28),
                        onPressed: () {
                          setState(() {
                            todo.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                  // shape: RoundedRectangleBorder(
                  //   side: BorderSide(color: Colors.grey, width: 0.5),
                  //   borderRadius: BorderRadius.circular(5),
                  // ),
                ),
              ),
            );
          }),
    );
  }
}
