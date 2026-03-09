import 'package:crmmobile/Screens/add-new-lead.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../constant.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState> (); 
  late String _email; 
  late String _password;

  void signIn(BuildContext context) async{
    try{
     var authUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      if (authUser.user != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Addnewlead()));
      } 
    } catch (onError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar (content: Text("Invalid email or password"),duration: Duration(seconds: 3),backgroundColor: Colors.red,));
    }
    // .catchError((onError) {
    // }).then((authUser){
    //   if (authUser.user != null){
    //     Navigator.push(context, MaterialPageRoute(builder: (context) => Addnewlead()));
    //   }
    // }); 
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    // final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      appname,
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                    Text(Login),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _email = value!;
                        },
                        validator: (email) {
                          if(email!.isEmpty){
                            return "Please Enter Your Email";
                          } 
                          else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
                            return "It is not a valid email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          prefixIcon: Icon(Icons.email, color: primaryColor),
                          labelText: "Enter Your Email",
                          labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 10.0,
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _password = value!;
                        },
                        validator: (password) {
                          if(password!.isEmpty){
                            return "Please Enter your password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          prefixIcon: Icon(Icons.lock_open, color: primaryColor),
                          labelText: "Enter Your Password",
                          labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(forgotpassword,
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: height * 0.06,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              formKey.currentState?.save();
                              signIn(context);
                                // if( signIn() ){
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => Addnewlead()),);
                                //   FocusScope.of(context).unfocus();
                                // }
                                // else {
                                //   print("Invalid Login");
                                // }
                            }
                          },
                          child: Text(
                            logincomplete,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        TextButton(onPressed: () {}, child: Text(createaccount,
                        style: TextStyle(color: primaryColor, fontSize: 16)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
