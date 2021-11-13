import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/mainViewModel.dart';
import 'package:moovi/database/userEntity.dart';

import '../main.dart';
import 'accountCreation.dart';

class LoginPage extends StatefulWidget{

  // static late String username;
  static late UserEntity user; //will hold the userEntity of the currently logged in user

  final db;
  final MainViewModel mvm;
  const LoginPage(this.db, this.mvm, {Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

class _MyCustomFormState extends State<LoginPage>{

  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final errorFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String password = "";
  String username = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign In"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
              children: [
                TextFormField(
                    controller: usernameFieldController,
                    decoration: InputDecoration(
                      hintText: "Your username",
                      labelText: "Username",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  validator: (username){
                    if(username == null  || username.isEmpty){
                      usernameFieldController.clear();
                      passwordFieldController.clear();
                      return "Please enter your username.";
                    }
                    return null;
                  },
                  onSaved: (_username) => username = _username!,
                ),
                TextFormField(
                    obscureText: true,
                    controller: passwordFieldController,
                    decoration: InputDecoration(
                      hintText: "Your password",
                      labelText: "Password",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  validator: (pass){
                    if(pass == null  || pass.isEmpty){
                      passwordFieldController.clear();
                      return "Please enter your password.";
                    }
                    return null;
                  },
                  onSaved: (pass) => password = pass!,
                ),
                TextField(
                  controller: errorFieldController,
                  readOnly: true,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                    children: <Widget> [
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      SizedBox(
                        width: 190,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[800])),
                          child: Align(
                            alignment: Alignment.center,

                            child: Text(
                              "No Account? Sign up!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: (){
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => AccountCreationPage(widget.db, widget.mvm)
                            ));
                          },

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      SizedBox(
                        width: 190,
                        height: 50,
                        child: TextButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey[700])),
                          child: Align(
                            alignment: Alignment.center,

                            child: Text(
                              "Sign in",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onPressed: () async{
                            errorFieldController.clear();

                            if(_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              UserEntity? user = await widget.mvm.
                                  getUserbyUsernameAndPass(username, password);

                              if (user == null) {
                                usernameFieldController.clear();
                                passwordFieldController.clear();
                                errorFieldController.text = "Your username or password was incorrect.";
                              } else {
                                LoginPage.user = user;
                                Navigator.push(context, new MaterialPageRoute(
                                    builder: (context) => MyApp(widget.db)
                                ));
                              }

                            }

                          },

                        ),
                      ),
                    ]
                )

              ]
        ))
    );
  }

}