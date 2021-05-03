import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fullter_main_app/src/all_file_import/app_values_files_link.dart';
import 'package:provider/provider.dart';

class TabBarWidget extends StatefulWidget {
  final menuClickedCallBack, selectedTabMenu;
  final int notificationCount;
  final centerBigMenu;
  final Color disableItemColor;
  final Color enableItemColor;
  final List<TabBarItemsDetails> tabBarItems;
  final bool showLabels;
  final TextStyle labelTextStyle;

  TabBarWidget(
      {this.menuClickedCallBack,
      this.selectedTabMenu,
      this.notificationCount,
      this.centerBigMenu,
      this.enableItemColor,
      this.disableItemColor,
      @required this.tabBarItems,
      this.showLabels,
      this.labelTextStyle});

  @override
  _TabBarWidgetState createState() {
    _TabBarWidgetState mBottomNavigationBarState =
        _TabBarWidgetState(this.selectedTabMenu);
    return mBottomNavigationBarState;
  }
}

class _TabBarWidgetState extends State<TabBarWidget> {
  var screenHeight, screenWidth;
  var menuClickedCallBack;
  int selectedTabMenu = 0;
  List<TabBarItemsDetails> tabBarItems = [];
  bool isBackground = true;

  _TabBarWidgetState(selectedTabMenu) {
    if (selectedTabMenu != null) {
      this.selectedTabMenu = selectedTabMenu;
    }
  }

  /*============add items for bottom bar===========*/
  addBottomBarItems() {
    if (widget.tabBarItems != null && widget.tabBarItems.length > 0) {
      if (widget.tabBarItems.length <= 5) {
        tabBarItems = [];
        tabBarItems.addAll(widget.tabBarItems);
      } else {}
    } else {}
  }

  @override
  void initState() {
    super.initState();
  }

  /*================on item tapped====================*/
  onItemTapped(int index) {
    /*setState(() {
      if (index != 4) {
        selectedTabMenu = index;
      }
    });*/
    menuClickedCallBack(index);
  }

  //Dynamic height
  double heightFullScreen() {
    try {
      MediaQueryData _mediaQueryData = MediaQuery.of(context);
      double value = _mediaQueryData.size.height;
      return value;
    } catch (e) {
      print(e);
      return 0.0;
    }
  }

//Dynamic width
  double widthFullScreen() {
    try {
      MediaQueryData _mediaQueryData = MediaQuery.of(context);
      double value = _mediaQueryData.size.width;
      return value;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = heightFullScreen();
    screenWidth = widthFullScreen();

    menuClickedCallBack = widget.menuClickedCallBack;

    if (mounted) {
      selectedTabMenu = widget.selectedTabMenu;
    }
    if (tabBarItems.length <= 0) {
      addBottomBarItems();
    }
    /*================on item tapped====================*/
    double _bottomBarHeightTemp = kBottomNavigationBarHeight + 12;
    Color _selectedItemColor = Color(0xFF4AA546);
    Color _unSelectedItemColor = Color(0xFFA3AEB5);
    Color _disabledItemColor = Color(0xFFA3AEB5);
    Color _bottomBarBgColor = Color(0xFFFFFFFF);

    double _bottomBarIconSize = _bottomBarHeightTemp / 2.5;
    double _bottomBarCenterIconSize = _bottomBarHeightTemp / 1.1;
    double _bottomBarHeight =
        _bottomBarHeightTemp; //Update app bar height according center button

    Widget menuIcon(String iconSelected, String icon, int itemIndex, int index,
        Icon iconData) {
      Widget iconTemp = Container();
      if (iconData != null) {
        Icon iconDataTemp = Icon(
          iconData.icon,
          color: (itemIndex == selectedTabMenu)
              ? widget.enableItemColor
              : (widget.disableItemColor != null
                  ? widget.disableItemColor
                  : _disabledItemColor),
          size: index == 3
              ? (widget.centerBigMenu != null
                  ? (_bottomBarCenterIconSize - 15)
                  : _bottomBarIconSize)
              : _bottomBarIconSize,
        );
        iconTemp = iconDataTemp;
      } else if (iconSelected != null) {
        if (iconSelected.contains(".svg")) {
          iconTemp = SvgPicture.asset(
              (itemIndex == selectedTabMenu) ? iconSelected : icon,
              width: index == 3
                  ? (widget.centerBigMenu != null
                      ? (_bottomBarCenterIconSize - 15)
                      : _bottomBarIconSize)
                  : _bottomBarIconSize,
              height: index == 3
                  ? (widget.centerBigMenu != null
                      ? (_bottomBarCenterIconSize - 15)
                      : _bottomBarIconSize)
                  : _bottomBarIconSize,
              color: (itemIndex == selectedTabMenu)
                  ? widget.enableItemColor
                  : (widget.disableItemColor != null
                      ? widget.disableItemColor
                      : _disabledItemColor),
              fit: BoxFit.scaleDown);
        } else {
          iconTemp = Image(
            image: AssetImage(
                (itemIndex == selectedTabMenu) ? iconSelected : icon),
            width: index == 3
                ? (widget.centerBigMenu != null
                    ? _bottomBarCenterIconSize
                    : _bottomBarIconSize)
                : _bottomBarIconSize,
            height: index == 3
                ? (widget.centerBigMenu != null
                    ? _bottomBarCenterIconSize
                    : _bottomBarIconSize)
                : _bottomBarIconSize,
            color: (itemIndex == selectedTabMenu)
                ? widget.enableItemColor
                : (widget.disableItemColor != null
                    ? widget.disableItemColor
                    : _disabledItemColor),
          );
        }
      }
      return iconTemp;
    }

    /*===========common function for bar item ===================*/
    barItems(String icon, int itemIndex, String iconSelected, int index,
        String menuName, Icon iconData) {
      return BottomNavigationBarItem(
        //backgroundColor: Colors.red,
        icon: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: menuIcon(iconSelected, icon, itemIndex, index, iconData),
        ),
        title: (widget.showLabels != null && widget.showLabels)
            ? (menuName != null
                ? Text(
                    menuName,
                    style: widget.labelTextStyle,
                  )
                : Text(""))
            : SizedBox.shrink(),
      );
    }

    /*=====================get bar items=================*/
    List<BottomNavigationBarItem> getItems() {
      if (tabBarItems != null) {
        List<BottomNavigationBarItem> items = [];
        for (int i = 0; i < tabBarItems.length; i++) {
          items.add(barItems(
              tabBarItems[i].icon,
              i,
              tabBarItems[i].iconSelected,
              (i + 1),
              tabBarItems[i].menuName,
              tabBarItems[i].iconData));
        }
        return items;
      } else {
        print('no item');
        return null;
      }
    }

    /*=====================return navigation bar view========================*/
    return SafeArea(
      child: Container(
        alignment: Alignment.topCenter,
        color: _bottomBarBgColor,
        height: (_bottomBarHeight),
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: (_bottomBarHeight), //(_bottomBarHeight - 10)
                  child: BottomNavigationBar(
                    backgroundColor: _bottomBarBgColor,
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    currentIndex: selectedTabMenu,
                    selectedItemColor: _selectedItemColor,
                    unselectedItemColor: _unSelectedItemColor,
                    items: getItems(),
                    onTap: onItemTapped,
                    showSelectedLabels:
                        (widget.showLabels != null && widget.showLabels)
                            ? true
                            : false,
                    showUnselectedLabels:
                        (widget.showLabels != null && widget.showLabels)
                            ? true
                            : false,
                  ),
                ),
              ),
            ),
            Positioned(
                child: Align(
                    alignment: Alignment.center,
                    child: widget.centerBigMenu != null
                        ? Container(
                            height: widget.centerBigMenu != null
                                ? _bottomBarCenterIconSize
                                : 0,
                            width: widget.centerBigMenu != null
                                ? _bottomBarCenterIconSize
                                : 0,
                            child: widget.centerBigMenu)
                        : Container()))
          ],
        ),
      ),
    );
  }
}

class TabBarItemsDetails {
  Icon iconData;
  String icon;
  String iconSelected;
  String menuName;
  TabBarItemsDetails(
      {this.icon, this.iconSelected, this.menuName, this.iconData});
}
