import 'dart:io';
import 'package:video_player/video_player.dart';

import 'package:flutter/material.dart';
import 'package:wechat_app/data/model/we_chat_modeLimpl.dart';
import 'package:wechat_app/data/model/we_chat_model.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

class WeChatDiscoverPageBloc extends ChangeNotifier {
  ///State Variable
  File? _photos;
  File? _videoFile;
  bool _isDisposed = false;
  VideoPlayerController? _videoPlayer;
  bool _loading = false;
  bool _showDetails=false;
  bool _showCommentTextField=false;
  List<MomentVO>?_momentVO;
  MomentVO ? _detailsMoment;
  String _description = '';
  String _imageNetworkLink='';
  String _videoNetworkLink='';

  ///Getter
  VideoPlayerController? get getVideos => _videoPlayer;
  File? get getPhotos => _photos;
  File? get getVideoFiles => _videoFile;
  bool get isLoading => _loading;
  bool get isShowDetails=>_showDetails;
  bool get isShowCommentTextField=>_showCommentTextField;
  String get getDescription => _description;
  String get getImageNetWorkLink => _imageNetworkLink;
  String get getVideoNetWorkLink => _videoNetworkLink;
  List<MomentVO>?get getMomentVO=>_momentVO;
  MomentVO ? get getDetailsMoment=>_detailsMoment;


  ///Model
  final WeChatModel _weChatModel = WeChatModelImpl();

  WeChatDiscoverPageBloc([int ? id]){
    _weChatModel.getMoments().listen((data) {
      _momentVO=data;
      _notifySafely();
    },
      onError: (error)=>debugPrint(error)
    );
    if(id!=null){
      prePopulateData(id);
    }
  }
  Future<void> deletePost(int id){
    return _weChatModel.delete(id);
  }

  void prePopulateData(int id){
   _weChatModel.getMomentByID(id).listen((event) {
     _description=event.description;
     _videoNetworkLink=event.postVideo;
     _imageNetworkLink=event.postImage;
     _notifySafely();
   },
     onError: (error)=>debugPrint(error)
   );

  }
  void setIsLikedState(MomentVO momentVO){
    List<MomentVO>temp=_momentVO?.map((data) {
      if(data==momentVO){
        data.isLiked=!data.isLiked;
      }
      return data;
    }).toList()??[];
    _momentVO=temp;
    _notifySafely();
  }

  void setIsShowCommentTextFieldState(){
    _showCommentTextField=!_showCommentTextField;
    _notifySafely();
  }
  void setIsShowDetailsState([MomentVO? momentVO]){
    _showDetails=!_showDetails;
    if(_showDetails){
      _detailsMoment=momentVO;
    }
    _notifySafely();
  }
  void setPhotos(File photos) {
    _photos = photos;
    _notifySafely();
  }

  Future<void> addPost(int id) {
    if (id == -1) {
      _loading = true;
      _notifySafely();
      return _weChatModel
          .addNewPost(_description, _photos, _videoFile)
          .then((_) {
        _loading = false;
        _notifySafely();
      });
    } else {
      return Future.value('Data');
    }
  }

  void setDescription(String description) {
    _description = description;
    _notifySafely();
  }

  void setVideos(VideoPlayerController vl, File file) {
    if (file.path.isNotEmpty) {
      _videoFile = file;
    }
    vl
      ..addListener(() {})
      ..initialize().then((_) {
        _videoPlayer?.play();
      });
    _videoPlayer = vl;
    _notifySafely();
  }

  void removePhoto() {
    _photos = null;
    _imageNetworkLink='';
    _notifySafely();
  }

  void removeVideo() {
    _videoPlayer = null;
    _videoNetworkLink='';
    _notifySafely();
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayer?.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
