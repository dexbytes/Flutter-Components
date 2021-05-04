import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';

class SearchView extends StatefulWidget {
  /// The function to call when the "Cancel" button is pressed
  final Function onCancel;

  /// The function to call when the "Clear" button is pressed
  final Function onClear;

  /// The function to call when the text is updated
  final Function(String) onUpdate;

  /// The function to call when the text field is submitted
  final Function(String) onSubmit;
  final bool isAndroid;

  SearchView({
    Key key,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
    this.isAndroid = false,
  }) : super(key: key);
  @override
  _SearchViewState createState() => _SearchViewState(isAndroidTemp: isAndroid);
}

class _SearchViewState extends State<SearchView>
    with SingleTickerProviderStateMixin {
  TextEditingController _searchTextController = new TextEditingController();
  FocusNode _searchFocusNode = new FocusNode();
  Animation _animation;
  AnimationController _animationController;
  bool isAndroid = false;
  _SearchViewState({bool isAndroidTemp = false}) {
    //Check device platform
    if (Platform.isIOS) {
      isAndroid = false;
    } else if (Platform.isAndroid) {
      isAndroid = true;
    }
    /*if (isAndroidTemp != null) {
      isAndroid = isAndroidTemp;
    }*/
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = new AnimationController(
      duration: new Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _searchFocusNode.addListener(() {
      if (!_animationController.isAnimating) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    void _cancelSearch() {
      _searchTextController.clear();
      _searchFocusNode.unfocus();
      _animationController.reverse();
      if (widget.onCancel != null) {
        widget.onCancel();
      }
    }

    void _clearSearch() {
      _searchTextController.clear();
      if (widget.onClear != null) {
        widget.onClear();
      }
    }

    Widget _searchIos() {
      return IOSSearchBar(
        controller: this._searchTextController,
        focusNode: this._searchFocusNode,
        animation: this._animation,
        onCancel: _cancelSearch,
        onClear: _clearSearch,
        onSubmit: widget.onSubmit,
        onUpdate: widget.onUpdate,
      );
    }

    Widget _searchAndroid() {
      return AndroidSearchBar(
        controller: this._searchTextController,
        focusNode: this._searchFocusNode,
        animation: this._animation,
        onCancel: _cancelSearch,
        onClear: _clearSearch,
        onSubmit: widget.onSubmit,
        onUpdate: widget.onUpdate,
      );
    }

    return Container(
      child: isAndroid ? _searchAndroid() : _searchIos(),
    );
  }
}

/// Creates the Cupertino-style search bar. See the README for an example on how to use.
class IOSSearchBar extends AnimatedWidget {
  IOSSearchBar({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  /// The text editing controller to control the search field
  final TextEditingController controller;

  /// The focus node needed to manually unfocus on clear/cancel
  final FocusNode focusNode;

  /// The function to call when the "Cancel" button is pressed
  final Function onCancel;

  /// The function to call when the "Clear" button is pressed
  final Function onClear;

  /// The function to call when the text is updated
  final Function(String) onUpdate;

  /// The function to call when the text field is submitted
  final Function(String) onSubmit;
  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _kFontSize = 13.0;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Material(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      child: Row(children: <Widget>[
        Expanded(
            child: new Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0.0),
                decoration: new BoxDecoration(
                  color: /*CupertinoColors.white*/ Color(0Xffededed),
                  border: new Border.all(
                      width: 0.0,
                      color: /*CupertinoColors.white*/ Color(0Xffededed)),
                  borderRadius: new BorderRadius.circular(8.0),
                ),
                child:
                    Stack(alignment: Alignment.centerLeft, children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
                            child: Icon(
                              CupertinoIcons.search,
                              color: Colors.black54,
                              size: _kFontSize + 13.0,
                            ))
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(10.0),
                                  hintText: 'Search',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.transparent))),
                              controller: controller,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                              autocorrect: false,
                              focusNode: focusNode,
                              onChanged: onUpdate,
                              onSubmitted: onSubmit,
                              cursorColor: CupertinoColors.black,
                            ),
                          ),
                        ),
                        CupertinoButton(
                            minSize: 10.0,
                            padding: const EdgeInsets.all(1.0),
                            borderRadius: BorderRadius.circular(30.0),
                            color: CupertinoColors.inactiveGray.withOpacity(
                              1.0 - _opacityTween.evaluate(animation),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 15.0,
                              color: CupertinoColors.white,
                            ),
                            onPressed: () {
                              if (animation.isDismissed)
                                return;
                              else
                                onClear();
                            })
                      ])
                ]))),
        SizedBox(
            width: _paddingTween.evaluate(animation),
            child: CupertinoButton(
                padding: const EdgeInsets.only(left: 8.0),
                onPressed: onCancel,
                child: Text('Cancel',
                    softWrap: false,
                    style: TextStyle(
                      inherit: false,
                      color: CupertinoColors.black,
                      fontSize: _kFontSize,
                    ))))
      ]),
    ));
  }
}

/// Creates the Cupertino-style search bar. See the README for an example on how to use.
class AndroidSearchBar extends AnimatedWidget {
  AndroidSearchBar({
    Key key,
    @required Animation<double> animation,
    @required this.controller,
    @required this.focusNode,
    this.onCancel,
    this.onClear,
    this.onSubmit,
    this.onUpdate,
  })  : assert(controller != null),
        assert(focusNode != null),
        super(key: key, listenable: animation);

  /// The text editing controller to control the search field
  final TextEditingController controller;

  /// The focus node needed to manually unfocus on clear/cancel
  final FocusNode focusNode;

  /// The function to call when the "Cancel" button is pressed
  final Function onCancel;

  /// The function to call when the "Clear" button is pressed
  final Function onClear;

  /// The function to call when the text is updated
  final Function(String) onUpdate;

  /// The function to call when the text field is submitted
  final Function(String) onSubmit;
  static final _opacityTween = new Tween(begin: 1.0, end: 0.0);
  static final _paddingTween = new Tween(begin: 0.0, end: 60.0);
  static final _kFontSize = 14.0;
  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Material(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
      child: Row(children: <Widget>[
        Expanded(
            child: Card(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
              child: Stack(alignment: Alignment.centerLeft, children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 1.0),
                          child: Icon(
                            CupertinoIcons.search,
                            color: CupertinoColors.darkBackgroundGray,
                            size: _kFontSize + 6.0,
                          ))
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: TextField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10.0),
                                hintText: 'Search',
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                            controller: controller,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            autocorrect: false,
                            focusNode: focusNode,
                            onChanged: onUpdate,
                            onSubmitted: onSubmit,
                            cursorColor: CupertinoColors.black,
                          ),
                        ),
                      ),
                      CupertinoButton(
                          minSize: 20.0,
                          padding: EdgeInsets.all(0.0),
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors
                              .transparent /*CupertinoColors.inactiveGray.withOpacity(
                            1.0 - _opacityTween.evaluate(animation),
                          )*/
                          ,
                          child: Icon(
                            Icons.close,
                            size: 20.0,
                            color: CupertinoColors.black,
                          ),
                          onPressed: () {
                            if (animation.isDismissed)
                              return;
                            else
                              onClear();
                          })
                    ])
              ])),
        )) /*,
        SizedBox(
            width: _paddingTween.evaluate(animation),
            child: CupertinoButton(
                padding: const EdgeInsets.only(left: 8.0),
                onPressed: onCancel,
                child: Text('Cancel',
                    softWrap: false,
                    style: TextStyle(
                      inherit: false,
                      color: CupertinoColors.black,
                      fontSize: _kFontSize,
                    ))))*/
      ]),
    ));
  }
}

/*class ListFilter {
  static List mainList = [];
  List searchedList = [];

  */ /*filterData() {
    List<dynamic> dummyListData = List<dynamic>();
    if (listDataTemp == null) {
      listDataTemp = new List();
      listDataTemp.addAll(widget.listData);
    }
    listDataTemp.forEach((item) {
      if (searchByKeys != null) {
        try {
          String jsonString1 = json.encode(item);
          Map jsonString = json.decode(jsonString1);
          List searchValues = List();
          */ /* */ /*String fullName = "full_name";
                String name = jsonString['$fullName'];
                String name1 = jsonString['$fullName'];*/ /* */ /*
          if (innerData != null && innerData) {
            */ /* */ /*  String jsonString2 = json.encode(jsonString1);
            Map jsonString3 = json.decode(jsonString2);
            for(int i=0;i<searchByKeys.length;i++){
              searchValues.add( jsonString3['${searchByKeys[i]}']);
            }*/ /* */ /*
            String jsonString = json.encode(item);
            if (jsonString
                .toLowerCase()
                .contains(widget.searchKeyWord.toLowerCase())) {
              dummyListData.add(item);
            }
          } else {
            for (int i = 0; i < searchByKeys.length; i++) {
              String searchKey = searchByKeys[i];
              List searchKeyList = searchKey.split("#");
              if(searchKeyList != null && searchKeyList.length > 2){

                if(jsonString.containsKey(searchKeyList[0])){
                  var innerData =  jsonString[searchKeyList[0]];
                  // searchValues.add(innerData['${searchKeyList[1]}']);
                  if(innerData != null && innerData[searchKeyList[1]]){
                    var innerData1 =  innerData[searchKeyList[1]];
                    if (innerData1 != null && innerData1['${searchKeyList[2]}']) {
                      searchValues.add(innerData1['${searchKeyList[2]}']);
                    }
                  }
                }
              }
              else if(searchKeyList != null && searchKeyList.length > 1){

                if(jsonString.containsKey(searchKeyList[0])){
                  var innerData =  jsonString[searchKeyList[0]];
                  searchValues.add(innerData['${searchKeyList[1]}']);
                }
              }
              else{
                searchValues.add(jsonString['$searchKey']);
              }

              // print(jsonString['${searchByKeys[i]}']);
            }
          }

          searchValues.map((e) {
            if (e
                .toString()
                .toLowerCase()
                .startsWith("${widget.searchKeyWord.toLowerCase()}")) {
              dummyListData.add(item);
            }
          }).toList();
        } catch (e) {
          print(e);
        }
      } else {
        projectUtil.printP("item :$item");
        String jsonString = json.encode(item);
        if (jsonString
            .toLowerCase()
            .contains(widget.searchKeyWord.toLowerCase())) {
          dummyListData.add(item);
        }
      }
    });
    setState(() {
      listData.clear();
      listData.addAll(dummyListData);
    });
  }*/ /*
}*/
