class AppVersionBean {
  String msg;
  bool success;
  Result result;
  int statusCode;

  AppVersionBean({this.msg, this.success, this.result, this.statusCode});

  AppVersionBean.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    success = json['success'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Result {
  String id;
  String createTime;
  String updateTime;
  String version;
  String downloadUrl;
  bool latest;
  bool force;

  Result(
      {this.id,
        this.createTime,
        this.updateTime,
        this.version,
        this.downloadUrl,
        this.latest,
        this.force});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    version = json['version'];
    downloadUrl = json['downloadUrl'];
    latest = json['latest'];
    force = json['force'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['version'] = this.version;
    data['downloadUrl'] = this.downloadUrl;
    data['latest'] = this.latest;
    data['force'] = this.force;
    return data;
  }
}
