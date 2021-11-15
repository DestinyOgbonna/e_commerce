import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CustomButton(
      {this.text, this.outlineBtn, this.isLoading, this.onPressed});

  //created for easy initialization.

  final String text;
  final Function onPressed;
  final bool outlineBtn;
  // is loading is a boolean  for the circularprogressbar.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
// created to control the colors of the customButton
    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          // if the outline button is true use colors.transparent,
          // if false use colors,black
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black54,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Stack(children: [
          //  visibility widget to control the display of the text
          Visibility(
            visible: _isLoading ? false : true,
            child: Center(
              child: Text(
                // text is null display Text
                text ?? 'Text',
                style: TextStyle(
                  fontSize: 16.0,
                  // if the outline button is true color should be black,
                  // if false colour should be white
                  color: _outlineBtn ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),

          Visibility(
            //  visibility widget to control the display of the CircularProgressIndicator
            // displaying circle progress indicator
            visible: _isLoading,
            child: const Center(
              child: SizedBox(
                  height: 30, width: 30, child: CircularProgressIndicator()),
            ),
          ),
        ]),
      ),
    );
  }
}
