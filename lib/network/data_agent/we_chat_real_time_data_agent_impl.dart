
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_app/data/vos/chatting_vo/chatting_user_vo.dart';
import 'package:wechat_app/network/data_agent/we_chat_real_tim_data_gent.dart';
import 'package:firebase_database/firebase_database.dart';

const contactsAndMessages = 'contactsAndMessages';


class WeChatRealTimeDataAgentImpl extends WeChatRealTimeDataAgent{

  WeChatRealTimeDataAgentImpl._internal();

  static final WeChatRealTimeDataAgentImpl _singleton=WeChatRealTimeDataAgentImpl._internal();
  factory WeChatRealTimeDataAgentImpl ()=>_singleton;

  var databaseRef = FirebaseDatabase.instance.reference();
  var firebaseStorage = FirebaseStorage.instance;
  var auth = FirebaseAuth.instance;

  @override
  Future<void> addChatToServer(ChattingUserVO chattingUserVO,String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    databaseRef
        .child(contactsAndMessages)
        .child(loggedInUserID).child(friID)
        .set(chattingUserVO.toJson());

   return databaseRef
        .child(contactsAndMessages)
        .child(friID).child(loggedInUserID)
        .set(chattingUserVO.toJson());

  }

  @override
  Future<void> deleteChat(String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    return databaseRef.child(contactsAndMessages).child(loggedInUserID).child(friID).remove();
  }

  @override
  Stream<List<ChattingUserVO>> getChatList(String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    return databaseRef.child(contactsAndMessages).child(loggedInUserID).child(friID).onValue.map((event) {
      return event.snapshot.value.values.map<ChattingUserVO>((element){
        return ChattingUserVO.fromJson(Map<String,dynamic>.from(element));
      }).toList();
    });
  }
  
}