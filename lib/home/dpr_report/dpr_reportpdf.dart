// import 'dart:io';
//
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart';
//
// import '../pdf_generate/pdf_model/pdfmodel.dart';
// import '../pdf_generate/pdf_openfilepath.dart';
//
// class DPR_ReportPdf {
//
//   static Future<File> generate(Pdfmodel pdfmodel, List<PdfListModel> DPR_List) async {
//     final pdf = Document();
//
//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildHeader(pdfmodel),
//         SizedBox(height: 1 * PdfPageFormat.mm),
//         buildTitle(pdfmodel),
//         buildHeading(pdfmodel, DPR_List ),
//         Divider(),
//       ],
//       // footer: (context) => buildFooter(invoice),
//     ));
//     return Pdf_OpenfilePath.saveDocument(name: 'DPR_Report.pdf', pdf: pdf);
//   }
//
//   static Widget buildHeader(Pdfmodel pdfmodel) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       SizedBox(height: 1 * PdfPageFormat.cm),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildAddress(pdfmodel.header!),
//         ],
//       ),
//       SizedBox(height: 1 * PdfPageFormat.cm),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(),
//           buildDurationDateInfo(pdfmodel.durationDate!),
//         ],
//       ),
//     ],
//   );
//
//   static Widget buildAddress(PdfHeader supplier) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Text(supplier.name!, style: TextStyle(fontWeight: FontWeight.bold)),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       Text(supplier.emailID!),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       Text(supplier.address!)
//     ],
//   );
//
//   static Widget buildDurationDateInfo(DurationDate date) => Column(
//     crossAxisAlignment: CrossAxisAlignment.end,
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       Text(date.FromDate!, style: TextStyle(fontWeight: FontWeight.bold)),
//       SizedBox(height: 1 * PdfPageFormat.mm),
//       Text(date.ToDate!, style: TextStyle(fontWeight: FontWeight.bold)),
//     ],
//   );
//
//   static Widget buildTitle(Pdfmodel pdfmodel) => Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         'DPR Report',
//         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//       ),
//       SizedBox(height: 0.8 * PdfPageFormat.cm),
//     ],
//   );
//
//   static Widget buildHeading(Pdfmodel pdfmodel, List<PdfListModel> DPR_List) {
//     final headers = [
//       "Work No",
//       // "Date",
//       "Project Name",
//       "Site Name",
//       "Subcontractor Name",
//     ];
//
//     final data = pdfmodel.items!.map((item) {
//       return [
//         item.workNo,
//         // item.workDate,
//         item.projectName,
//         item.siteName,
//         item.subContName,
//       ];
//     }).toList();
//
//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//      defaultColumnWidth: IntrinsicColumnWidth(),
//      tableWidth: TableWidth.max,
//      //  defaultColumnWidth = const IntrinsicColumnWidth(),
//      // tableWidth = TableWidth.max,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         // 4: Alignment.centerRight,
//       },
//     );
//   }
//
// }