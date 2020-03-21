//import 'package:flutter/material.dart';
//import '../FORM_INPUTS/postMap.dart';
//import '../providers/post.dart';
//import 'package:provider/provider.dart';
//class LocationHelp extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//     final product = Provider.of<Post>(context, listen: false);
//    return InkWell(
//        onTap: () {
//
//        },
//        child: Stack(children: [
//          Center(
//              child: Container(
//                  margin: EdgeInsets.symmetric(
//                    horizontal: 10.0,
//                    vertical: 20.0,
//                  ),
//                  height: 125.0,
//                  width: 275.0,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10.0),
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.black54,
//                          offset: Offset(0.0, 4.0),
//                          blurRadius: 10.0,
//                        ),
//                      ]),
//                  child: Container(
//
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10.0),
//                          color: Colors.white),
//                      child: Row(children: [
//                        Container(
//                            height: 90.0,
//                            width: 90.0,
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(10.0),
//                                    topLeft: Radius.circular(10.0)),
//                                image: DecorationImage(
////
//                                   image: NetworkImage(product.image),
//                                    fit: BoxFit.cover))),
//                        SizedBox(width: 5.0),
//                        Column(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: [
//                              Text(
//                             product.name,
//                                style: TextStyle(
//                                    fontSize: 12.5,
//                                    fontWeight: FontWeight.bold),
//                              ),
//                              Text(
//                               product.dayLost,
//                                style: TextStyle(
//                                    fontSize: 12.0,
//                                    fontWeight: FontWeight.w600),
//                              ),
//                              Container(
//                                width: 170.0,
//                                child: Text(
//                                 product.description,
//                                  style: TextStyle(
//                                      fontSize: 11.0,
//                                      fontWeight: FontWeight.w300),
//                                ),
//                              )
//                            ])
//                      ]))))
//        ]));
//  }
//}
