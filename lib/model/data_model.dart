import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0) 
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String phone;

  @HiveField(3)
  final String address;

  @HiveField(4)
  dynamic i_mage;

  StudentModel(
      {required this.name,
      required this.age,
      required this.phone,
      required this.address,
      this.i_mage});
}
