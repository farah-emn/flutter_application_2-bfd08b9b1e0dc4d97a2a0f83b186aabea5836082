class LoginInfo {
  String? username;
  String? password;
  bool? isChecked;

  LoginInfo({this.username, this.password, this.isChecked});

  LoginInfo.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    isChecked = json['is_checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['is_checked'] = this.isChecked;
    return data;
  }
}
