import 'package:flutter/material.dart';
import 'package:flutterhivesample/employee.dart';
import 'package:flutterhivesample/employee_list_screen.dart';
import 'package:hive/hive.dart';
 
class AddOrEditEmployeeScreen extends StatefulWidget {
  bool isEdit;
  int position;
  Employee employeeModel;
 
  AddOrEditEmployeeScreen(this.isEdit, [this.position,this.employeeModel]);
 
  @override
  State<StatefulWidget> createState() {
    return AddEditEmployeeState();
  }
}
 
class AddEditEmployeeState extends State<AddOrEditEmployeeScreen> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerSalary = new TextEditingController();
  TextEditingController controllerAge = new TextEditingController();
 
  @override
  Widget build(BuildContext context) {
 
    if (widget.isEdit) {
      controllerName.text = widget.employeeModel.empName;
      controllerSalary.text = widget.employeeModel.empSalary.toString();
      controllerAge.text = widget.employeeModel.empAge.toString();
    }
 
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Employee Name:", style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(controller: controllerName),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Employee Salary:", style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                            controller: controllerSalary,
                            keyboardType: TextInputType.number),
                      )
                    ],
                  ),
                  SizedBox(height: 60),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Employee Age:", style: TextStyle(fontSize: 18)),
                      SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                            controller: controllerAge,
                            keyboardType: TextInputType.number),
                      )
                    ],
                  ),
                  SizedBox(height: 100),
                  RaisedButton(
                    color: Colors.grey,
                    child: Text("Submit",
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () async {
                      var getEmpName = controllerName.text;
                      var getEmpSalary = controllerSalary.text;
                      var getEmpAge = controllerAge.text;
                      if (getEmpName.isNotEmpty &amp;&amp;
                          getEmpSalary.isNotEmpty &amp;&amp;
                          getEmpAge.isNotEmpty) {
                        if (widget.isEdit) {
                          Employee updateEmployee = new Employee(
                              empName: getEmpName,
                              empSalary: getEmpSalary,
                              empAge: getEmpAge);
                          var box = await Hive.openBox<Employee>('employee');
                          box.putAt(widget.position,updateEmployee);
                        } else {
                          Employee addEmployee = new Employee(
                              empName: getEmpName,
                              empSalary: getEmpSalary,
                              empAge: getEmpAge);
                          var box = await Hive.openBox<Employee>('employee');
                          box.add(addEmployee);
                        }
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => EmployeesListScreen()),
                                (r) => false);
                      }
                    },
                  )
                ],
              ),
            ),
          )
      ),
    );
  }
}