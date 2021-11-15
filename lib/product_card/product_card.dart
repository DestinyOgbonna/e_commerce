// ignore_for_file: deprecated_member_use

import 'package:e_commerce/Screens/product_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key key,
      this.onPressed,
      this.imageUrl,
      this.title,
      this.price,
      this.productId})
      : super(key: key);
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductPage(productId: productId)));
      },
      child: Container(
        height: 350,
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 23),
        child: Stack(
          children: [
            SizedBox(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //getting the product name & Price from the firebase database
                    Text(title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600)),
                    Text(price,
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
