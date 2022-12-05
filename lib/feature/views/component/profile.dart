import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/domain/controller/auth_controller.dart';
import 'package:new_project/domain/model/user_model.dart';
import 'package:new_project/feature/views/login/login.dart';
import 'package:new_project/utils/helper/pref_helper.dart';
import 'package:profile/profile.dart';


class ProfilePages extends StatefulWidget {
  const ProfilePages({Key? key}) : super(key: key);

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),backgroundColor: Colors.deepOrangeAccent);

  final _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.deepOrange ,
          title:  Text("Profile"),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          children: [
            Center(
              child: Padding(padding: EdgeInsets.only(top: 120),
                child:  Profile(
                  imageUrl: "https://images.unsplash.com/",
                  name: UserLogin.name ??" ",
                  website: "akhdani.co.id",
                  designation:  UserLogin.roles!.join(""),
                  email: UserLogin.email?? " ",
                  phone_number: "01757736053",
                ),),
            ),
           Padding(padding: EdgeInsets.only(left: 30,right: 30),
           child:  ElevatedButton(
               style: style,
               onPressed: () {
                 _authController.logout();
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
               },

               child: const Text("Logout")),)
          ],
        )
    );

  }
}
