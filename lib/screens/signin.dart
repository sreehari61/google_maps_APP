import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_maps/screens/home.dart';
import '../backend/auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'signup.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: screenSize.height * 0.3,
                width: screenSize.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.deepOrangeAccent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome ",
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Back! ",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: screenSize.height * 0.7,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  LoginForm(),
                  SizedBox(
                    height: 20.0,
                  ),
                  // InkWell(
                  //   child: Text("Forgot Password?"),
                  //   onTap: () {},
                  // ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      InkWell(
                        child: Column(
                          children: [
                            Text(
                              ' Sign Up',
                              style: TextStyle(
                                color: Colors.pink,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            Container(
                              width:65.0,
                              height:2.0,
                              color:Colors.red,
                              margin: EdgeInsets.only(left:5.0),
                            )
                          ],
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool showPassword = false;
  bool loading = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.pinkAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextField(
            controller: _usernameController,
            cursorColor: Colors.pinkAccent,
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Colors.pinkAccent,
              ),
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.pinkAccent),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.pinkAccent, fontSize: 18.0),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.pinkAccent.withOpacity(0.2),
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextField(
            controller: _passwordController,
            obscureText: !showPassword,
            cursorColor: Colors.pinkAccent,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.pinkAccent,
              ),
              suffixIcon: IconButton(
                icon: !showPassword
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
                color: Colors.pinkAccent,
                splashRadius: 20.0,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.pinkAccent),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.pinkAccent, fontSize: 18.0),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: screenSize.width * 0.9,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.deepOrangeAccent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.75),
                  offset: Offset(0.0, 10.0),
                  blurRadius: 20.0,
                  spreadRadius: 0.0)
            ],
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: InkWell(
            child: Padding(
              padding: !loading
                  ? EdgeInsets.symmetric(vertical: 15, horizontal: 40)
                  : EdgeInsets.symmetric(vertical: 10.0, horizontal: 40),
              child: Center(
                  child: !loading
                      ? Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(
                          // height:25.0,
                          // width:25.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.pink),
                          ),
                        )),
            ),
            onTap: () async{
              if(_usernameController.text != "" && _passwordController.text != ""){
                var res = await auth.signIn(_usernameController.text, _passwordController.text);
                if(res['type'] == 'Success'){
                  await FlutterSession().set("token", res['user'][0].id);
                  await FlutterSession().set("user", res['user'][0]);
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (BuildContext context) => Home(userId: res['user'][0].id)),
                      (Route<dynamic> route) => route == Home()
                  );
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
                }else{
                  Alert(context: context, title: res['type'], desc: res['msg'])
                  .show();
                }
              }
              else{
                Alert(context: context, title: "Error", desc: "All fields are required.")
                .show();
              }
            },
          ),
        ),
      ],
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.8);
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.6, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
