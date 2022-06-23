

import 'package:json_annotation/json_annotation.dart';

part 'data_vo.g.dart';

@JsonSerializable()
class DataVO{

@JsonKey(name: 'route_name')
String ?routeName;

@JsonKey(name: 'receiver_id')
String ?receiverID;

DataVO({required this.routeName, required this.receiverID});

factory DataVO.fromJson(Map<String,dynamic>json)=>_$DataVOFromJson(json);

DataVO.normal();

Map<String,dynamic>toJson()=>_$DataVOToJson(this);

@override
  String toString() {
    return 'DataVO{routeName: $routeName, receiverID: $receiverID}';
  }

@override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataVO &&
          runtimeType == other.runtimeType &&
          routeName == other.routeName &&
          receiverID == other.receiverID;

  @override
  int get hashCode => routeName.hashCode ^ receiverID.hashCode;
}