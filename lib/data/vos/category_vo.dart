import 'package:json_annotation/json_annotation.dart';
part 'category_vo.g.dart';
@JsonSerializable()
class CategoryVO{
  @JsonKey(name: 'categoryId')
  final String? categoryId;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'image')
  final String? image;

  CategoryVO({this.categoryId,this.name,this.image});
  factory CategoryVO.fromJson(Map<String,dynamic> json)=>_$CategoryVOFromJson(json);
  Map<String,dynamic> toJson()=>_$CategoryVOToJson(this);
}