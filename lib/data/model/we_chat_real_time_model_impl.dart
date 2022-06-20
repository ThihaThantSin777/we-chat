
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_tim_data_gent.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_time_data_agent_impl.dart';

class WeChatRealTimeModelImpl extends WeChatRealTimeModel{

  final WeChatRealTimeDataAgent _weChatRealTimeDataAgent=WeChatRealTimeDataAgentImpl();
  @override
  Future<void> addChatToServer(ChatVO chattingUserVO, String friID) =>_weChatRealTimeDataAgent.addChatToServer(chattingUserVO, friID);

  @override
  Future<void> deleteChat(String friID) =>_weChatRealTimeDataAgent.deleteChat(friID);

  @override
  Stream<List<ChatVO>> getChatList(String friID) =>_weChatRealTimeDataAgent.getChatList(friID);

  @override
  Future<List<ChatVO>> getAllChattingList(String friID) =>_weChatRealTimeDataAgent.getAllChattingList(friID);

  @override
  Stream<List<String?>> getFriendsID() =>_weChatRealTimeDataAgent.getFriendsID();

}