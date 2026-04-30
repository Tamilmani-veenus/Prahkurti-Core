class SubConImagePayload {
  String? entryMode;
  String? labrAttnId;
  String? labrAttnN0;

  SubConImagePayload({
    this.entryMode,
    this.labrAttnId,
    this.labrAttnN0,
  });

  Map<String, dynamic> toJson() {
    return {
      'EntryMode': entryMode,
      'LabrAttn_Id': labrAttnId,
      'LabrAttn_No': labrAttnN0,
    };
  }
}
