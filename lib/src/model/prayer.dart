class Prayer {
  final int index;
  final String namazName;
  final String namazTime;
  bool isCurrentNamaz;

  Prayer(
      {required this.index,
        required this.namazName,
        required this.namazTime,
        required this.isCurrentNamaz});
}