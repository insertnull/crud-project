import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  Future addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    return await FirebaseFirestore.instance
      .collection("Student")
      .doc(id)
      .set(studentInfoMap);
  }

  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return await FirebaseFirestore.instance.collection("Student").snapshots();
  }

  Future updateStudentDetails(String id, Map<String, dynamic> updateInfo) async{
    return await FirebaseFirestore.instance.collection("Student").doc(id).update(updateInfo);
  }

  Future deleteStudentDetails(String id) async{
    return await FirebaseFirestore.instance.collection("Student").doc(id);
  }
}