import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/Screens/product_page.dart';
import 'package:e_commerce/product_card/product_card.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeTab extends StatelessWidget {
  HomeTab({Key key}) : super(key: key);

  // Accessing the data stored in the cloud storage.
  // the data under products is being accessed
 final CollectionReference  _productsRef =
     FirebaseFirestore.instance.collection('Products');



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children:  [

          // Creating a connection with the cloud fireStore to display items

          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot){
               if(snapshot.hasError){
                 return Scaffold(
                   body: Center(
                     child: Text('Error: ${snapshot.error}',
                         style:Constant.regularHeading),
                   ),
                 );
               }

               // Connection Successful Display data Below
               if (snapshot.connectionState == ConnectionState.done)
                 // Display data gotten from the cloud firestore in a listView
                 {

                   return ListView(
                     padding: EdgeInsets.only(top:  130, bottom: 13),
                     // the map gives us the list of documents
                     children: snapshot.data.docs.map((document){
                       return ProductCard(
                        title: (document.data() as dynamic)['name'],
                         imageUrl: (document.data() as dynamic)['images'][0],
                         price: '\$${(document.data()as dynamic)['Price']}',
                         // onPressed: (){
                         //  Navigator.push(context, MaterialPageRoute(builder: (contect)=> ProductPage(ProductId:document.id)));
                         // },
                         productId: document.id,
                       );
                     }).toList()
                   );
               }

               return const  Scaffold(
                 body: Center(
                   child: CircularProgressIndicator(),
                 ),
               );
            },
          ),
          CustomActionBar(
           title: 'Home',
           hasBackArrow:false,
         ),
        ],
      ),
    );
  }
}
