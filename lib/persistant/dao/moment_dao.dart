import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';

abstract class MomentDAO{
  void save(MomentVO momentVO);

  void saveList(List<MomentVO>momentVOList);

  MomentVO ? getSingleMomentVO(String id);

  List<MomentVO>? getMomentVOList();

  void deleteMomentVO(String id);

  Stream getMomentVOStream();

  Stream<MomentVO?>getSingleMomentVoStreamEvent(String id);

  Stream<List<MomentVO>?>getMomentVoListStreamEvent();
}