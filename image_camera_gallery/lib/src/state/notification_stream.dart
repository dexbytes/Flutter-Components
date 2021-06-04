import 'dart:async';

enum NotificationFor {
  anyNotification,
  newPosNotification,
  acceptance,
  production
}

class DataRefreshStream {
  DataRefreshStream._internal();
  static final DataRefreshStream instance = DataRefreshStream._internal();
  StreamController<dynamic> _dataRefreshStreamController =
      StreamController<dynamic>();
  StreamController<dynamic> get notificationsStream {
    _dataRefreshStreamController = StreamController<dynamic>();
    return _dataRefreshStreamController;
  }

  void refreshDataOnUi(dynamic notification) {
    _dataRefreshStreamController.sink.add(notification);
  }

  void itemClicked(dynamic notification) {
    _dataRefreshStreamController.sink.add(notification);
  }

  void dispose() {
    if (_dataRefreshStreamController != null) {
      _dataRefreshStreamController.close();
    }
  }
}
