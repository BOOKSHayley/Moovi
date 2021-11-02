import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'accountCreation.dart';

class LoginPage extends StatefulWidget{

  static late String username; //will hold the username of the currently logged in user

  final db;
  final mvm;
  const LoginPage(this.db, this.mvm, {Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

class _MyCustomFormState extends State<LoginPage>{

  final usernameFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign In"),
        ),
        body: Column(
            children: [
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
                          //todo: backend code here
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
                        onPressed: (){
                          LoginPage.username = usernameFieldController.text;

                          Navigator.push(context, new MaterialPageRoute(
                              builder: (context) => MyApp(widget.db)
                          ));
                        },

                      ),
                    ),
                  ]
              )

            ]
        )
    );
  }

}