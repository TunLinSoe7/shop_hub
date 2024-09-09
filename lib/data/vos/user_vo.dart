import 'package:json_annotation/json_annotation.dart';
part 'user_vo.g.dart';

@JsonSerializable()
class UserVO{
  @JsonKey(name : 'userId')
  String? userId;
  @JsonKey(name : 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name : 'user_name')
  String? userName;
  @JsonKey(name : 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'token')
  String? token;
  UserVO({this.userId,this.name,this.userName,this.phoneNumber,this.email,this.token});
  factory UserVO.fromJson(Map<String,dynamic> json) =>_$UserVOFromJson(json);
  Map<String,dynamic> toJson()=>_$UserVOToJson(this);

}