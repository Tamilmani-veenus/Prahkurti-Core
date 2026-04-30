class Pdfmodel {

  PdfHeader? header;
 List<PdfListModel>? items;
  DurationDate? durationDate;

  Pdfmodel({
     this.header,
     this.items,
     this.durationDate,
  });
}

class PdfListModel {

  String? subContName;
  String? projectName;
  String? appStatus;
  String? WorkType;
  String? mrnReqNo;
  String? mrnReqDate;
  String? siteName;
  String? mrnReqStatus;
  String? inwardNo;
  String? inwardDate;
  String? supplierName;
  String? workNo;
  // String? workDate;

  // double? op;
  // double? billAmt;
  // double? paidAmt;
  // double? balAmt;
  // double? totCr;
  // double? totDr;
  //
  // //-------supplier-------
  //  String? supplierName;
  // //------SubCont---------
  //  String? subcontName;
  // //--------Client---------
  // String? clientName;
  // //---------Labour---------
  // String? labourName;
  //
  // //----Office CashBoof-----------
  // String? vocDate;
  // String? vocDate1;
  // String? descriptions;
  // String? vocType;
  // double? debit;
  // double? credit;
  // String? remarks;
  //
  // //------OverAll Bank--------------
  // String? bankName;
  // double? openingBalance;
  // double? closingBalance;
  //
  // //-----Supplier Ledger-------
  // String? particulars;

   PdfListModel({

     this.subContName,
     this.projectName,
     this.appStatus,
     this.WorkType,
     this.mrnReqNo,
     this.mrnReqDate,
     this.siteName,
     this.mrnReqStatus,
     this.inwardNo,
     this.inwardDate,
     this.supplierName,
     this.workNo,
     // this.workDate,

     // this.op,
     // this.billAmt,
     // this.paidAmt,
     // this.balAmt,
     // this.totCr,
     // this.totDr,
     //
     // this.supplierName,
     // this.subcontName,
     // this.clientName,
     // this.labourName,
     //
     // //--------CashBook Model---------------
     // this.vocDate,
     // this.descriptions,
     // this.vocType,
     // this.debit,
     // this.credit,
     // this.remarks,
     //
     // //------OverAllBank Model-----------
     // this.bankName,
     // this.openingBalance,
     // this.closingBalance,
     //
     // //-------Supplier Ledger-------
     // this.particulars,

  });
}

class PdfHeader {
 String? name;
 String? address;
 String? emailID;

 PdfHeader({
   this.name,
   this.address,
   this.emailID,
  });
}


class DurationDate {
  String? FromDate;
  String? ToDate;

  DurationDate({
    this. FromDate,
    this. ToDate,
  });

}