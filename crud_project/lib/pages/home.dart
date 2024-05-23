import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_project/pages/student.dart';
import 'package:crud_project/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController agecontroller=new TextEditingController();
  TextEditingController addresscontroller=new TextEditingController();

  Stream? StudentStream;

  getontheload()async{
    StudentStream= await DatabaseMethods().getStudentDetails();
    setState((){

    });
  }

@override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allStudentDetails() {
    return StreamBuilder(
      stream: StudentStream,
      builder: (context, AsyncSnapshot snapshot) {
      return snapshot.hasData
      ? ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot ds=snapshot.data.docs[index];
          return Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Material (
              elevation: 5.0,
              borderRadius:BorderRadius.circular(10),
              child: Container (
                padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                        Text("Name : "+ds["Name"], 
                        style: TextStyle(
                          color: Colors.blue, 
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold) 
                          ),
                          
                          ]
                        ),
                        Spacer(),
                          GestureDetector(
                            onTap: (){
                              namecontroller.text=ds["Name"];
                              agecontroller.text=ds["Age"];
                              addresscontroller.text=ds["Address"];
                              editStudentDetail(ds["id"]);
                            },
                            
                            child: Icon(Icons.edit, color: Color.fromARGB(255, 46, 87, 30),)),
                            SizedBox(width:5.0),
                            GestureDetector(
                              onTap: () async {
                                await DatabaseMethods().deleteStudentDetails(ds["id"]);
                              },
                              child: Icon(Icons.delete, color: Colors.red)),
                        Text("Age : "+ds["Age"], 
                        style: TextStyle(
                          color: Colors.yellow, 
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold) ),
                        Text("Address : "+ds["Address"], 
                        style: TextStyle(
                          color: Colors.pink, 
                          fontSize: 20.0, 
                          fontWeight: FontWeight.bold) )

            ],
            )
            )
            )
            );
        }
        ): Container();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Student()));
      }, child: Icon(Icons.add)),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(
            "Classroom Masterlist", 
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
      ],
      ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allStudentDetails()),
        ],),
      ),
    );
  }

  Future editStudentDetail(String id)=> showDialog(context: context, builder: (context)=>AlertDialog(
    content: Container(
      child: Column(children: [
        Row(children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel)
          ),
          Text(
            "Edit Details", 
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ]),
        SizedBox(height: 30.0),
        Center(child: ElevatedButton(onPressed: () async{
          Map<String, dynamic>updateInfo={
            "Name": namecontroller.text,
            "Age": agecontroller.text,
            "id": id,
            "Address": addresscontroller.text,
          };
          await DatabaseMethods().updateStudentDetails(id, updateInfo).then((value) {});
          Navigator.pop(context);
        }, child: Text("Update details")))
      ],)
    ),
  )
  );

}