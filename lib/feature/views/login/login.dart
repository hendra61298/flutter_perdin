

import 'package:flutter/material.dart';
import 'package:new_project/domain/controller/auth_controller.dart';
import 'package:new_project/feature/views/home/home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: ListView(
      children: [
        ClipPath(
          clipper: BackgroundWaveClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 280,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF7043), Color(0xFFF6EFE9)],
                )),
            child: Center(
              child: Container(
                padding: const EdgeInsets.only( top:50),
                width: 300,
                height: 200,
                child: const Text(
                  'Perjalanan Dinas',
                  style: TextStyle(fontFamily: 'RubikMicrobe',fontSize: 33,fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ),
        const LoginButton()],
      ),
    );
  }
}

class BackgroundWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    final p0 = size.height * 0.75;
    path.lineTo(0.0, p0);

    final controlPoint = Offset(size.width * 0.4, size.height);
    final endPoint = Offset(size.width, size.height / 2);
    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  @override
  bool shouldReclip(BackgroundWaveClipper oldClipper) =>
      oldClipper != this;
}

final ButtonStyle style =
ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),backgroundColor: Colors.deepOrangeAccent);




final AuthController _loginController = AuthController();

class LoginButton extends StatefulWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.isNotEmpty;
  bool isUsernameValid(String username) => username.isNotEmpty;
}

class _LoginButtonState extends State<LoginButton> with InputValidationMixin {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String password = "";

  final _loginFunc = AuthController();
  late TextEditingController userNameController ;
  late  TextEditingController passwordController ;

  onPasswordChange(String value){
    setState(() {
      password = value;
    });
  }

  @override
  void initState() {
    userNameController= TextEditingController();
    passwordController= TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 30),
        Form(
          key:_formKey,
          child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your username',
                ),
                onChanged: (username) {
                  !isUsernameValid(username);
                },
                validator: (username) {
                  if (!isUsernameValid(username!)) {
                    return 'Please enter username';
                  }
                  return null;
                },
                controller: userNameController,),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your password',
                ),
                onChanged: onPasswordChange,
                validator: (value) {
                  if (!isPasswordValid(value!)) {
                    return 'Please enter password';
                  }
                  return null;
                },
                controller:passwordController,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child:SizedBox(
                  height:40, //height of button
                  width:200, //width of button
                  child:  ElevatedButton(
                    style: style,
                    onPressed:() async{
                      if (_formKey.currentState!.validate()){
                        _isLoading= true ;
                        final loginStatus =  await _loginFunc.login(userNameController.text, passwordController.text,context);
                        if(loginStatus) {
                          _isLoading = false;
                          if (!mounted) return;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }else{
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Login Failed'),
                              content: const Text('Incorrect Credential'),
                              actions: <Widget>[

                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    } ,
                    child:  Text(_isLoading? 'Proccessing..' : 'Login'),
                  ),
                ) ,
              ),
            ],         )
        ),
        ),
      ],
    ),);
  }
}



