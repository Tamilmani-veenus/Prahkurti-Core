class SiteVocImagePayload {
  String? entryMode;
  String? vocId;
  String? vocNo;

  SiteVocImagePayload({
    this.entryMode,
    this.vocId,
    this.vocNo,
  });

  Map<String, dynamic> toJson() => {
    "EntryMode": entryMode,
    "voc_id": vocId,
    "voc_no": vocNo,
  };
}
