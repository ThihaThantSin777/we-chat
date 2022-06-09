class ChattingVO{
  String text;
  bool isLeft;

  ChattingVO(this.text, this.isLeft);

  @override
  String toString() {
    return 'ChattingVO{text: $text, isLeft: $isLeft}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChattingVO &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          isLeft == other.isLeft;

  @override
  int get hashCode => text.hashCode ^ isLeft.hashCode;
}