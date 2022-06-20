import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

abstract class MomentDAO{
  void save(MomentVO momentVO);

  MomentVO ? getSingleMomentVO(int id);

  List<MomentVO>? getMomentVOList();

  void deleteMomentVO(int id);

  Stream getMomentVOStream();

  Stream<MomentVO?>getSingleMomentVoStreamEvent(int id);

  Stream<List<MomentVO>?>getMomentVoListStreamEvent();
}