import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/mainViewModel.dart';

import 'PopulateDatabase.dart';
import 'login.dart';

class AccountCreationPage extends StatefulWidget {
  final db;
  final MainViewModel mvm;

  const AccountCreationPage(this.db, this.mvm, {Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<AccountCreationPage> {

  final nameFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final reenterPasswordFieldController = TextEditingController();
  final errorFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasError = false;

  String _name = "";
  String _username = "";
  String _password = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameFieldController.dispose();
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    reenterPasswordFieldController.dispose();
    errorFieldController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final _bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Create Account", style: TextStyle(fontSize: 24),),
        ),
        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(left: 20, right:20, bottom: _bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                  )
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    height: 150,
                    child: Image.asset("assets/CuteYellowCow_transparent.png"),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameFieldController,
                        style: TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          hintText: "Your Name",
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 20),
                          errorStyle: TextStyle(fontSize: 16),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (name){
                          if(name == null  || name.isEmpty){
                            return "Please enter your name";
                          }else if(name.length > 10){
                            return "Name cannot exceed 10 characters";
                          }
                          return null;
                        },
                        onSaved: (name)=> _name = name!,
                      ),
                      TextFormField(
                        controller: usernameFieldController,
                        style: TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          hintText: "Your username",
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 20),
                          errorStyle: TextStyle(fontSize: 16),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (username) {
                          if(username == null  || username.isEmpty){
                            return "Please create a username.";
                          }else if(username.length > 10){
                            return "Username must not exceed 10 characters";
                          }
                          return null;
                        },
                        onSaved: (username)=> _username = username!,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: passwordFieldController,
                        style: TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          hintText: "Create a password",
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 20),
                          helperText: "Password must be at least 8 characters",
                          helperStyle: TextStyle(fontSize: 16),
                          suffixIcon: Icon(Icons.lock),
                          errorStyle: TextStyle(fontSize: 16),
                          contentPadding: EdgeInsets.all(10),
                          icon: Icon(Icons.visibility_off),
                        ),
                        validator: (pass){
                          if(pass == null  || pass.isEmpty){
                            return "Please create a password";
                          } else if(!checkPassForCorrectness(pass)){
                            reenterPasswordFieldController.clear();
                            passwordFieldController.clear();
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                        onSaved: (pass)=> _password = pass!,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: reenterPasswordFieldController,
                        style: TextStyle(fontSize: 20),
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        decoration: InputDecoration(
                          hintText: "Re-Enter your password",
                          labelText: "ReenterPassword",
                          labelStyle: TextStyle(fontSize: 20),
                          errorStyle: TextStyle(fontSize: 16),
                          contentPadding: EdgeInsets.all(10),
                          icon: Icon(Icons.visibility_off),
                        ),
                        validator: (pass){
                          if(pass == null  || pass.isEmpty){
                            return "Please reenter your password";
                          } else if(pass != passwordFieldController.text){
                            reenterPasswordFieldController.clear();
                            passwordFieldController.clear();
                            return "Passwords do not match.";
                          }
                          return null;
                        },
                      ),
                      Visibility(
                        child: TextField(
                          controller: errorFieldController,
                          readOnly: true,
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ),
                        visible: _hasError,
                      ),

                      Padding(
                        padding: EdgeInsets.all(10),
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: Container(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.yellow),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  side: BorderSide(
                                    color: const Color(0xff40454b),
                                    width: 3,
                                    style: BorderStyle.solid
                                  ),
                                )
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Sign up",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            onPressed: () async{
                              errorFieldController.clear();
                              if(_formKey.currentState!.validate()){
                                _formKey.currentState!.save();
                                bool userAdded = await widget.mvm.addUser(_name, _username, password: _password);
                                if(userAdded) {
                                  PopulateDatabase.populateDb(widget.mvm);
                                  nameFieldController.clear();
                                  usernameFieldController.clear();
                                  passwordFieldController.clear();
                                  reenterPasswordFieldController.clear();
                                  Navigator.push(context, new MaterialPageRoute(
                                      builder: (context) => LoginPage(widget.db, widget.mvm)
                                  ));
                                } else{
                                  usernameFieldController.clear();
                                  reenterPasswordFieldController.clear();
                                  passwordFieldController.clear();
                                  setState(() { _hasError = true; });
                                  errorFieldController.text = "Username already taken";
                                }
                              }
                            },
                          ),
                        )
                      )
                    ]
                  ))
              ],
            ),
          )
        )
    );
  }

  bool checkPassForCorrectness(String p){
    if(p.split("").length >= 8){
      return true;
    }
    return false;
  }

}