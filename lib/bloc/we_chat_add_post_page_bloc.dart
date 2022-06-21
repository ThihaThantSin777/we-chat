

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wechat_app/data/model/we_chat_auth_model.dart';
import 'package:wechat_app/data/model/we_chat_auth_model_impl.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/resources/strings.dart';

import '../data/model/we_chat_moment_model_impl.dart';
import '../data/model/we_chat_moment_model.dart';

class WeChatAddPostPageBloc extends ChangeNotifier {
  ///State Variable
  File? _photos;
  File? _videoFile;
  bool _isDisposed = false;
  VideoPlayerController? _videoPlayer;
  bool _loading = false;
  String _profileName='';
  String _profileImage='';
  String _description = '';
  String _imageNetworkLink = '';
  String _videoNetworkLink = '';
  TextEditingController? _controller;
  MomentVO ?_momentVO;


  ///Getter
  VideoPlayerController? get getVideos => _videoPlayer;
  MomentVO ? get getMomentVO=>_momentVO;
  File? get getPhotos => _photos;
  File? get getVideoFiles => _videoFile;
  bool get isLoading => _loading;
  String get getDescription => _description;
  TextEditingController? get getController=>_controller;
  String get getImageNetWorkLink => _imageNetworkLink;
  String get getVideoNetWorkLink => _videoNetworkLink;
  String get getProfileName=>_profileName;
  String get getProfileImage=>_profileImage;

  ///Model
  final WeChatMomentModel _weChatModel = WeChatMomentModelImpl();
  final WeChatAuthModel _weChatAuthModel=WeChatAuthModelImpl();

  WeChatAddPostPageBloc([int ?id]){
    _controller=TextEditingController();
    _weChatAuthModel.getUserVoStreamEvent(_weChatAuthModel.getLoggedInUserID()).listen((userVO) {
      _profileName=userVO?.userName??'';
      _profileImage=(userVO?.profileImage?.isEmpty??true)?kDefaultImage:userVO?.profileImage??'';
      _notifySafely();
    });
    if(id!=null){
      _prePopulateData(id);
    }
  }

  void _prePopulateData(int id) {
    _weChatModel.getMomentByID(id).listen((event) {
    _controller?.text=event.description;
      _videoNetworkLink = event.postVideo;
      _imageNetworkLink = event.postImage;
      _momentVO=event;
      _notifySafely();
    },
        onError: (error) => debugPrint(error)
    );
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

  void setPhotos(File photos) {
    _photos = photos;
    _notifySafely();
  }

  void removePhoto() {
    _photos = null;
    _imageNetworkLink = '';
    _notifySafely();
  }

  void removeVideo() {
    _videoFile=null;
    _videoPlayer = null;
    _videoNetworkLink = '';
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
      _loading = true;
      _notifySafely();
      MomentVO editMomentVO=_momentVO!;
      editMomentVO.description=_controller?.text??_momentVO?.description??'';
      return _weChatModel.editNewPost(editMomentVO, _photos, _videoFile).then((_) {
        _loading = false;
        _notifySafely();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayer?.dispose();
    _controller?.dispose();
    _isDisposed = true;
  }

  void _notifySafely() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}