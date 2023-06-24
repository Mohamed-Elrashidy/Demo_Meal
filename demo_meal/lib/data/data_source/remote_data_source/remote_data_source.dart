import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class RemoteDataSource{
//get data from firebase
Future<List<Map<String, dynamic>>>getDataCollection(String path)
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
getDataDocumentation(String collectionPath,String documentId)
async {
   CollectionReference data = FirebaseFirestore.instance.collection(collectionPath);
   var datafetched= await data.doc(documentId).get();
   print("data is => "+ datafetched.data().toString());
   return datafetched.data() as Map<String,dynamic>;

}
addDataDocument(String collectionPath,dynamic data)
async {
  print ('reached => '+data.toString());
  final collectionReference = FirebaseFirestore.instance.collection(collectionPath);
  final documentReference = collectionReference.doc(data['id']);
  await documentReference.set(data);

}
updateDocumentAttribute(String collectionPath,List<String> documentIds,String attributeName,String newValue)
async {
  final collectionReference = FirebaseFirestore.instance.collection(collectionPath);
  for (final documentId in documentIds) {
    final documentReference = collectionReference.doc(documentId);
    final documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      final data = documentSnapshot.data();
      data![attributeName] = newValue;
      await documentReference.update(data);
    }
  }

}
     signIn(String email,String password)
    async {
    try{  UserCredential cerdintial = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);


    }
        catch(e)
      {
        print(e);
      }
    }
    Future<void> signOut()
    async {
      await FirebaseAuth.instance.signOut();

    }

}