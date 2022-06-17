
import 'package:wechat_app/data/model/we_chat_real_time_model.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_tim_data_gent.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_time_data_agent_impl.dart';

class WeChatRealTimeModelImpl extends WeChatRealTimeModel{

  final WeChatRealTimeDataAgent _weChatRealTimeDataAgent=WeChatRealTimeDataAgentImpl();
  @override
  Future<void> addChatToServer(ChattingUserVO chattingUserVO, String friID) =>_weChatRealTimeDataAgent.addChatToServer(chattingUserVO, friID);

  @override
  Future<void> deleteChat(String friID) =>_weChatRealTimeDataAgent.deleteChat(friID);

  @override
  Stream<List<ChattingUserVO>> getChatList(String friID) =>_weChatRealTimeDataAgent.getChatList(friID);

  @override
  Stream<List<String?>> chatHistoryIDList() =>_weChatRealTimeDataAgent.chatHistoryIDList();

  @override
  Stream<List<ChattingUserVO>> getAllChatByID(String id) =>_weChatRealTimeDataAgent.getAllChatByID(id);

}