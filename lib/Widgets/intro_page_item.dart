import 'package:bookster/Pages/MoreInfoPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../data.dart';
import './page_transformer.dart';

class IntroPageItem extends StatelessWidget {
  IntroPageItem(
      {@required this.item,
      @required this.pageVisibility,
      this.documentSnapshot});

  final item;
  final PageVisibility pageVisibility;
  final DocumentSnapshot documentSnapshot;
  @override
  Widget build(BuildContext context) {
    var image = Image.network(
      item['img'],
      fit: BoxFit.fill,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 8.0,
      ),
      child: Hero(
        tag: image,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoreInfoPage(
                  documentSnapshot: documentSnapshot,
                  item: item,
                  image: image,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                image,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
