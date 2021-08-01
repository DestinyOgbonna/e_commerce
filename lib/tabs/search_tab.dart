import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/product_card/product_card.dart';
import 'package:e_commerce/services/FirebaseAuth_Services/firebase_services.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class Search_tab extends StatefulWidget {

   Search_tab({Key key}) : super(key: key);

  @override
  State<Search_tab> createState() => _Search_tabState();
}

class _Search_tabState extends State<Search_tab> {
  FirebaseServices _firebaseServices = FirebaseServices();
// to store the input on the text field
  String _searchString ='';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if(_searchString.isEmpty)
            Center(
              child: Container(
                  child:
                  const Text('Search Result ..', style: Constant.regularDarkText,)),
            )
          else
          FutureBuilder<QuerySnapshot>(
            //searching for proscts
            future: _firebaseServices.productsRef.orderBy('search_string').
             startAt([_searchString])
            // special character for advanced Search
                .endAt(['$_searchString\uf8ff']).get(),
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
          Padding(
            padding: const EdgeInsets.only(top: 55),
            child: CustomInput(
              hintText: ' Search here ..',
              onSubmitted: (value){
                // if (value.isNotEmpty){
                 setState(() {
                   _searchString = value.toLowerCase();
                 });
                }
              // },
            ),
          ),
          // const Text(
          //   'Search',
          //   style: Constant.regularDarkText,
          // ),


        ],
      ),
    );
  }
}
