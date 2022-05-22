import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'todo_model.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoModel> todos = [];
  TextEditingController inputController = TextEditingController(text: '');
  String name = "Rifqi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        children: [
          const SizedBox(
            height: 76,
          ),
          Row(
            children: [
              Text(
                DateFormat('dd MMMM y').format(DateTime.now()),
                style: GoogleFonts.roboto(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff0707EE),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Instagram_logo_2016.svg/768px-Instagram_logo_2016.svg.png',
                width: 32,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'You have ${todos.length} tasks today',
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          const SizedBox(
            height: 16,
          ),
          todos.isEmpty
              ? const Text(
                  'Tidak ada task hari ini',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              : Column(
                  children: todos.mapIndexed((index, todo) {
                    return CheckboxListTile(
                      value: todo.isFinished,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            todos[index].isFinished = value;
                          });
                        }
                      },
                      contentPadding: EdgeInsets.zero,
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        todo.title,
                        style: TextStyle(
                          decoration: todo.isFinished
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 30,
          left: 16,
          right: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: inputController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Add todo...',
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                if (inputController.text.isNotEmpty) {
                  setState(() {
                    todos.add(
                      TodoModel(
                        inputController.text,
                        false,
                      ),
                    );
                    inputController.text = '';
                  });
                }

                print(todos);
              },
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add_circle,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
