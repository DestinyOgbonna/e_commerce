import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/services/FirebaseAuth_Services/firebase_services.dart';
import 'package:e_commerce/widgets/custom_action_bar.dart';
import 'package:e_commerce/widgets/image_swipe.dart';
import 'package:e_commerce/widgets/product_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key key,
    this.productId,
  }) : super(key: key);

  final String productId;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  //getting the user id. from the firebase_services Package
  FirebaseServices _firebaseServices = FirebaseServices();

  //to send the selectedSIze to database
  String _selectedProductSize = '0';

  //Connection References to firebase Start ==========

//   final CollectionReference _productsRef =
//       FirebaseFirestore.instance.collection('Products');
//
// // a new reference for adding to cart
//   final CollectionReference _usersRef =
//   FirebaseFirestore.instance.collection('Users');

// Connection References to firebase End==========

// ================Getting the user Id (another option)====
//   User _user = FirebaseAuth.instance.currentUser;
  // ================Getting the user Id( Another Option)====

//adding Items to cart
  Future _addtoCart() {
    // return _usersRef.doc(_user.uid)// when using User _user

    // return _usersRef.doc(_firebaseServices.getUserId())

    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  Future _addtoSaved() {
    // return _usersRef.doc(_user.uid)// when using User _user

    // return _usersRef.doc(_firebaseServices.getUserId())

    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection('Saved')
        .doc(widget.productId)
        .set({'size': _selectedProductSize});
  }

  //a snackBar to notify the user that products have been added to cart
  final SnackBar _snackbar = SnackBar(content: Text('Added to cart'));
  final SnackBar _snackbars = SnackBar(content: Text('Added to Favourite'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            //getting all the details of the various products bu the product id

            // future: productsRef.doc(widget.ProductId).get(),
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${snapshot.error}',
                        style: Constant.regularHeading),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data.data();

                //creating a list of images
                List imageList = documentData['images'];
                List sizeList = documentData['Size'];

                //setting initial Size value from the first value in the page
                _selectedProductSize = sizeList[0];

                return ListView(
                  padding: EdgeInsets.all(0),
                  children: [
                    // the product slider
                    ImageSwipe(
                      imageList: imageList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, top: 34, left: 34, right: 34),
                      child: Text('${documentData['name']}' ?? 'Product Name',
                          style: Constant.boldHeading),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 34),
                      child: Text('${documentData['Price']}' ?? 'Product Price',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 34),
                      child: Text('${documentData['desc']}' ?? 'Description',
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 34),
                      child: Text(
                        'Size',
                        style: Constant.regularDarkText,
                      ),
                    ),
                    ProductSize(
                      sizeList: sizeList,
                      onSelected: (size) {
                        _selectedProductSize = size;
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap:() async{
                              await _addtoSaved();
                              Scaffold.of(context).showSnackBar(_snackbars);
                          },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    'images/icons/icons_favourite.png'),
                                height: 30,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                          Expanded(
                            //setting a gestureDetector to add to cart
                            child: GestureDetector(
                              onTap: () async {
                                await _addtoCart();
                                Scaffold.of(context).showSnackBar(_snackbar);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(left: 16),
                                height: 65,
                                // width:double.infinity ,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(13.0)),
                                alignment: Alignment.center,
                                child:const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }

              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }),
        CustomActionBar(
          hasTitle: false,
          hasBackArrow: true,
          hasBackground: false,
        ),
      ],
    ));
  }
}
