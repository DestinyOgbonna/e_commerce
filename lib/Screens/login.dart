import 'package:e_commerce/Constants/textstyle_constant.dart';
import 'package:e_commerce/Screens/register.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:e_commerce/widgets/custombutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String _loginEmail;
  String _loginPassword;


  Future <String> _loginAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword
        (email: _loginEmail, password: _loginPassword);
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


  bool _loginFormLoading =false;

  void _loginForm () async{
     setState(() {
       _loginFormLoading = true;
     });

     String _loginAccountFeedBack = await _loginAccount();
     if(_loginAccountFeedBack != null)
       {
         _alertDialogBuilder(_loginAccountFeedBack);

         setState(() {
           _loginFormLoading = false;
         });
       }
  }

  //=================== Building the Alert Dialog Start====================
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
  //=================== Building the Alert Dialog End====================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // safearea to give a padding from the top and bottom of device screen
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 28.0),
                child: Text(
                  'Welcome User, \n  Login to your account',
                  textAlign: TextAlign.center,
                  style: Constant.boldHeading,
                ),
              ),
              //custom button created in the widget folder
              Column(
                children: [
              CustomInput(
                    hintText: 'Email..',
                    onChanged: (value){
                      _loginEmail = value;
                    },

                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },

                  textInputAction: TextInputAction.next
                  ),

               CustomInput(
                    onChanged:(value){
                      _loginPassword = value;
                    } ,
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    hintText: 'Password ..',

                 onSubmitted: (value){
                      _loginForm();
                 },
                  ),


                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                     _loginForm();
                    },
                    isLoading: _loginFormLoading,
                  ),
                ],
              ),

              //Create Account Button fix
              CustomButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                text: 'Create New Account',
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
