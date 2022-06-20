
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';

abstract class WeChatRealTimeDataAgent{
  Stream<List<ChatVO>> getChatList(String friID);
  Future<void> addChatToServer(ChatVO chattingUserVO,String friID);
  Future<void>deleteChat(String friID);
  Future<List<ChatVO>> getAllChattingList(String friID);
  Stream<List<String?>>getFriendsID();

}