import 'package:hive/hive.dart';
import 'package:wechat_app/data/vos/moment_vo/moment_vo.dart';
import 'package:wechat_app/persistant/constant/hive_constant.dart';
import 'package:wechat_app/persistant/dao/moment_dao.dart';

class MomentDaoImpl extends MomentDAO {
  @override
  void deleteMomentVO(String id) {
    _getMomentVOBox().delete(id);
  }

  @override
  List<MomentVO>? getMomentVOList() => _getMomentVOBox().values.toList();

  @override
  Stream getMomentVOStream() => _getMomentVOBox().watch();

  @override
  Stream<List<MomentVO>?> getMomentVoListStreamEvent() =>
      Stream.value(getMomentVOList());

  @override
  MomentVO? getSingleMomentVO(String id) => _getMomentVOBox().get(id);

  @override
  Stream<MomentVO?> getSingleMomentVoStreamEvent(String id) =>
      Stream.value(getSingleMomentVO(id));

  @override
  void save(MomentVO momentVO) {
    _getMomentVOBox().put(momentVO.id, momentVO);
  }

  Box<MomentVO> _getMomentVOBox() => Hive.box<MomentVO>(kBoxNameForMomentVO);

  @override
  void saveList(List<MomentVO> momentVOList) {
    Map<String, MomentVO> moments = {
      for (var moments in momentVOList) moments.id: moments
    };
    _getMomentVOBox().putAll(moments);
  }
}
