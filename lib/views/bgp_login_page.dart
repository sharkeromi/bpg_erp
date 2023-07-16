
import 'package:flutter/material.dart';

import '../utils/color_util.dart';
import 'bpg_home_page.dart';

class BgpLoginPage extends StatefulWidget {
  @override
  _BgpLoginPageState createState() => _BgpLoginPageState();
}

class _BgpLoginPageState extends State<BgpLoginPage> {
  TextEditingController loginTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController urlTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    initTextEditor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Container(
        color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/images/bgplogo.png",
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              "USER LOGIN",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
//                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color(ColorUtil.instance.hexColor("#dde1e4")),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(5, 5)),
                      BoxShadow(
//                      color: Color(ColorUtil.instance.hexColor("#f7f8fc")),
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(-1, -1))
                    ]),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: TextFormField(
                      controller: urlTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),

//                        enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor:
                              Color(ColorUtil.instance.hexColor("#e7f0f9")),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Hint here",
                          hintStyle: TextStyle(
                              color: Color(
                                  ColorUtil.instance.hexColor("#bbc2cc")))),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
//                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color(ColorUtil.instance.hexColor("#dde1e4")),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(5, 5)),
                      BoxShadow(
//                      color: Color(ColorUtil.instance.hexColor("#f7f8fc")),
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(-1, -1))
                    ]),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: TextFormField(

                      controller: loginTextController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),

//                        enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor:
                              Color(ColorUtil.instance.hexColor("#e7f0f9")),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Hint here",
                          hintStyle: TextStyle(
                              color: Color(
                                  ColorUtil.instance.hexColor("#bbc2cc")))),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
//                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: Color(ColorUtil.instance.hexColor("#dde1e4")),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(5, 5)),
                      BoxShadow(
//                      color: Color(ColorUtil.instance.hexColor("#f7f8fc")),
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: Offset(-1, -1))
                    ]),
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: TextFormField(
                      controller: passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(color: Colors.white),
                          ),

//                        enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          filled: true,
                          fillColor:
                              Color(ColorUtil.instance.hexColor("#e7f0f9")),
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Hint here",
                          hintStyle: TextStyle(
                              color: Color(
                                  ColorUtil.instance.hexColor("#bbc2cc")))),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BpgHomePage()),
                );
              },
              child: Container(
                color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
                child: Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.purple,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(4, 4)),
                          BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(-4, -4))
                        ]),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void initTextEditor() {
    loginTextController.text = "bpg";
    passwordTextController.text = "oeigmv";
  }
}
