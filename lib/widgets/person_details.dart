// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PersonalDetails extends StatelessWidget {
  var a_;
  var b_;
  var c_;
  var d_;
  dynamic e_;

  PersonalDetails(
      {super.key,
      required this.a_,
      required this.b_,
      required this.c_,
      required this.d_,
      this.e_});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Person Details"),
        ),
        body: Container(
          color: Colors.yellow[200],
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image(image: FileImage(File(e_))),
              ),
              Text(
                 a_,
                style: const TextStyle(fontSize: 30),
              ),
              Text(
                b_,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                c_,
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                d_,
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
