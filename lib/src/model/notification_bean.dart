class NotificationBean {
  bool error;
  Success success;

  NotificationBean({this.error, this.success});

  NotificationBean.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.success != null) {
      data['success'] = this.success.toJson();
    }
    return data;
  }
}

class Success {
  int code;
  String type;
  String message;
  Data data;

  Success({this.code, this.type, this.message, this.data});

  Success.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['type'] = this.type;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  List<NotificationResults> results;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  Data(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results.add(new NotificationResults.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class NotificationResults {
  String notificationId;
  String notificationReceiverId;
  String notificationSenderId;
  int notificationRedirectionType;
  String notificationRedirectionId;
  String readAt;
  String createdAt;
  String updatedAt;
  NotificationSenderDetails notificationSenderDetails;
  NotificationData notificationData;
  String id;

  NotificationResults(
      {this.notificationId,
      this.notificationReceiverId,
      this.notificationSenderId,
      this.notificationRedirectionType,
      this.notificationRedirectionId,
      this.readAt,
      this.createdAt,
      this.updatedAt,
      this.notificationSenderDetails,
      this.notificationData,
      this.id});

  NotificationResults.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    notificationReceiverId = json['notification_receiver_id'];
    notificationSenderId = json['notification_sender_id'];
    notificationRedirectionType = json['notification_redirection_type'];
    notificationRedirectionId = json['notification_redirection_id'];
    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    notificationSenderDetails = json['notification_sender_details'] != null
        ? new NotificationSenderDetails.fromJson(
            json['notification_sender_details'])
        : null;
    notificationData = json['notificationData'] != null
        ? new NotificationData.fromJson(json['notificationData'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['notification_receiver_id'] = this.notificationReceiverId;
    data['notification_sender_id'] = this.notificationSenderId;
    data['notification_redirection_type'] = this.notificationRedirectionType;
    data['notification_redirection_id'] = this.notificationRedirectionId;
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.notificationSenderDetails != null) {
      data['notification_sender_details'] =
          this.notificationSenderDetails.toJson();
    }
    if (this.notificationData != null) {
      data['notificationData'] = this.notificationData.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class NotificationSenderDetails {
  int userType;
  String profileImage;
  String fullname;
  String id;

  NotificationSenderDetails(
      {this.userType, this.profileImage, this.fullname, this.id});

  NotificationSenderDetails.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    profileImage = json['profile_image'];
    fullname = json['fullname'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['profile_image'] = this.profileImage;
    data['fullname'] = this.fullname;
    data['id'] = this.id;
    return data;
  }
}

class NotificationData {
  String notificationType;
  String notificationTitle;
  String notificationBody;
  String notificationData;
  String createdAt;
  String updatedAt;
  String id;

  NotificationData(
      {this.notificationType,
      this.notificationTitle,
      this.notificationBody,
      this.notificationData,
      this.createdAt,
      this.updatedAt,
      this.id});

  NotificationData.fromJson(Map<String, dynamic> json) {
    notificationType = json['notification_type'];
    notificationTitle = json['notification_title'];
    notificationBody = json['notification_body'];
    notificationData = json['notification_data'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_type'] = this.notificationType;
    data['notification_title'] = this.notificationTitle;
    data['notification_body'] = this.notificationBody;
    data['notification_data'] = this.notificationData;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}
