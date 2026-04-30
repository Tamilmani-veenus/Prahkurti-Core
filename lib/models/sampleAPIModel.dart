// To parse this JSON data, do
//
//     final sampleApiResmodel = sampleApiResmodelFromJson(jsonString);

import 'dart:convert';

SampleApiResmodel sampleApiResmodelFromJson(String str) => SampleApiResmodel.fromJson(json.decode(str));

String sampleApiResmodelToJson(SampleApiResmodel data) => json.encode(data.toJson());

class SampleApiResmodel {
  bool? success;
  List<Result>? result;

  SampleApiResmodel({
    this.success,
    this.result,
  });

  factory SampleApiResmodel.fromJson(Map<String, dynamic> json) => SampleApiResmodel(
    success: json["success"],
    result: json["result"] == null
        ? []   // or null, depending on your requirement
        : List<Result>.from(
        json["result"].map((x) => Result.fromJson(x))),  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),  };
}

class Result {
  int? id;
  dynamic employeeNo;
  String? employeeName;
  dynamic employeeCode;
  int? designationId;
  int? departmentId;
  int? companyId;
  int? projectId;
  DateTime? dob;
  dynamic gender;
  dynamic martialStatus;
  DateTime? dom;
  dynamic employeeAddress;
  int? cityId;
  DateTime? doj;
  dynamic panNo;
  dynamic aadharNo;
  dynamic email;
  dynamic contactNo;
  dynamic officialContactNo;
  dynamic emergencyContactNo;
  int? grossSalary;
  int? salOpBalAmt;
  dynamic salOpBalType;
  int? susOpBalAmt;
  dynamic susOpBalType;
  int? basicPay;
  int? projectAllowance;
  int? phoneAllowance;
  int? medicalAllowance;
  int? eduAllowance;
  int? mobileAllowance;
  int? hra;
  int? da;
  int? pfPer;
  int? esiPer;
  dynamic epfuanNo;
  dynamic esiNo;
  int? casLeave;
  int? sickLeave;
  int? earnedLeave;
  DateTime? resdate;
  dynamic medicalHistory;
  dynamic bloodGroup;
  int? paySlipActive;
  int? opLeaveBalance;
  dynamic salarySplitupId;
  dynamic referedBy;
  dynamic idProofPath;
  dynamic photoPath;
  dynamic addressProofPath;
  int? bankId;
  dynamic branchName;
  dynamic accountNo;
  dynamic accountName;
  dynamic ifsccode;
  dynamic active;
  int? createdBy;
  DateTime? createdDt;
  dynamic designationName;
  dynamic departmentName;
  dynamic companyName;
  dynamic projectName;
  dynamic cityName;
  dynamic bankName;

  Result({
    this.id,
    this.employeeNo,
    this.employeeName,
    this.employeeCode,
    this.designationId,
    this.departmentId,
    this.companyId,
    this.projectId,
    this.dob,
    this.gender,
    this.martialStatus,
    this.dom,
    this.employeeAddress,
    this.cityId,
    this.doj,
    this.panNo,
    this.aadharNo,
    this.email,
    this.contactNo,
    this.officialContactNo,
    this.emergencyContactNo,
    this.grossSalary,
    this.salOpBalAmt,
    this.salOpBalType,
    this.susOpBalAmt,
    this.susOpBalType,
    this.basicPay,
    this.projectAllowance,
    this.phoneAllowance,
    this.medicalAllowance,
    this.eduAllowance,
    this.mobileAllowance,
    this.hra,
    this.da,
    this.pfPer,
    this.esiPer,
    this.epfuanNo,
    this.esiNo,
    this.casLeave,
    this.sickLeave,
    this.earnedLeave,
    this.resdate,
    this.medicalHistory,
    this.bloodGroup,
    this.paySlipActive,
    this.opLeaveBalance,
    this.salarySplitupId,
    this.referedBy,
    this.idProofPath,
    this.photoPath,
    this.addressProofPath,
    this.bankId,
    this.branchName,
    this.accountNo,
    this.accountName,
    this.ifsccode,
    this.active,
    this.createdBy,
    this.createdDt,
    this.designationName,
    this.departmentName,
    this.companyName,
    this.projectName,
    this.cityName,
    this.bankName,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    employeeNo: json["employeeNo"],
    employeeName: json["employeeName"],
    employeeCode: json["employeeCode"],
    designationId: json["designationID"],
    departmentId: json["departmentID"],
    companyId: json["companyID"],
    projectId: json["projectID"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    martialStatus: json["martialStatus"],
    dom: DateTime.parse(json["dom"]),
    employeeAddress: json["employeeAddress"],
    cityId: json["cityID"],
    doj: DateTime.parse(json["doj"]),
    panNo: json["panNo"],
    aadharNo: json["aadharNo"],
    email: json["email"],
    contactNo: json["contactNo"],
    officialContactNo: json["officialContactNo"],
    emergencyContactNo: json["emergencyContactNo"],
    grossSalary: json["grossSalary"],
    salOpBalAmt: json["salOpBalAmt"],
    salOpBalType: json["salOpBalType"],
    susOpBalAmt: json["susOpBalAmt"],
    susOpBalType: json["susOpBalType"],
    basicPay: json["basicPay"],
    projectAllowance: json["projectAllowance"],
    phoneAllowance: json["phoneAllowance"],
    medicalAllowance: json["medicalAllowance"],
    eduAllowance: json["eduAllowance"],
    mobileAllowance: json["mobileAllowance"],
    hra: json["hra"],
    da: json["da"],
    pfPer: json["pfPer"],
    esiPer: json["esiPer"],
    epfuanNo: json["epfuanNo"],
    esiNo: json["esiNo"],
    casLeave: json["casLeave"],
    sickLeave: json["sickLeave"],
    earnedLeave: json["earnedLeave"],
    resdate: DateTime.parse(json["resdate"]),
    medicalHistory: json["medicalHistory"],
    bloodGroup: json["bloodGroup"],
    paySlipActive: json["paySlipActive"],
    opLeaveBalance: json["opLeaveBalance"],
    salarySplitupId: json["salarySplitupID"],
    referedBy: json["referedBy"],
    idProofPath: json["idProofPath"],
    photoPath: json["photoPath"],
    addressProofPath: json["addressProofPath"],
    bankId: json["bankID"],
    branchName: json["branchName"],
    accountNo: json["accountNo"],
    accountName: json["accountName"],
    ifsccode: json["ifsccode"],
    active: json["active"],
    createdBy: json["createdBy"],
    createdDt: DateTime.parse(json["createdDt"]),
    designationName: json["designationName"],
    departmentName: json["departmentName"],
    companyName: json["companyName"],
    projectName: json["projectName"],
    cityName: json["cityName"],
    bankName: json["bankName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employeeNo": employeeNo,
    "employeeName": employeeName,
    "employeeCode": employeeCode,
    "designationID": designationId,
    "departmentID": departmentId,
    "companyID": companyId,
    "projectID": projectId,
    "dob": "${dob?.year.toString().padLeft(4, '0')}-${dob?.month.toString().padLeft(2, '0')}-${dob?.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "martialStatus": martialStatus,
    "dom": "${dom?.year.toString().padLeft(4, '0')}-${dom?.month.toString().padLeft(2, '0')}-${dom?.day.toString().padLeft(2, '0')}",
    "employeeAddress": employeeAddress,
    "cityID": cityId,
    "doj": "${doj?.year.toString().padLeft(4, '0')}-${doj?.month.toString().padLeft(2, '0')}-${doj?.day.toString().padLeft(2, '0')}",
    "panNo": panNo,
    "aadharNo": aadharNo,
    "email": email,
    "contactNo": contactNo,
    "officialContactNo": officialContactNo,
    "emergencyContactNo": emergencyContactNo,
    "grossSalary": grossSalary,
    "salOpBalAmt": salOpBalAmt,
    "salOpBalType": salOpBalType,
    "susOpBalAmt": susOpBalAmt,
    "susOpBalType": susOpBalType,
    "basicPay": basicPay,
    "projectAllowance": projectAllowance,
    "phoneAllowance": phoneAllowance,
    "medicalAllowance": medicalAllowance,
    "eduAllowance": eduAllowance,
    "mobileAllowance": mobileAllowance,
    "hra": hra,
    "da": da,
    "pfPer": pfPer,
    "esiPer": esiPer,
    "epfuanNo": epfuanNo,
    "esiNo": esiNo,
    "casLeave": casLeave,
    "sickLeave": sickLeave,
    "earnedLeave": earnedLeave,
    "resdate": "${resdate?.year.toString().padLeft(4, '0')}-${resdate?.month.toString().padLeft(2, '0')}-${resdate?.day.toString().padLeft(2, '0')}",
    "medicalHistory": medicalHistory,
    "bloodGroup": bloodGroup,
    "paySlipActive": paySlipActive,
    "opLeaveBalance": opLeaveBalance,
    "salarySplitupID": salarySplitupId,
    "referedBy": referedBy,
    "idProofPath": idProofPath,
    "photoPath": photoPath,
    "addressProofPath": addressProofPath,
    "bankID": bankId,
    "branchName": branchName,
    "accountNo": accountNo,
    "accountName": accountName,
    "ifsccode": ifsccode,
    "active": active,
    "createdBy": createdBy,
    "createdDt": createdDt?.toIso8601String(),
    "designationName": designationName,
    "departmentName": departmentName,
    "companyName": companyName,
    "projectName": projectName,
    "cityName": cityName,
    "bankName": bankName,
  };
}
