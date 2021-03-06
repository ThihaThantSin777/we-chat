

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat_app/data/vos/chat_vo/chat_vo.dart';
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
  Future<void> addChatToServer(ChatVO chattingUserVO,String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    databaseRef
        .child(contactsAndMessages)
        .child(loggedInUserID).child(friID).child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(chattingUserVO.toJson());

   return databaseRef
        .child(contactsAndMessages)
        .child(friID).child(loggedInUserID).child(DateTime.now().millisecondsSinceEpoch.toString())
        .set(chattingUserVO.toJson());

  }

  @override
  Future<void> deleteChat(String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    print('logged in id $loggedInUserID');
    databaseRef.child(contactsAndMessages).child(friID).child(loggedInUserID).remove();
    return databaseRef.child(contactsAndMessages).child(loggedInUserID).child(friID).remove();
  }

  @override
  Stream<List<ChatVO>> getChatList(String friID) {
    String loggedInUserID=auth.currentUser?.uid??'';
    return databaseRef
        .child(contactsAndMessages)
        .child(loggedInUserID)
        .child(friID)
        .onValue.map((event){
      return event.snapshot.children.map<ChatVO>((snapshot){
        return ChatVO.fromJson(Map<String,dynamic>.from(snapshot.value as Map));
      }).toList();
    });
  }



  @override
  Future<List<ChatVO>> getAllChattingList(String friID) {
    String loggedInUserID = auth.currentUser?.uid ?? '';
   return databaseRef
        .child(contactsAndMessages)
        .child(loggedInUserID)
        .child(friID)
        .onValue.map((event){
      return event.snapshot.children.map<ChatVO>((snapshot){
        return ChatVO.fromJson(Map<String,dynamic>.from(snapshot.value as Map));
      }).toList();
    }).first;

  }

  @override
  Stream<List<String?>> getFriendsID() {
    String loggedInUserID = auth.currentUser?.uid ?? '';
    return  databaseRef
        .child(contactsAndMessages)
        .child(loggedInUserID)
        .onValue
        .map((event){
      return event.snapshot.children.map((snapshot){
        return snapshot.key;
      }).toList();
    });
  }
}