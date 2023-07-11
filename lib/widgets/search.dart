import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_app/widgets/person_details.dart';
import '../functions/db_functions.dart';
import '../model/data_model.dart';

/////////////////////////////////////////////search  delegate ////////////////////////////////////////////////////////////////////////////////////////////
// ignore: camel_case_types
class search extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(onPressed: () => query = "", 
      icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder:
            (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
          return ListView.builder(
            itemBuilder: (ctx, index) {
              final data = studentList[index];
            if (data.name.toLowerCase().contains(query.toUpperCase())) {
                return Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PersonalDetails(
                              a_: data.name,
                              b_: data.age,
                              c_: data.phone,
                              d_: data.address,
                              e_: data.i_mage,
                            ),
                          ),
                        );
                      },
                      title: Text(data.name),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(data.i_mage)),
                      ),
                    ),
                    const Divider()
                  ],
                );
              } else {
                return Container();
              }
            },
            itemCount: studentList.length,
          );
        });
  }

  @override
  // ignore: avoid_unnecessary_containers
  Widget buildSuggestions(BuildContext context) => Container(
        child: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext context, List<StudentModel> studentlist,
                Widget? child) {
              return ListView.builder(
                  itemCount: studentlist.length,
                  itemBuilder: (BuildContext context, index) {
                    final data = studentlist[index];

                    if (data.name
                        .toLowerCase()
                        .contains(query.toLowerCase().trim())) {
                      return Column(
                        children: [
                          ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PersonalDetails(
                                  a_: data.name,
                                  b_: data.age,
                                  c_: data.phone,
                                  d_: data.address,
                                  e_: data.i_mage,
                                ),
                              ),
                            ),
                            title: Text(data.name),
                            subtitle: Text(data.age),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(File(data.i_mage)),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  });
            }),
      );
}
