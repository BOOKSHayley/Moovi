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
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Create Account"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
              children: [
                TextFormField(
                    controller: nameFieldController,
                    decoration: InputDecoration(
                      hintText: "Your Name",
                      labelText: "Name",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  validator: (name){
                      if(name == null  || name.isEmpty){
                        return "Please enter some text";
                      }else if(name.length > 10){
                        return "Name must not exceed 10 characters";
                      }
                      return null;
                  },
                  onSaved: (name)=> _name = name!,
                ),
                TextFormField(
                    controller: usernameFieldController,
                    decoration: InputDecoration(
                      hintText: "Your username",
                      labelText: "Username",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  validator: (username) {
                    if(username == null  || username.isEmpty){
                      return "Please enter a username.";
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
                    decoration: InputDecoration(
                      hintText: "Create a password",
                      labelText: "Password",
                      helperText: "Password must be at least 8 characters",
                      suffixIcon: Icon(Icons.lock),
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
                    decoration: InputDecoration(
                      hintText: "Re-Enter your password",
                      labelText: "ReenterPassword",
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
                TextField(
                  controller: errorFieldController,
                  readOnly: true,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                        Colors.blue[800])),
                    child: Align(
                      alignment: Alignment.center,

                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
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
                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(widget.db, widget.mvm)
                          ));
                        } else{
                            usernameFieldController.clear();
                            reenterPasswordFieldController.clear();
                            passwordFieldController.clear();
                            errorFieldController.text = "Username already taken";
                        }
                      }
                    },

                  ),
                )
              ]
          ))
    );
  }

  bool checkPassForCorrectness(String p){
    if(p.split("").length >= 8){
      return true;
    }
    return false;
  }

}