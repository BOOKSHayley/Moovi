import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/accounts/login.dart';

class Splash extends StatefulWidget{
  const Splash({ Key? key }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState(){
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 2500), () {});
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
        transitionDuration: Duration(milliseconds: 1000),
      )
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
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
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Divider(color: Colors.grey)
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 40, right: 40),
                    child: Container(
                        child: new Image(
                          image: new AssetImage("assets/cowAnimation.gif"),
                        )
                    )
                  ),
                  Padding(
                      padding: EdgeInsets.all(25),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            "Making some popcorn...",
                            style: TextStyle(
                              fontFamily: 'brandon',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )
                        )
                    ),
                  )

                ]

            )
        )
      )
    );
  }
}