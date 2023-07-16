import 'package:bpg_erp/views/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../utils/color_util.dart';

class BpgHomePage extends StatefulWidget {
  @override
  _BpgHomePageState createState() => _BpgHomePageState();
}

class _BpgHomePageState extends State<BpgHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: Container(
        color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
        child: ListView(
          children: <Widget>[
            Image.asset("assets/images/sky.png"),
            SizedBox(
              height: 20,
            ),
            Image.asset("assets/images/leaves.png"),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => WelcomeScreen()),
                   );
                  },
                  child: Container(
                    color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color:
                                Color(ColorUtil.instance.hexColor("#e7f0f9")),
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
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Image.asset("assets/images/search.png",height: 50,width: 50,),
                              SizedBox(height: 10,),
                              Text("Visiting Card Scan"),
                            ],
                          )
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => BpgHomePage()),
//                    );
                  },
                  child: Container(
                    color: Color(ColorUtil.instance.hexColor("#e7f0f9")),
                    child: Center(
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color:
                            Color(ColorUtil.instance.hexColor("#e7f0f9")),
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
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 30,),
                                Image.asset("assets/images/item1.png",height: 50,width: 50,),
                                SizedBox(height: 10,),
                                Text("Item1"),
                              ],
                            )
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
