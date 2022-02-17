import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'employee.g.dart';
 
@HiveType(typeId: 0)
class Employee{
 
  @HiveField(0)
  String empName;
 
  @HiveField(1)
  String empSalary;
 
  @HiveField(2)
  String empAge;
 
  Employee({this.empName, this.empSalary, this.empAge});
 
}