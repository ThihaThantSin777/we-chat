
import 'package:flutter/material.dart';
import 'package:wechat_app/utils/enums.dart';

class WeChatHomePageBloc extends ChangeNotifier{

  ///State Variable
int _pageIndex=WeChatPages.chatHistoryPage.index;
bool _isDisposed = false;

///getter
int get getPageIndex=>_pageIndex;



void pagesChanges(int index){
  _pageIndex=WeChatPages.values[index].index;
  _notifySafely();
}

void _notifySafely() {
  if (!_isDisposed) {
    notifyListeners();
  }
}

@override
void dispose() {
  super.dispose();
  _isDisposed = true;
}

}