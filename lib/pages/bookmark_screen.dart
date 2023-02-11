import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Explanation_screen.dart';

class bookmark_screen extends StatefulWidget {
  const bookmark_screen({Key? key}) : super(key: key);

  @override
  State<bookmark_screen> createState() => _bookmark_screenState();
}

class _bookmark_screenState extends State<bookmark_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('saved'),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),),
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {},
            ),
          ],
          elevation: 6,
          backgroundColor: Color.fromARGB(255, 184, 0, 0),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Text('Saved',style: TextStyle(color: Colors.white, fontSize: 30,fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(0.1),
                      child: InkWell(
                        onTap: (){
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           ExplanationScreen(),
                          //     ));
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(width: 3, color: Colors.white,)),
                          color: Color.fromARGB(255, 184, 0, 0),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    image: AssetImage('assets/1.jpg'),
                                    width: 130,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        CircleAvatar(backgroundImage: AssetImage('assets/bbc1.png'),),
                                        SizedBox(width: 6,),
                                        Text('News Name\t',style: TextStyle(color: Colors.white, fontSize: 13, ),),
                                        Text('Time\t',style: TextStyle(color: Colors.white, fontSize: 6),),
                                        SizedBox(width: 7,),
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.bookmark, color: Colors.white,),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1,),
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Container(
                                        width: 150,
                                        child: Column(
                                          children: [
                                            Text('Leatest News Heading ',style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, ),),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
