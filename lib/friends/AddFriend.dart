import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moovi/database/userEntity.dart';
import 'package:moovi/friends/pendingFriendsList.dart';
import 'package:moovi/friends/FriendsListMenu.dart';
import '../main.dart';

class AddFriend extends StatefulWidget{
  AddFriend({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();

}

class _MyCustomFormState extends State<AddFriend>{

  final usernameFieldController = TextEditingController();
  final errorFieldController = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameFieldController.dispose();
    errorFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        title: Text('Add a Friend', style: TextStyle(fontSize: 24),),
        content: TextField(
          onChanged: (value) { },
          maxLength: 10,
          controller: usernameFieldController,
          style: TextStyle(fontSize: 18),
          cursorColor: Colors.yellowAccent,
          cursorWidth: 3,
          decoration: InputDecoration(
            hintText: "Enter your friend's username",
            hintStyle: TextStyle(fontSize: 18),
            counterText: "",
          ),
        ),
        actions: <Widget>[
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w300),),
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(builder: (context) => PendingFriendsList())
                      );
                    },
                  ),
                  TextButton(
                    child: const Text('Add', style: TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.w300),),
                    onPressed: () async {
                      String friendUsername = usernameFieldController.text;
                      bool successful = await MyApp.mvm.addFriendToUser(MyApp.user, friendUsername, true);
                      if(successful) {
                        // Navigator.of(context).pop();
                        Navigator.of(context)
                            .push(
                            MaterialPageRoute(builder: (context) => PendingFriendsList())
                        );
                      } else{
                        usernameFieldController.clear();
                        UserEntity? exists = await MyApp.mvm.getUserbyUsername(friendUsername);
                        if(exists != null){
                          errorFieldController.text = "Already Added.";
                          setState(() { _hasError = true; });
                        } else{
                          errorFieldController.text = "Invalid Username.";
                          setState(() { _hasError = true; });
                        }
                      }
                    },
                  ),
                ],
              ),
              Visibility(
                visible: _hasError,
                child: TextField(
                  controller: errorFieldController,
                  readOnly: true,
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      )
    );
    
  }


}
