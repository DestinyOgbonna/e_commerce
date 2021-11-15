import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/Screens/product_page.dart';
import 'package:e_commerce/services/FirebaseAuth_Services/firebase_services.dart';
import 'package:flutter/material.dart';

class SavedTab extends StatelessWidget {
  SavedTab({Key key}) : super(key: key);
  final FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<QuerySnapshot>(
          future: _firebaseServices.usersRef
              .doc(_firebaseServices.getUserId())
              .collection('Saved')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: Text('Error: ${snapshot.error}',
                      style: Constant.regularHeading),
                ),
              );
            }

            // Connection Successful Display data Below
            if (snapshot.connectionState == ConnectionState.done)
            // Display data gotten from the cloud firestore in a listView
            {
              return ListView(
                  padding: const EdgeInsets.only(top: 130, bottom: 13),
                  // the map gives us the list of documents
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(productId: document.id)));
                      },
                      child: FutureBuilder(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
//checking Errors
                            if (productSnap.hasError) {
                              return Center(
                                child: Text('${productSnap.error}'),
                              );
                            }

                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              // map to pupolate the container
                              Map _productMap = productSnap.data.data();
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 19.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 90,
                                      height: 90,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          (8.0),
                                        ),
                                        child: Image.network(
                                          '${_productMap['images'][0]}',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_productMap['name']}',
                                            style: TextStyle(
                                                // ignore: deprecated_member_use
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4.0,
                                            ),
                                            child: Text(
                                              '\$${_productMap['Price']}' ??
                                                  'Product Price',
                                              style: TextStyle(
                                                // ignore: deprecated_member_use
                                                fontSize: 18,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          // Text('Size - ${document.data.data()['Size']}', style: const TextStyle(
                                          //   fontSize: 16, color:Colors.black,
                                          //   fontWeight: FontWeight.w600,
                                          // ),
                                          // ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    );
                  }).toList());
            }

            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        // CustomActionBar(
        //   title: 'Saved',
        // ),

        const Padding(
          padding: EdgeInsets.only(top: 60, left: 31),
          child: Text(
            'Saved Items',
            style: Constant.boldHeading,
          ),
        )
      ],
    );
  }
}
