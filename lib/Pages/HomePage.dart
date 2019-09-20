import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './Scanner.dart';
import './Settings.dart';
import 'dart:math';
import '../data.dart';
import '../Widgets/intro_page_item.dart';
import '../Widgets/page_transformer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './LogIn.dart';
import './Comment.dart';
class HomePage extends StatefulWidget {

  final FirebaseUser user;
  const HomePage({Key key, this.user}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: FirestoreSlideshow()));
  }
}

class FirestoreSlideshow extends StatefulWidget {
  createState() => FirestoreSlideshowState();
}

class FirestoreSlideshowState extends State<FirestoreSlideshow> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  
  final Firestore db = Firestore.instance;
  Stream slides;
  //Stream favorites;
  //DocumentReference documentSnapshot;
  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;
  List<String> favorites = [];

  @override
  void initState() {
    //_queryFaves();
    //_queryDb();

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("books").snapshots(), //slides,
      initialData: [],
      builder: (context, snap) {
        //List slideList = snap.data.toList();

        return Scaffold(
          backgroundColor: Color(0xFF2d3447),
          drawer: Drawer(
            child: Container(
              color: Color(0xFF2d3447),
              child: ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountEmail: Text("Adaman0000@gmail.com"),
                    accountName: Text("Adam"),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://scontent-lax3-2.xx.fbcdn.net/v/t1.15752-9/s2048x2048/60147063_325310411471923_5882185804700188672_n.jpg?_nc_cat=102&_nc_oc=AQlBdo5feRl0BoRYOQaECnEgFgt5HYwSyMakNY8VR7zhA_6tVeIZlS56mPBspcgwBcY&_nc_ht=scontent-lax3-2.xx&oh=30917c99f8237acd5e6648218637db68&oe=5E09EF1C"),
                    ),
                    otherAccountsPictures: <Widget>[
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Adding new account..."),
                                );
                              });
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.barcode,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Scan",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.users, color: Colors.white),
                    title: Text(
                      "Clubs",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.comments,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Messages",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    trailing: Chip(
                      label: Text("16"),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.cog,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Setting",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Sign Out",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                    onTap: () {
                      FirebaseAuth.instance.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 30,
                  height: 30,
                  child: Image.asset('assets/logo.png'),
                ),
                Text(
                  "Bookster",
                  style: TextStyle(
                      fontFamily: "Poppins-Bold",
                      color: Colors.white,
                      fontSize: 30),
                ),
              ],
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Trending",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.ellipsisH,
                            size: 34.0,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFff6e6e),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 6),
                            child: Text(
                              "Animated",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "25+ Books",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                 SizedBox.fromSize(
                  size: const Size.fromHeight(450),
                  child: PageTransformer(
                    pageViewBuilder: (context, visibilityResolver) {
                      return PageView.builder(
                        controller: PageController(viewportFraction: 0.85),
                        itemCount:
                            snap.data.documents.length, //slideList.length,
                        itemBuilder: (context, index) {
                          final item = snap.data.documents[index];
                          final pageVisibility =
                              visibilityResolver.resolvePageVisibility(index);
                          // DocumentSnapshot documentSnapshot =
                          //     snap.data.documents[index];
                          final DocumentSnapshot documentSnapshot =
                              snap.data.documents[index];
                          
                          return IntroPageItem(
                          
                            documentSnapshot: documentSnapshot,
                            item: item,
                            pageVisibility: pageVisibility,
                            
                          );
                        },
                      );
                    },
                  ),
              
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Favorites",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 46.0,
                            fontFamily: "Calibre-Semibold",
                            letterSpacing: 1.0,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.ellipsisH,
                            size: 34.0,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 6.0),
                            child: Text("Latest",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text("9+ Books",
                          style: TextStyle(color: Colors.blueAccent))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Stream _queryFaves() {
    // Make a Query
    Query query = db.collection('books').where('fav', isEqualTo: true);

    // Map the documents to the data payload
  }

  Stream _queryDb() {
    // Make a Query
    Query query = db.collection('books');

    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    // Update the active tag
  }
}
// StreamBuilder(
//                     stream: Firestore.instance.collection("books").snapshots(),
//                     builder: (BuildContext context,
//                         AsyncSnapshot<QuerySnapshot> snapshot) {
//                       appState = StateWidget.of(context).state;
//                       if (!snapshot.hasData) return CircularProgressIndicator();
//                       return ListView(
//                         children: snapshot.data.documents
//                             .where((d) =>
//                                 appState.favorites == null ||
//                                 appState.favorites.contains(d.documentID))
//                             .map((document) {
//                           return new BookCard(
//                             book: Book.fromMap(
//                                 document.data, document.documentID),
//                             inFavorites: appState.favorites
//                                 .contains(document.documentID),
//                             onFavoriteButtonPressed:
//                                 _handleFavoritesListChanged,
//                           );
//                         }).toList(),
//                       );
//                     }),
