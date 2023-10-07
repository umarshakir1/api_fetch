import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ojt/description_screen.dart';
import 'package:ojt/my_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: FutureBuilder(
        future: ApiServices.apifetch(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(),);
          }

          if (snapshot.hasData) {

            Map map = jsonDecode(snapshot.data);
            List mydata = map['tv_shows'];

            return ListView.builder(
              itemCount: mydata.length,
              itemBuilder: (context, index) {

                int movieID = mydata[index]['id'];
              String movieName = mydata[index]['name'];
              String movieImage = mydata[index]['image_thumbnail_path'];
              String movieNetwork = mydata[index]['network'];
              String movieStatus = mydata[index]['status'];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionScreen(id: movieID),));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Movie Id: $movieID")));
                },
                child: Container(
                  width: double.infinity,
                  height: 90.0,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      // Image Container
                      SizedBox(width: 10,),

                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage(movieImage),
                      ),

                      SizedBox(width: 30,),
                      // Movie Details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(movieName),
                          Text(movieNetwork),
                          Text(movieStatus),
                        ],
                      )

                    ],
                  ),
                ),
              );
            },);
          }

          if (snapshot.hasError) {
            return Center(child: Icon(Icons.error,size: 24,color: Colors.red,));
          }

        return Container();
      },)
    );
  }
}


