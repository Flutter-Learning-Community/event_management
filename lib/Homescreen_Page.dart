import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_management/list.dart';
import 'package:flutter/material.dart';
import 'list.dart';

class Home_Screen extends StatelessWidget {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1545696563-af8f6ec2295a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=685&q=80',
    'https://images.unsplash.com/photo-1600566209579-dd9691ed2ff0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJpcnRoZGF5JTIwY2FrZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1610670444950-0b29430891b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGJpcnRoZGF5JTIwY2FrZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
              ),
              //const DrawerHeader(
              //decoration: BoxDecoration(
              //color: Colors.black,
              //),
              //child: Text('Drawer Header',),
              //),

              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  //Navigator.push(context,
                  //MaterialPageRoute(builder: (context) => MyHomePage()));
                },
                trailing: new Icon(Icons.person),
                iconColor: Colors.black,
              ),

              //Icon(Icons.person),
              ListTile(
                title: const Text('Booking History'),
                trailing: new Icon(Icons.history),
                iconColor: Colors.black,
                onTap: () {
                  // Navigator.push(
                  //  context, MaterialPageRoute(builder: (context) => list()));
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Homepage"),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.library_add_outlined),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 220),
          child: CarouselSlider(
            options: CarouselOptions(
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true),
            items: imgList
                .map((item) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            item,
                            width: 200,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
