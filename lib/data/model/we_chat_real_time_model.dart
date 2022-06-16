import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';

abstract class WeChatRealTimeModel{
  Stream<List<ChattingUserVO>> getChatList(String friID);
  Future<void> addChatToServer(ChattingUserVO chattingUserVO,String friID);
  Future<void>deleteChat(String friID);
}