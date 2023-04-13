import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:hive/hive.dart';

import '../data/note.dart';

class EditNote extends StatefulWidget {
  EditNote(this.index, {required this.note, super.key});
  Note note;
  int index;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  TextEditingController? controllerTaskTitle;
  QuillController? controllerSubTaskTitle;
  int SelectedType = 0;

  final box = Hive.box<Note>('NoteBox');

  @override
  Widget build(BuildContext context) {
    setState(() {
      controllerTaskTitle = TextEditingController(text: widget.note.subject);
      controllerSubTaskTitle = QuillController.basic();
    });

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: controllerTaskTitle,
                    focusNode: negahban1,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      labelText: 'موضوع',
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: negahban1.hasFocus
                            ? Color(0xff18DAA3)
                            : Color.fromARGB(255, 46, 45, 45),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide:
                            BorderSide(color: Color(0xffC5C5C5), width: 3.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          width: 3,
                          color: Color(0xff18DAA3),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 44),
              //   child: Directionality(
              //     textDirection: TextDirection.rtl,
              //     // child: Column(
              //     //   children: [
              //     //     ZefyrToolbar.basic(controller: _controller),
              //     //     Expanded(
              //     //       child: ZefyrEditor(
              //     //         controller: _controller,
              //     //       ),
              //     //     ),
              //     //   ],
              //     // ),

              //     child: TextField(
              //       controller: controllerSubTaskTitle,
              //       maxLines: 3,
              //       focusNode: negahban2,
              //       decoration: InputDecoration(
              //         contentPadding:
              //             EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              //         labelText: 'متن',
              //         labelStyle: TextStyle(
              //           fontSize: 20,
              //           color: negahban2.hasFocus
              //               ? Color(0xff18DAA3)
              //               : Color.fromARGB(255, 46, 45, 45),
              //         ),
              //         enabledBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15)),
              //           borderSide:
              //               BorderSide(color: Color(0xffC5C5C5), width: 3.0),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(15)),
              //           borderSide: BorderSide(
              //             width: 3,
              //             color: Color(0xff18DAA3),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 650,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xffC5C5C5), width: 3.0),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        QuillToolbar.basic(controller: controllerSubTaskTitle!),
                        Container(
                          child: QuillEditor.basic(
                            controller: controllerSubTaskTitle!,
                            readOnly: false, // true for view only mode
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  String task1 = controllerTaskTitle!.text;
                  String task2 = controllerSubTaskTitle!.document
                      .insert(widget.index, widget.note.explane)
                      .toString();

                  addNote(task1, task2);
                  Navigator.pop(context);
                },
                child: Text(
                  'اضافه کردن نوت',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff18DAA3),
                  minimumSize: Size(200, 40),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  addNote(String task, String subTask) {
    widget.note.subject = task;
    widget.note.explane = subTask;
    widget.note.save();
  }
}