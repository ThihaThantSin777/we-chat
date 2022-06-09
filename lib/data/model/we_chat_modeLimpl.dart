import 'package:wechat_app/data/model/we_chat_model.dart';
import 'package:wechat_app/persistant/impl/light_or_dark_dao_impl.dart';

import '../../persistant/dao/light_or_dark_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class WeChatModelImpl extends WeChatModel {
  final LightOrDarkDAO _lightOrDarkDAO = LightOrDarkDAOImpl();

  @override
  Stream<bool> getThemeMode() => _lightOrDarkDAO
      .lightOrDarkEvent()
      .startWith(_lightOrDarkDAO.getModeStream())
      .map((event) => _lightOrDarkDAO.getMode());

  @override
  void saveThemeMode(bool mode) {
    _lightOrDarkDAO.save(mode);
  }
}
