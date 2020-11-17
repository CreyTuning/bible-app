import 'package:flutter/material.dart';

class Category extends StatefulWidget {
  Category({
    Key key,
    this.imageUrl,
    this.title,
    this.description
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String description;

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(

       ),
    );
  }
}