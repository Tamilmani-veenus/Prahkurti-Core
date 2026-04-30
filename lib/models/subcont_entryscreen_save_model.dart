 import 'dart:convert';
import 'dart:io';

 SubcontEntryScreenSaveRequest subcontEntryScreenSaveRequestFromJson(String str) => SubcontEntryScreenSaveRequest.fromJson(json.decode(str));

 String subcontEntryScreenSaveRequestToJson(SubcontEntryScreenSaveRequest data) => json.encode(data.toJson());

 class SubcontEntryScreenSaveRequest {
   SubcontEntryScreenSaveRequest({
     this.Id,
     this.attenNo,
     this.attenDate,
     this.totNos,
     this.totAmt,
     this.remarks,
     this.createdBy,
     this.createdDt,
     this.workType,
     this.projectId,
     this.approveStatus,
     this.approvedDt,
     this.approvedBy,
     this.subContId,
     this.siteId,
     this.subContLabourAttendDetS,
   });

   int? Id;
   String? attenNo;
   String? attenDate;
   double? totNos;
   double? totAmt;
   String? remarks;
   int? createdBy;
   String? createdDt;
   String? workType;
   int? projectId;
   String? approveStatus;
   String? approvedDt;
   int? approvedBy;
   int? subContId;
   int? siteId;
   List<SubContLabourAttendDetS>? subContLabourAttendDetS;

   factory SubcontEntryScreenSaveRequest.fromJson(Map<String, dynamic> json) => SubcontEntryScreenSaveRequest(
     Id: json["Id"],
     attenNo: json["LabourAttendanceNo"],
     attenDate:json["LabourAttendanceDate"],
     totNos: json["TotNos"],
     totAmt: json["TotAmt"],
     remarks: json["Remarks"],
     createdBy: json["CreatedBy"],
     createdDt: json["CreatedDt"],
     workType: json["WorkType"],
     projectId: json["ProjectId"],
     approveStatus: json["ApproveStatus"],
     approvedDt: json["ApprovedDt"],
     approvedBy: json["ApprovedBy"],
     subContId: json["SubcontractorId"],
     siteId: json["SiteId"],
     subContLabourAttendDetS: List<SubContLabourAttendDetS>.from(json["SubContLabourAttendDetS"].map((x) => SubContLabourAttendDetS.fromJson(x))),
   );

   Map<String, dynamic> toJson() => {
     "Id": Id,
     "LabourAttendanceNo": attenNo,
     "LabourAttendanceDate": attenDate,
     "TotNos": totNos,
     "TotAmt": totAmt,
     "Remarks": remarks,
     "CreatedBy": createdBy,
     "CreatedDt": createdDt,
     "WorkType": workType,
     "ProjectId": projectId,
     "ApprovedDt": approvedDt,
     "ApprovedBy": approvedBy,
     "SubcontractorId": subContId,
     "SiteId": siteId,
     "SubContLabourAttendDetS": List<dynamic>.from(subContLabourAttendDetS!.map((x) => x.toJson())),
   };
 }

 class SubContLabourAttendDetS {
   SubContLabourAttendDetS({
     this.rate,
     this.siteId,
     this.otHrs,
     this.subContLabourMasId,
     this.otNos,
     this.eveotAmt,
     this.eveotHrs,
     this.nos,
     this.morotAmt,
     this.remarks,
     this.morotHrs,
     this.lbrCatId,
     this.extraAmt,
     this.extra,
     this.labourId,
     this.id,
     this.totalAmount
   });

   double? rate;
   int? siteId;
   double? otHrs;
   int? subContLabourMasId;
   double? otNos;
   double? eveotAmt;
   double? eveotHrs;
   double? nos;
   double? morotAmt;
   String? remarks;
   double? morotHrs;
   int? lbrCatId;
   double? extraAmt;
   double? extra;
   int? labourId;
   int? id;
   double? totalAmount;

   factory SubContLabourAttendDetS.fromJson(Map<String, dynamic> json) => SubContLabourAttendDetS(
     rate: json["rate"],
     siteId: json["siteId"],
     otHrs: json["otHrs"],
     subContLabourMasId: json["subContLabourMasId"],
     otNos: json["otNos"],
     eveotAmt: json["eveotAmt"],
     eveotHrs: json["eveotHrs"],
     nos: json["nos"],
     morotAmt: json["morotAmt"],
     remarks: json["remarks"],
     morotHrs: json["morotHrs"],
     lbrCatId: json["labourCategoryId"],
     extraAmt: json["extraAmt"],
     extra: json["extra"],
     id: json["id"],
     labourId: json["labourId"],
     totalAmount: json["totalAmount"],
   );

   Map<String, dynamic> toJson() => {
     "rate": rate,
     "siteId": siteId,
     "otHrs": otHrs,
     "subContLabourMasId": subContLabourMasId,
     "otNos": otNos,
     "eveotAmt": eveotAmt,
     "eveotHrs": eveotHrs,
     "nos": nos,
     "morotAmt": morotAmt,
     "remarks": remarks,
     "morotHrs": morotHrs,
     "labourCategoryId": lbrCatId,
     "extraAmt": extraAmt,
     "extra": extra,
     "id": id,
     "labourId": labourId,
     "totalAmount": totalAmount,
   };
 }

