abstract class LightOrDarkDAO{
  void save(bool value);
  bool getMode();
  Stream<bool>getModeStream();
  Stream lightOrDarkEvent();
}