import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ojt/my_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
class DescriptionScreen extends StatefulWidget {

  int id;


  DescriptionScreen({required this.id});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState(id: id);
}

class _DescriptionScreenState extends State<DescriptionScreen> {

  int id;


  _DescriptionScreenState({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiServices.apifetchdesc(id),
        builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }

        if (snapshot.hasData) {

          Map map = jsonDecode(snapshot.data);

          List moviePictures = map['tvShow']['pictures'];

          String movieImage = map['tvShow']['image_thumbnail_path'];
          String movieName = map['tvShow']['name'];
          String movieDesc = map['tvShow']['description'];
          return Column(
            children: [

              // Image Carousel Container

              SizedBox(height: 20,),

              CarouselSlider.builder(
                  itemCount: moviePictures.length,
                  itemBuilder: (context, index, realIndex) {
                return Container(
                  width: double.infinity,
                  height: 150,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(moviePictures[index]))
                  ),
                );
              }, options: CarouselOptions(
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(milliseconds: 2500)
              )),

              SizedBox(height: 20,),

              Container(
                width: double.infinity,
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(movieImage))
                ),
              ),
              SizedBox(height: 20,),
              // Movie Details
              SizedBox(height: 4,),
              Text(movieName),
              SizedBox(height: 4,),
              Text(movieDesc),

            ],
          );
        }

        if (snapshot.hasError) {
          return Center(child: Icon(Icons.error,size: 24,color: Colors.red,));
        }

        return Container();
      },),
    );
  }
}
