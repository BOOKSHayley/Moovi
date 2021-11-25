import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/userEntity.dart';
import '../main.dart';
import 'accountCreation.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

class _MyCustomFormState extends State<LoginPage>{

  final usernameFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final errorFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _hasError = false;

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
    final _bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign In", style: TextStyle(
              fontSize: 24,
              fontFamily: 'brandon'
          ),
          ),
        ),

        body: SingleChildScrollView(
          reverse: true,
          child: Padding(
            padding: EdgeInsets.only(left:20, right: 20, bottom: _bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                  )
                ),
                Align(
                  alignment: Alignment.center,
                    child: Text(
                        "MOOVI",
                        style: TextStyle(
                          fontFamily: 'brandon',
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                    )
                    ),
                Padding(
                  padding: EdgeInsets.all(10),
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
                        controller: usernameFieldController,
                        style: TextStyle(fontSize: 20, fontFamily: 'brandon'),
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: "Your username",
                          labelText: "Username",
                          labelStyle: TextStyle(fontSize: 20, fontFamily: 'brandon'),
                          errorStyle: TextStyle(fontSize: 16, fontFamily: 'brandon'),
                          counterText: "",
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
                        style: TextStyle(fontSize: 20, fontFamily: 'brandon'),
                        textInputAction: TextInputAction.done,
                        cursorColor: Colors.yellowAccent,
                        cursorWidth: 3,
                        maxLength: 20,
                        decoration: InputDecoration(
                          hintText: "Your password",
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 20, fontFamily: 'brandon'),
                          errorStyle: TextStyle(fontSize: 16, fontFamily: 'brandon'),
                          counterText: "",
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
                      Visibility(
                        child: TextField(
                          controller: errorFieldController,
                          readOnly: true,
                          style: TextStyle(color: Colors.red, fontSize: 20, fontFamily: 'brandon'),
                        ),
                        visible: _hasError,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(7),
                            child: InkWell(
                              child: Text("Forgot Password?", style: TextStyle(color:Colors.grey[600], fontSize: 16, fontFamily: 'brandon'),),
                            ),
                          ),

                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget> [
                              SizedBox(
                                width: MediaQuery.of(context).size.width -50,
                                height: 60,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(const Color(0xfffde259)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: const Color(0xff3f3f45),
                                              width: 3,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(40),
                                        )
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Sign in",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontSize: 25,
                                          fontFamily: 'brandon',
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  onPressed: () async{
                                    errorFieldController.clear();

                                    if(_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      UserEntity? user = await MyApp.mvm.
                                      getUserbyUsernameAndPass(username, password);

                                      if (user == null) {
                                        usernameFieldController.clear();
                                        passwordFieldController.clear();
                                        setState(() { _hasError = true; });
                                        errorFieldController.text = "Your username or password was incorrect.";
                                      } else {
                                        MyApp.user = user;
                                        Navigator.push(context, new MaterialPageRoute(
                                            builder: (context) => MyApp()
                                        ));
                                      }
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5),
                              ),
                            ]
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: InkWell(
                          child: Text("No account? Sign up!", style: TextStyle(color: const Color(
                              0xffffffff), fontSize: 18, fontFamily: 'brandon'),),
                          onTap: (){
                            Navigator.push(context, new MaterialPageRoute(
                                builder: (context) => AccountCreationPage()
                            )
                            );
                          },
                        ),
                      )
                   ]
                  ),
                ),
              ]
            )
          ),
        )
      );
  }

}