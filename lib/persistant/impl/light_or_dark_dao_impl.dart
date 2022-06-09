import 'package:hive/hive.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';
import 'package:wechat_app/persistant/dao/light_or_dark_dao.dart';

class LightOrDarkDAOImpl extends LightOrDarkDAO {
  LightOrDarkDAOImpl._private();

  static final LightOrDarkDAOImpl _singleton = LightOrDarkDAOImpl._private();

  factory LightOrDarkDAOImpl() => _singleton;

  @override
  bool getMode() => _getBox().values.toList().where((element) => element).first;

  @override
  void save(bool value) {
    _getBox().put(value ? lightModeKey : darkModeKey, value);
  }

  Box<bool> _getBox() => Hive.box<bool>(boxNameForTheme);

  @override
  Stream lightOrDarkEvent() => _getBox().watch();

  @override
  Stream<bool> getModeStream() => Stream.value(getMode());
}
