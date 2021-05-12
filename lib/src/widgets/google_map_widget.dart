import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GoogleMapWidget extends StatefulWidget {
  final double height;
  final double width;
  final String image;
  final String name;
  GoogleMapWidget({this.height = 80, this.width = 80, this.image, this.name});

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Widget mapView;

  void initState() {
    return super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Main view
    return Container();
  }
}
