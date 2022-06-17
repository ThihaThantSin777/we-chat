import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';

abstract class WeChatRealTimeDataAgent{
  Stream<List<ChattingUserVO>> getChatList(String friID);
  Future<void> addChatToServer(ChattingUserVO chattingUserVO,String friID);
  Future<void>deleteChat(String friID);
  Stream<List<String?>>chatHistoryIDList();
  Stream<List<ChattingUserVO>>getAllChatByID(String id);


}