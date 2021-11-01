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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameFieldController.dispose();
    usernameFieldController.dispose();
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

                    widget.mvm.addUser(name, username);

                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) => LoginPage(widget.db, widget.mvm)
                    ));
                  },

                ),
              ),
            ]
        )
    );
  }

}