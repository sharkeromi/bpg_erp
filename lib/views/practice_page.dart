import 'package:flutter/material.dart';

class Practice extends StatefulWidget {
  const Practice({super.key});

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("Practice page"),
       backgroundColor: Colors.blue,
       centerTitle: true,
       elevation: 0,
       toolbarOpacity:1,
       toolbarHeight: 60,

     ),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: ListView(

          children:[

            Row(children: [

              Icon(
                Icons.facebook,
                color: Colors.blue,
                size: 60,
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.youtube_searched_for_rounded,
                color: Colors.red,
                size: 60,

              ),
              SizedBox(width: 20,),
              Icon(
                Icons.email,
                color: Colors.yellow,
                  size:60
              ),
              SizedBox(width: 20,),
              Icon(
                  Icons.php,
                  color: Colors.blue,
                  size:60
              ),
              SizedBox(width: 20,),
              Icon(
                  Icons.sports_cricket,
                  color: Colors.blueGrey,
                  size:60
              ),
            ],
            ),
            SizedBox(height: 20,),
            Row(children: [
            Icon(
                Icons.icecream,
                size: 60,
              color:Colors.lightGreen,
            ),
              SizedBox(width: 20),
              Icon(
                Icons.add_a_photo,
                size: 60,
                color:Colors.black,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.folder,
                size: 60,
                color:Colors.yellow,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.phone_android,
                size: 60,
                color:Colors.black38,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.messenger,
                size: 60,
                color:Colors.purpleAccent,
              ),
            ],)
          ],
        ),
      )
    );
  }
}

//listview -> children
//column -> children
//row ->children

//container -> empty box = height width (defined)  / height width not defined -> child:Text(sdjfgjsdfh)
//sizedbox -> faka space
//padding -> EdgeInset.all/only
//Icon(Icons.add,)
