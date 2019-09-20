import 'package:bookster/Widgets/intro_page_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data.dart';
import '../Pages/intro_page_view.dart';
import '../Widgets/page_transformer.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import './Comment.dart';

class MoreInfoPage extends StatefulWidget {
  @override
  final item;
  var image;

  final DocumentSnapshot documentSnapshot;
  MoreInfoPage({
    Key key,
    @required this.item,
    this.image,
    this.documentSnapshot,
  }) : super(key: key);
  _MoreInfoPageState createState() => _MoreInfoPageState();
}

class _MoreInfoPageState extends State<MoreInfoPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    userQuery = Firestore.instance
        .collection('books')
        .where('id', isEqualTo: widget.documentSnapshot.documentID)
        .limit(1);
    controller.forward();
    iconIndicator = widget.documentSnapshot.data['fav'];
  }

  List<String> information;
  bool iconIndicator;
  var userQuery;
  var heartIcon;
  bool isLiked;
  Xml2Json xml2json = new Xml2Json();
  Future<List<String>> getData() async {
    var response = await http.get(
      "https://www.goodreads.com/book/title.xml?author=" +
          widget.item["auth"] +
          "&key=kEzd9PWgPNmZ8hup0dLX2A&title=" +
          widget.item["title"],
      headers: {"key": "kEzd9PWgPNmZ8hup0dLX2A"},
    );
    xml2json.parse(response.body);
    var jsondata = xml2json.toGData();
    Map data = new Map<String, dynamic>.from(json.decode(jsondata));
    information = [
      data["GoodreadsResponse"]["book"]["description"].toString().substring(
          9,
          data["GoodreadsResponse"]["book"]["description"].toString().length -
              1),
      data["GoodreadsResponse"]["book"]["average_rating"].toString().substring(
          5,
          data["GoodreadsResponse"]["book"]["average_rating"]
                  .toString()
                  .length -
              1)
    ];
    for (int i = 0; i < information[0].toString().length; i++) {
      if (information[0].toString()[i].contains("<") ||
          information[0].toString()[i].contains(">")) {
        information[0] = information[0]
                .toString()
                .substring(0, information[0].toString().indexOf("<")) +
            information[0].toString().substring(
                information[0].toString().indexOf(">") + 1,
                information[0].toString().length);
      }
    }
    for (int i = 0; i < information[0].toString().length; i++) {
      if (information[0].toString()[i].contains("\\")) {
        information[0] = information[0]
                .toString()
                .substring(0, information[0].toString().indexOf("\\")) +
            information[0].toString().substring(
                information[0].toString().indexOf("\\") + 1,
                information[0].toString().length);
      }
    }
    return information;
  }

  final controllerPage = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    AppBar(
                      backgroundColor: Color(0xff2d3447),
                      leading: IconButton(
                        icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      elevation: 0,
                    ),
                    Hero(
                      tag: widget.image,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: SizedBox(
                              height: 450, //MediaQuery.of(context).size.height,
                              width: 300, //MediaQuery.of(context).size.width,
                              child: widget.image //Image.network(widget.image),
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 590),
                      child: FutureBuilder<List<String>>(
                        future: getData(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.data == null) {
                            return SpinKitWave(color: Colors.white);
                          } else {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                color: Colors.white,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Average Rating: ",
                                                style: TextStyle(
                                                    fontFamily: 'roboto-bold'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 55),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(25)),
                                                child: Container(
                                                  width: 60,
                                                  height: 25,
                                                  color: Colors.lightBlue,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    snapshot.data[1].toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'robot-black',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 18,
                                              ),
                                              child: IconButton(
                                                icon: iconIndicator
                                                    ? Icon(FontAwesomeIcons
                                                        .solidHeart)
                                                    : Icon(
                                                        FontAwesomeIcons.heart),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  if (iconIndicator == true) {
                                                    Firestore.instance
                                                        .collection("books")
                                                        .document(widget
                                                            .documentSnapshot
                                                            .documentID)
                                                        .updateData(
                                                            {"fav": false});
                                                  } else if (iconIndicator ==
                                                      false) {
                                                    Firestore.instance
                                                        .collection("books")
                                                        .document(widget
                                                            .documentSnapshot
                                                            .documentID)
                                                        .updateData(
                                                            {"fav": true});
                                                  }
                                                  setState(() {
                                                    iconIndicator =
                                                        !iconIndicator;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Description: ",
                                            style: TextStyle(
                                                fontFamily: 'roboto-bold',
                                                height: 1.3),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            snapshot.data[0].toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'roboto-black',
                                                height: 1.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Comment(),
        ],
      ),
      backgroundColor: Color(0xFF2d3447),
    );
  }

  //Also hero needs gesturedetector
}
