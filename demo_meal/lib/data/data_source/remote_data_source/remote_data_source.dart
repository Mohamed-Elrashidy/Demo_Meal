import 'package:cloud_firestore/cloud_firestore.dart';
class RemoteDataSource{

//get data from firebase
Future<List<Map<String, dynamic>>>getData(String path)
  async {
    // make reference to data endpoint
    CollectionReference collectionReference = FirebaseFirestore.instance.collection(path);
   // get data
    QuerySnapshot querySnapshot = await collectionReference.get();
          print ( "query snapshot is =>");
          print(querySnapshot);

    // get exact data from the response
    List<Map<String, dynamic>> dataList = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      //print("recieved data is =>"+document.data().toString());
      dataList.add(document.data() as Map<String,dynamic> );
    });

  /*  print("Data is =>");
print(dataList);*/
    return dataList;
    }

}