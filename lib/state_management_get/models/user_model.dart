class UserModel {
  UserModel({
    this.id,
    this.userImage,
    this.userName,
    this.userPassword,
    this.userPhone,
    this.userAddress,
    this.userEmail,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userImage = json['userImage'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userPhone = json['userPhone'];
    userAddress = json['userAddress'];
    userEmail = json['userEmail'];
  }

  num? id;
  String? userImage;
  String? userName;
  String? userPassword;
  String? userPhone;
  String? userAddress;
  String? userEmail;

  UserModel copyWith({
    num? id,
    String? userImage,
    String? userName,
    String? userPassword,
    String? userPhone,
    String? userAddress,
    String? userEmail,
  }) =>
      UserModel(
        id: id ?? this.id,
        userImage: userImage ?? this.userImage,
        userName: userName ?? this.userName,
        userPassword: userPassword ?? this.userPassword,
        userPhone: userPhone ?? this.userPhone,
        userAddress: userAddress ?? this.userAddress,
        userEmail: userEmail ?? this.userEmail,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['userImage'] = userImage;
    map['userName'] = userName;
    map['userPassword'] = userPassword;
    map['userPhone'] = userPhone;
    map['userAddress'] = userAddress;
    map['userEmail'] = userEmail;
    return map;
  }
}
