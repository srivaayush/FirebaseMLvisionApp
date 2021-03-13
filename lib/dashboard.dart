// import 'dart:async';
import 'package:flutter/material.dart';
import 'package:img_to_text/dashboardbuttons.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                    appBar: AppBar(
                      leading: Padding(
                          padding: const EdgeInsets.all(10),
                          // child: Image.asset(
                          //   "assets/images/applogo.png",
                          //   colorBlendMode: BlendMode.difference,
                          // )
                          ),
                      title: Text("Scanners using ML KIT"),
                      backgroundColor: Colors.blueGrey,
                      // actions: <Widget>[
                      //   FlatButton.icon(
                      //     icon: Icon(Icons.person),
                      //     label: Text(
                      //       'Log out',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     onPressed: () async {                           
                      //     },
                      //   )
                      // ],
                    ),
                    backgroundColor: Colors.blue[50],
                    body: Center(
                        child: Container(
                            child: GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, top: 25, bottom: 25),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      crossAxisCount: 2,
                      children: <Widget>[
                        DashboardButton("ImageToText", "assets/img2text.png",),
                        DashboardButton("Barcode Scanner", "assets/barcode.png",),
                        DashboardButton("Face Scanner", "assets/facescanner.png",),
                        // DashboardButton("Text Recognition", "assets/img2text.png",),
                        DashboardButton("Label Scanner", "assets/objectdetection.png",),

                        
                      ],
                    ))),
                  );
                } 
}