import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  const ImageSwipe({Key key, this.imageList}) : super(key: key);

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  //for the scroll indicators
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView(
            // ignore: avoid_types_as_parameter_names
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for (var i = 0; i < widget.imageList.length; i++)
                Image.network(
                  '${widget.imageList[i]}',
                  fit: BoxFit.cover,
                )
            ],
          ),
          Positioned(
            bottom: 15.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeOutCubic,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.withOpacity(0.5),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: _selectedPage == i ? 35 : 10.0,
                    height: 10.0,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
