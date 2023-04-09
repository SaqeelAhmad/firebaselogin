import 'package:firebaselogin/utils/utils.dart';
import 'package:firebaselogin/widgets/Coustom_Button.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class FirestoreDataSent extends StatefulWidget {
  const FirestoreDataSent({Key? key}) : super(key: key);

  @override
  State<FirestoreDataSent> createState() => _FirestoreDataSentState();
}

class _FirestoreDataSentState extends State<FirestoreDataSent> {


  final CollectionReference userCollection =
  FirebaseFirestore.instance.collection("users");
  void firebasefirestore()  {
    final id = DateTime.now().microsecondsSinceEpoch;
    userCollection.doc(id.toString()).set({
'email': "saqeel816@gmail.com",
'name': "saqeel816",
      'id': id.toString(),

    }).then((value) {
      Utils().toastMessage("you post is complet");
   }).onError((error, stackTrace){
      Utils().toastMessage(error.toString());
   });
  }

  bool loading = false;
String id= '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CoustomButton(title: 'set data in database', onTap: (){
            firebasefirestore();
          }, isLoading: loading,),
          CoustomButton(title: "Delete data from database.",
              onTap: (){
                //userCollection.doc(id).delete();
              },
              isLoading: loading),
Expanded(
  child:   StreamBuilder(
  // please of your data location
    stream: FirebaseFirestore.instance.collection("users").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {

      if(snapshot.hasData){

        if(snapshot.data!.docs.isEmpty){

        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){

          return InkWell(
            onLongPress: (){
              print('kjkljl');
            },
            child: Card(

                child:  Column(
                  children: [
                    Text(snapshot.data!.docs[index]['email']),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(snapshot.data!.docs[index]['image'].toString()

                          ),
                        )
                      ),
                    )
                  ],
                ),

              ),
          );
        });
      }else{
        return Container(
          child: const Text('Data is null'),
        );
      }
  },
  
      
  ),
),

        ],
      ),
    );
  }
}
