import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  const ProductSize({Key key, this.sizeList, this.onSelected}) : super(key: key);

  final List sizeList;
  // to take the value of the selected size
  final Function(String) onSelected;

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _SelectedSize = 0;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left:30),
      child: Row(
        children: [
          for( var i = 0; i <widget.sizeList.length; i++)
            GestureDetector(
              onTap: (){
                widget.onSelected('${widget.sizeList[i]}');
                setState(() {
                  _SelectedSize = i;
                });
              },
              child: Container(
                width: 43,
                height: 43,
           decoration: BoxDecoration(
               color: _SelectedSize == i ? Colors.redAccent : Colors.grey,
               borderRadius: BorderRadius.circular(8),
           ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('${widget.sizeList[i]}', style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 16,
                    color:_SelectedSize == i ? Colors.white: Colors.black
                ),),
              ),
            )
        ],
      ),
    );
  }
}
