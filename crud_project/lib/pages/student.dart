import 'package:crud_project/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController agecontroller=new TextEditingController();
  TextEditingController addresscontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            "Student", 
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
      ],),),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(
          "Name", 
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20.0, 
            fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: namecontroller,
            decoration: InputDecoration(border: InputBorder.none),
          ),

        ),
        SizedBox(height: 20.0),
        Text(
          "Age", 
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20.0, 
            fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: agecontroller,
            decoration: InputDecoration(border: InputBorder.none),
          ),
          
        ),
        
        SizedBox(height: 20.0),
        Text(
          "Address", 
          style: TextStyle(
            color: Colors.black, 
            fontSize: 20.0, 
            fontWeight: FontWeight.bold),),
          SizedBox(height: 10.0,),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: addresscontroller,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
        SizedBox(height: 30.0,),
        Center(
        child: ElevatedButton(
          onPressed: () async{
            String id= randomAlphaNumeric(10);
          Map<String, dynamic> studentInfoMap={
            "Name": namecontroller.text,
            "Age": agecontroller.text,
            "id": id,
            "Address": addresscontroller.text,
          };
          await DatabaseMethods().addStudentDetails(studentInfoMap, id).then((value){
            Fluttertoast.showToast(
        msg: "Student Details have been uploaded!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
          });
        }, child: Text("Add", style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)))
        )
      ],),)
    
    );
  }
}