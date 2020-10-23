import 'package:flutter/material.dart';

import 'signin.dart';
import 'signup.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            width: screenSize.width,
            height: screenSize.height * 0.6,
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal:10.0),
              child: Image.asset('assets/images/Map_PNG.png'),
            )
          ),
          Container(
            width: screenSize.width,
            height: screenSize.height * 0.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      width: screenSize.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.pinkAccent,
                            Colors.deepOrangeAccent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(color:Colors.grey,offset: Offset(1.0, 1.0),blurRadius:3.0,spreadRadius: 1.0)
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize:18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                    },
                  ),
                  SizedBox(
                    height:30.0,
                  ),
                  InkWell(
                    child: Container(
                      width: screenSize.width,
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.pinkAccent,
                            Colors.deepOrangeAccent,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(color:Colors.grey,offset: Offset(1.0, 1.0),blurRadius:3.0,spreadRadius: 1.0)
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color:Colors.white,
                            fontSize:18.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                    },
                  ),
                ]
              ),
            ),
          )
        ],
      )
    );
  }
}