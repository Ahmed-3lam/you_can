import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget postItemBuilder () => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Column(

    children: [

      Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Expanded(child:Row(

            children: [CircleAvatar(

                backgroundImage: AssetImage("assets/images/Ahmed.png")

            ),

              SizedBox(width: 5,),

              Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text("Ahmed Allam",style: TextStyle(fontWeight: FontWeight.bold),),

                  SizedBox(height: 2,),

                  Text(" Elmonofia,Egypt",style: TextStyle(color: Colors.grey,fontSize: 10),)

                ],

              ),],

          ), ),

          Icon(Icons.scatter_plot),



        ],

      ),

      SizedBox(height: 10,),

      Text("A better way of doing that is clipping the wavy parts of the"

          " image ourselves. This solution will look better on different "

          "screen sizes. We also don’t need to include an extra wave overlay"

          " image in our assets. Thanks to a nice set of graphics related APIs"

          " in Flutter, we can do this very easily.",

          maxLines: 5,

          overflow: TextOverflow.ellipsis),

      SizedBox(height: 10,),

      Container(

          width: double.infinity,

          height: 200,

          decoration: BoxDecoration(

              image: new DecorationImage(

                  image: new AssetImage('assets/images/cover.jpeg'),

                  fit: BoxFit.cover

              ),

              borderRadius: BorderRadius.all(Radius.circular(20),

              ))),
      SizedBox(height: 10,),
      Row(
        children: [
          Expanded(child:
          Row(
            children: [Icon(Icons.favorite,color: Colors.red,),
              Text("10K",style: TextStyle(color: Colors.grey),),
              SizedBox(width: 5,),

              Icon(Icons.message,color: Colors.grey,),
              Text("4K",style: TextStyle(color: Colors.grey),),
              SizedBox(width: 5,),

              Icon(Icons.archive_outlined,color: Colors.grey,),
              Text("7K",style: TextStyle(color: Colors.grey),),
              SizedBox(width: 5,),],
          )),
          Icon(Icons.panorama_vertical_outlined,color: Colors.grey,),

        ],
      )

    ],

  ),
);