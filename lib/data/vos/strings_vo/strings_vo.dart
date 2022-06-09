import 'package:azlistview/azlistview.dart';

class StringVO extends ISuspensionBean{
  final String title;
  final String tag;


  StringVO(this.title, this.tag);


  @override
  String toString() {
    return 'StringVO{title: $title, tag: $tag}';
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StringVO &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          tag == other.tag;

  @override
  int get hashCode => title.hashCode ^ tag.hashCode;

  @override
  String getSuspensionTag() =>tag;

}