// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../functions/db_functions.dart';
import 'list_student_widget.dart';
import '../model/data_model.dart';

// ignore: must_be_immutable, camel_case_types
class edit_student extends StatefulWidget {
  var stdname;
  var stdage;
  var stdaddress;
  var stdphone;
  dynamic stdimage;

  int index;

  // ignore: use_key_in_widget_constructors
  edit_student(
      {required this.index,
      required this.stdname,
      required this.stdage,
      required this.stdaddress,
      required this.stdphone,
      required this.stdimage});

  @override
  State<edit_student> createState() => _edit_studentState();
}

// ignore: camel_case_types
class _edit_studentState extends State<edit_student> {
  File? _file; //

  final space = const SizedBox(
    height: 30,
  );

  TextEditingController studentname = TextEditingController();

  TextEditingController _studentage = TextEditingController();

  TextEditingController _studentaddress = TextEditingController();

  TextEditingController _studentphone = TextEditingController();

  String profilephoto = '';

  @override
  void initState() {
    super.initState();
    studentname = TextEditingController(text: widget.stdname);
    _studentage = TextEditingController(text: widget.stdage);
    _studentaddress = TextEditingController(text: widget.stdaddress);
    _studentphone = TextEditingController(text: widget.stdphone);
    profilephoto = widget.stdimage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ListStudentWidget())),
                icon: const Icon(Icons.home))
          ],
          title: const Text(
            "Edit List",
            style: TextStyle(fontSize: 25),
          ),
          shadowColor: Colors.grey,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 109, 154, 221),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () => getimage(),
                            icon: const Icon(Icons.camera_alt_outlined)),
                      ),
                      Container(
                        child: _file != null
                            ? CircleAvatar(
                                radius: 80,
                                child: SizedBox(
                                  width: 160,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(110),
                                    child: Image.file(
                                      _file!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(File(widget.stdimage)),
                                radius: 80,
                              ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 109, 154, 221),
                            borderRadius: BorderRadius.circular(50)),
                        child: IconButton(
                            onPressed: () => getimage(),
                            icon: const Icon(Icons.photo_sharp)),
                      ),
                    ],
                  ),
                  space,
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: studentname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Name',
                            filled: true,
                          ),
                        ),
                        space,
                        TextFormField(
                          controller: _studentage,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Age',
                            filled: true,
                          ),
                        ),
                        space,
                        TextFormField(
                          controller: _studentphone,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone',
                            filled: true,
                          ),
                        ),
                        space,
                        TextFormField(
                          controller: _studentaddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Address',
                            filled: true,
                          ),
                        ),
                        space,
                        SizedBox(
                          width: 400,
                          height: 50,
                          /////////////////////////////Elevated button////////////////////////////////////
                          child: ElevatedButton.icon(
                            onPressed: () {
                              edtingall();
                            },
                            icon: const Icon(Icons.flag),
                            label: const Text(
                              "UPDATE",
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[900]),
                          ),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> edtingall() async {
    final st1 = studentname.text.trim();
    final st2 = _studentage.text.trim();
    final st3 = _studentaddress.text.trim();
    final st4 = _studentphone.text.trim();

    if (st1.isEmpty ||
        st2.isEmpty ||
        st3.isEmpty ||
        st4.isEmpty ||
        profilephoto.isEmpty) {
      return;
    } else {
      final updation = StudentModel(
          name: st1, age: st2, phone: st3, address: st4, i_mage: profilephoto);

      update(widget.index, updation);
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const ListStudentWidget()));

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 7, 27, 112),
          content: Text("Updated")));
    }
  }

  getimage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final XFile? _wantimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (_wantimage != null) {
      setState(() {
        _file = File(_wantimage.path);
        profilephoto = _wantimage.path;
      });
    }
  }
}
