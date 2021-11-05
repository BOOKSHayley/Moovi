import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/mainViewModel.dart';

import 'login.dart';

class AccountCreationPage extends StatefulWidget {
  final db;
  final mvm;

  const AccountCreationPage(this.db, this.mvm, {Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<AccountCreationPage> {

  final nameFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final reenterPasswordFieldController = TextEditingController();
  String creationProblem = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameFieldController.dispose();
    usernameFieldController.dispose();
    passwordFieldController.dispose();
    reenterPasswordFieldController.dispose();
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
        body: Column(
            children: [
              TextField(
                  controller: nameFieldController,
                  decoration: InputDecoration(
                    hintText: "Your Name",
                    labelText: "Name",
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
              TextField(
                  controller: usernameFieldController,
                  decoration: InputDecoration(
                    hintText: "Your username",
                    labelText: "Username",
                    contentPadding: EdgeInsets.all(10),
                  )
              ),
              TextField(
                  obscureText: true,
                  controller: passwordFieldController,
                  decoration: InputDecoration(
                    hintText: "Create a password",
                    labelText: "Password",
                    helperText: "Password must be at least 8 characters",
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.visibility_off),
                  )
              ),
              TextField(
                  obscureText: true,
                  controller: reenterPasswordFieldController,
                  decoration: InputDecoration(
                    hintText: "Re-Enter your password",
                    labelText: "ReenterPassword",
                    contentPadding: EdgeInsets.all(10),
                    icon: Icon(Icons.visibility_off),
                  )
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
                  onPressed: () {

                    String name = nameFieldController.text;
                    String username = usernameFieldController.text;
                    String password = passwordFieldController.text;
                    String reenteredPassword = reenterPasswordFieldController.text;
                    creationProblem = "";

                    if(!checkPassForCorrectness(password)){
                        creationProblem = "Password does not meet requirements of at least 8 characters.";
                        passwordFieldController.clear();
                        reenterPasswordFieldController.clear();
                    } else if(password != reenteredPassword){
                      creationProblem = "Passwords do not match.";
                      passwordFieldController.clear();
                      reenterPasswordFieldController.clear();
                    } else {
                      bool additionSuccessful = widget.mvm.addUser(name, username, password);
                      if(!additionSuccessful){
                        creationProblem = "Someone has already taken this username. PLease try again.";
                        usernameFieldController.clear();
                        passwordFieldController.clear();
                        reenterPasswordFieldController.clear();
                      } else {
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(widget.db, widget.mvm)
                        ));
                      }
                    }
                  },

                ),
              ),
              Card(
                  child: ListTile(title: Text(creationProblem))
              )
            ]
        )
    );
  }

  Widget _buildPopupDialog(BuildContext context, String alertText) {
    return new AlertDialog(
      title: const Text("Error in creating account:"),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(alertText),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(primary: Colors.lightBlue),
          child: const Text('Close'),
        ),
      ],
    );
  }

  bool checkPassForCorrectness(String p){
    if(p.split("").length >= 8){
      return true;
    }
    return false;
  }


}