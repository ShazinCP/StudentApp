// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/functions/db_functions.dart';
import 'package:student_app/widgets/list_student_widget.dart';
import 'package:student_app/model/data_model.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _phoneController = TextEditingController();

  final _addressController = TextEditingController();

  File? file;

  ImagePicker image = ImagePicker();

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.person_add_alt_1, size: 35),
          title: const Text("Add Student"),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: ListView(
              children: [
                // ignore: avoid_unnecessary_containers
                Container(
                  child: CircleAvatar(
                    radius: 80,
                    child: file == null
                        ? const CircleAvatar(
                            radius: 90,
                            backgroundImage:
                                AssetImage("assets/download (2).png"),
                          )
                        : SizedBox(
                            height: 200,
                            width: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                file!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900]),
                          onPressed: () {
                            getcam();
                          },
                          child: const Text(
                            "Take picture",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[900]),
                          onPressed: () {
                            getgall();
                          },
                          child: const Text(
                            "From gallery",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Name',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _ageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Phone',
                    filled: true,
                  ),
                ),
                const SizedBox(height: 25.0),
                TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _addressController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[900]),
                    onPressed: () {
                      onAddStudentButtonCliked(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("ADD STUDENT"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onAddStudentButtonCliked(BuildContext context) async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _phone = _phoneController.text.trim();
    final _address = _addressController.text.trim();

    if (_name.isEmpty ||
        _age.isEmpty ||
        _phone.isEmpty ||
        _address.isEmpty ||
        file!.path.isEmpty) {
      return;
    } else {
      final _student = StudentModel(
          name: _name,
          age: _age,
          phone: _phone,
          address: _address,
          i_mage: file!.path);

      addStudent(_student);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => ListStudentWidget(
                a_ge: _age,
                na_me: _name,
              )),
        ),
      );
    }
  }

  getcam() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }

  getgall() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
    });
  }
}
