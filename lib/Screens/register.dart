import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
        //================== Building the alert Dialog======
  Future<void> _alertDialogBuilder( String error) async {
    return showDialog(
        //==========prevents closing the error when tapping any part of the screen
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            // ignore: avoid_unnecessary_containers
            content: Container(
              // adding the String *error* value to the text
              child:  Text(error),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              )
            ],
          );
        });
  }

      //================== Creating new User Account.========
  Future<String> _createAccount() async {

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword
        (email: _registerEmail, password: _registerPassword);
      return null;
    }
    on FirebaseAuthException catch (e)
    {

      if (e . code == 'Weak password')
      {
        return'the password provided is too weak';
      }
      else if (e.code == 'Email already in use')
      {
        return'the account is already in use';
      }
      return e.message;
      }

      catch (e)
    {
      return e.toString();
    }
    }

    //=====================  Submit Form ================

  void _submitForm() async{
    //==== setting the loading state
    setState(() {
      //================  displaying the circularProgressBar ================
      _registerFormLoading = true;
    });
    //create account feedback was created to provide error feedBacks
    String _createAccountFeedBack = await  _createAccount();
    if( _createAccountFeedBack != null)
    {
      _alertDialogBuilder(_createAccountFeedBack);
      //===============Closing the CircularProgressBar=========
      setState(() {
        _registerFormLoading = false;
      });
    }
  }
            // implementing the circular loader.
  bool _registerFormLoading = false;

  // Creating Texts input fields to accept the values
  String _registerEmail = '';
  String  _registerPassword = '';

  //===============Creating a FocusNode for the Input Fields Start==========
  FocusNode _passwordFocusNode;

  //==================initializing the password focus node ===============
  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    // TODO: implement initState
    super.initState();
  }

  //============= Disposing the Password Focus Node================
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  //===============Creating a FocusNode for the Input Fields End==========

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //============== safeArea to give a padding from the
      //=============top and bottom of device screen======
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Text(
                  'Create your account',
                  textAlign: TextAlign.center,
                  style: Constant.boldHeading,
                ),
              ),
              //===========custom button created in the widget folder========
              Column(
                children: [
                  //==================Email Text Field=============
                  CustomInput(
                    hintText: 'Email ...',

                    onChanged: (value) {
                      _registerEmail = value;
                    },

                    //=======On press enter the focus should move to the password field.======//
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    //========== Changes the enter button to next button on the keyboard.========
                    textInputAction: TextInputAction.next,
                  ),

                  //================Password Text Field=============

                  CustomInput(
                    //receiving the value from the textField
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    hintText: 'Password ...',
//======== THis Submits the form ======================
                    onSubmitted:(value) {
                      _submitForm();
                    },
                  ),

                  // Register Button
                  CustomButton(
                    text: 'Register',
                    onPressed: () {
                      _submitForm();
                    },
                    //Displaying the circular progress bar
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),

              //Login Account Button fix
              CustomButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Login',
                //setting the outline button to true. so to be transparent
                outlineBtn: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
