import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ThumbnailImage extends StatefulWidget {
  final double height;
  final double width;
  final String image;
  final String name;
  final BoxShape imageShape;
  ThumbnailImage(
      {this.height = 80,
      this.width = 80,
      this.image,
      this.name,
      this.imageShape = BoxShape.rectangle});

  @override
  _ThumbnailImageState createState() => _ThumbnailImageState();
}

class _ThumbnailImageState extends State<ThumbnailImage> {
  String imageNotFoundC =
      'https://user-images.githubusercontent.com/24848110/33519396-7e56363c-d79d-11e7-969b-09782f5ccbab.png';

  void initState() {
    return super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    circularImageOrNameViewLocal({String name, double height, double width}) {
      var firstAndLastLetter = getFirstLetterFromName(name);

      return firstAndLastLetter != null
          ? Center(
              child: new Container(
                decoration: new BoxDecoration(
                    shape: widget.imageShape, color: Colors.blueGrey),
                height: height,
                width: width,
                child: Center(
                  child: Text(
                      //count == 1 ? '1' : "+$count",
                      firstAndLastLetter != null ? firstAndLastLetter : "",
                      style: TextStyle(
                          // fontFamily: _appFonts.defaultFont,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2.0,
                          color: Colors.white)),
                ),
              ),
            )
          : Container();
    }

    circularImageOrNameView(
        double height, double width, String image, String name) {
      try {
        name = getDecodedValue(name);
      } catch (e) {
        print(e);
      }
      if (image != null && image.trim() != "") {
        return Center(
            child: new Container(
                decoration: new BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blueGrey),
                height: height,
                width: width,
                child: Stack(
                  children: <Widget>[
                    (image != null && image.trim().length > 0)
                        ? ((image.contains('http') || image.contains('https'))
                            ? Align(
                                child: (image.contains(
                                        '.gif') /*|| image.contains('assets-yammer')*/)
                                    ? circularImageOrNameViewLocal(
                                        name: name,
                                        height: height,
                                        width: width)
                                    : CachedNetworkImage(
                                        height: height,
                                        width: width,
                                        imageUrl: image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: widget.imageShape,
                                            color: Colors.transparent,
                                            //borderRadius: BorderRadius.all(Radius.circular(height / 2)),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) => Center(
                                          child: Container(
                                              height: height / 5,
                                              width: width / 5,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                        Color>(Colors.blue),
                                              )),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                alignment: Alignment.center,
                              )
                            : image.contains('assets')
                                ? /*new CircleAvatar(
                                    radius: height / 2,
                                    backgroundImage: AssetImage(
                                        image),
                                  )*/
                                Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                      shape: widget.imageShape,
                                      color: Colors.transparent,
                                      //borderRadius: BorderRadius.all(Radius.circular(height / 2)),
                                      image: DecorationImage(
                                        image: AssetImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                    ))
                                : /*new CircleAvatar(
                                    radius: height / 2,
                                    backgroundImage: */ /*image.contains('http')?Image.network(image)*/ /* FileImage(
                                        File(image)),
                                  )*/
                                Container(
                                    height: height,
                                    width: width,
                                    decoration: BoxDecoration(
                                      shape: widget.imageShape,
                                      color: Colors.transparent,
                                      //borderRadius: BorderRadius.all(Radius.circular(height / 2)),
                                      image: DecorationImage(
                                        image: FileImage(File(image)),
                                        fit: BoxFit.cover,
                                      ),
                                    )))
                        : new CircleAvatar(
                            radius: height / 2,
                            backgroundImage: NetworkImage(imageNotFoundC),
                          )
                  ],
                )));
      } else {
        return circularImageOrNameViewLocal(
            name: name, height: height, width: width);
      }
    }

    //Main view
    return Container(
        child: circularImageOrNameView(
            widget.height, widget.width, widget.image, widget.name));
  }

  //get first letter from string
  getFirstLetterFromName(String word) {
    var firstAndLastLetter = "NA";
    if (word != null) {
      if (word.trim() != null && word.trim() != "") {
        List wordSplit = [];
        var firstLetter = "";
        var lastLetter = "";
        if (word.contains(" ")) {
          wordSplit = word.split(" ");
          try {
            firstLetter = String.fromCharCode(word.runes.first);
          } catch (e) {
            print(e);
          }
          if (wordSplit.length > 1) {
            try {
              String lastWordString = wordSplit[1];
              lastLetter = String.fromCharCode(lastWordString.runes.first);
            } catch (e) {
              print(e);
            }
          }
        } else {
          try {
            firstLetter = String.fromCharCode(word.runes.first);
            firstLetter = getDecodedValue(firstLetter);
          } catch (e) {
            print(e);
          }
        }
        firstAndLastLetter = firstLetter.toString().toUpperCase() +
            lastLetter.toString().toUpperCase();
      } else {
        return firstAndLastLetter;
      }
    }
    return firstAndLastLetter;
  }

//get decoded format
  getDecodedValue(String value) {
    String decodedValue = value;
    try {
      decodedValue = utf8.decode(value.codeUnits);
    } catch (err) {
      print("$err");
    }
    return decodedValue;
  }
}
