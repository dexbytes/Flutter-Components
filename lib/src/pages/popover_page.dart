import 'package:flutter/material.dart';
import 'package:fullter_main_app/src/api_calling/api_constant.dart';
import 'package:fullter_main_app/src/widgets/DraggableFloatingActionButton.dart';
import 'package:fullter_main_app/src/widgets/android_ios_check_box.dart';
import 'package:fullter_main_app/src/widgets/pop_over/popup_menu.dart';

class PopoverPage extends StatefulWidget {
  PopoverPage({Key key}) : super(key: key);
  @override
  _PopoverPageState createState() => _PopoverPageState();
}

class _PopoverPageState extends State<PopoverPage> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  GlobalKey btnKey2 = GlobalKey();
  GlobalKey btnKey3 = GlobalKey();
  GlobalKey btnKey4 = GlobalKey();
  DraggableFloatingActionButtonController
      mDraggableFloatingActionButtonController =
      DraggableFloatingActionButtonController();
  @override
  void initState() {
    super.initState();

    menu = PopupMenu(items: [
      // MenuItem(title: 'Copy', image: Image.asset('assets/copy.png')),
      // MenuItem(title: 'Home', image: Icon(Icons.home, color: Colors.white,)),
      MenuItem(title: 'Mail'),
      MenuItem(title: 'Power'),
      MenuItem(title: 'Setting'),
      MenuItem(title: 'PopupMenu')
    ], onClickMenu: onClickMenu, onDismiss: onDismiss, maxColumn: 1);
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("PopOver"),
        actions: <Widget>[
          // action button
          IconButton(
            key: btnKey,
            icon: Icon(Icons.access_time),
            onPressed: () {
              maxColumn();
            },
          ),
          IconButton(
            key: btnKey2,
            icon: Icon(Icons.memory),
            onPressed: () {
              maxColumn();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 150,
                  child: MaterialButton(
                    height: 45.0,
                    //key: btnKey,
                    child: GestureDetector(
                        onTap: () {
                          maxColumn(btnKeyObj: btnKey3, maxColumn: 1);
                        },
                        child:
                            Container(key: btnKey3, child: Text('Show Menu'))),
                  ),
                ),
                Container(
                  width: 200,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () {
                          maxColumn(btnKeyObj: btnKey4, maxColumn: 2);
                        },
                        child: Container(key: btnKey4, child: Text('Me'))),
                  ),
                ),
              ],
            ),
          ),
          DraggableFloatingActionButton(
              controller: mDraggableFloatingActionButtonController,
              childViewSize: Size(250, 120),
              childView: AndroidIosCheckbox(
                onChanged: () {
                  mDraggableFloatingActionButtonController.callToCollapse();
                  setState(() {});
                },
              ),
              appContext: context,
              data: 'Demo',
              offset: new Offset(100, 100),
              backgroundColor: Colors.white,
              child: Icon(
                Icons.wb_incandescent,
                color:
                    ConstantC.isAndroidPlatform ? Colors.green : Colors.yellow,
              ) /*,
                            childSelected: new Icon(
                              Icons.wb_incandescent,
                              color: Colors.green,
                            )*/
              )
        ],
      ),
    );
  }

  void onGesturesDemo() {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GestureDemo()),
    );*/
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  void maxColumn({GlobalKey btnKeyObj, int maxColumn = 1}) {
    if (btnKeyObj == null) {
      btnKeyObj = btnKey;
    }
    PopupMenu menu = PopupMenu(
        isAndroid: ConstantC.isAndroidPlatform,
        //backgroundColor: Colors.blue,
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        maxColumn: maxColumn,
        items: [
          MenuItem(title: 'Copy'),
          // MenuItem(
          //     title: 'Home',
          //     // textStyle: TextStyle(fontSize: 10.0, color: Colors.tealAccent),
          //     image: Icon(
          //       Icons.home,
          //       color: Colors.white,
          //     )),
          // MenuItem(
          //     title: 'Mail',
          //     image: Icon(
          //       Icons.mail,
          //       color: Colors.white,
          //     )),
          MenuItem(title: 'Power'),
          MenuItem(
            title: 'Setting',
          ),
          MenuItem(title: 'PopupMenu')
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKeyObj);
  }

  //
  void customBackground() {
    PopupMenu menu = PopupMenu(
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        // maxColumn: 2,
        items: [
          MenuItem(title: 'Copy'),
          MenuItem(
            title: 'Home',
          ),
          MenuItem(
            title: 'Mail',
          ),
          MenuItem(
            title: 'Power',
          ),
          MenuItem(
            title: 'Setting',
          ),
          MenuItem(
            title: 'PopupMenu',
          )
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey2);
  }
}
