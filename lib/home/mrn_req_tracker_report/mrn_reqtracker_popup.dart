import '../../app_theme/app_colors.dart';
import 'package:prahkurticore/models/mrnreq_tracker_reportmodel.dart';
import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';

class mrnReqTrackerPopup extends StatelessWidget {
   mrnReqTrackerPopup(
      {Key? key, required this.list, required this.approvalLevelList})
      : super(key: key);
  final ReqTrackResult list;
  final List approvalLevelList;

  @override
  Widget build(BuildContext context) {
    final trackerSteps = [
      {
        "title": "MRN Made",
        "date": list.mrnDate,
        "time": list.mrnTime,
        "by": list.mrnPreparedBy,
      },
      if (approvalLevelList.length > 0 &&approvalLevelList[0]["isVerification"] == true) {
        "title": "MRN Verified",
        "date": list.verifyDate,
        "time": list.verifyTime,
        "by": list.verifyBy,
      },
      if (approvalLevelList.length > 0  &&approvalLevelList[0]["isPreApproval"] == true){
        "title": "MRN Pre-Approved",
        "date": list.preAppovedDate,
        "time": list.preApprovedTime,
        "by": list.preApprovedBy,
      },
      if (approvalLevelList.length > 0  &&approvalLevelList[0]["isApproval"] == true){
        "title": "MRN Final Approved",
        "date": list.approveDate,
        "time": list.approvedTime,
        "by": list.approvedBy,
      },
      {
        "title": "PO Made",
        "date": list.poDate,
        "time": list.poTime,
        "by": list.poBy,
      },
      if (approvalLevelList.length > 1 &&approvalLevelList[1]["isVerification"] == true){
        "title": "PO Verified",
        "date": list.poVerifyDate,
        "time": list.poVerifyTime,
        "by": list.poVerifyBy,
      },
      if (approvalLevelList.length > 1 &&approvalLevelList[1]["isApproval"] == true){
        "title": "PO Approved",
        "date": list.poAppDate,
        "time": list.poApprovedTime,
        "by": list.poAppBy,
      },
      {
        "title": "Inward",
        "date": list.inwardDate,
        "time": list.grnCreatedTime,
        "by": list.inwardBy,
      },
    ];


    return AlertDialog(
      backgroundColor: Setmybackground,
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack(children: <Widget>[
        Container(
            height: BaseUtitiles.getheightofPercentage(context, 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 10), blurRadius: 3, color: Colors.white),
              ],
            ),
            child: Text("MRN - Request Tracker",
                style: TextStyle(color: Colors.white))),

        Container(
          margin: const EdgeInsets.only(top: 30),
          width: BaseUtitiles.getWidthtofPercentage(context, 80),
          height: BaseUtitiles.getheightofPercentage(context, 58), // Fixed height
          child: Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Important
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            list.mrnNo.toString(),
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: trackerSteps.asMap().entries.map((entry) {
                            final index = entry.key;
                            final step = entry.value;
                            final isLast = index == trackerSteps.length - 1;
                            final isCancelled = (step["title"]=="PO Made" || step["title"]=="Inward" || list.mrnVerifyStatus!="Y" || list.mrnPreApproveStatus!="Y" || list.mrnApproveStatus!="Y" || list.poVerifyStatus!="Y" || list.poApproveStatus!="Y") &&
                                step["date"] == "-" &&
                                    (step["time"] == "-" || step["time"] == "") &&
                                    (step["by"] == "-" || step["by"] == "");

                            return IntrinsicHeight(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Timeline
                                    Column(
                                      children: [
                                         Icon(
                                          isCancelled ? Icons.cancel : Icons.check_circle,
                                          color: isCancelled ? Colors.red : Colors.green,
                                          size: 22,
                                        ),
                                        if (!isLast)
                                          Container(
                                            width: 2,
                                            height: 45,
                                            color: Colors.grey.shade400,
                                          ),
                                      ],
                                    ),

                                    const SizedBox(width: 12),

                                    // Content
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              step["title"]!,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Expanded(flex: 1,
                                                  child: Text(
                                                    "${step["date"]?? "-"}",
                                                    style: const TextStyle(color: Colors.black54,fontSize: 13),
                                                  ),
                                                ),
                                                Expanded(flex: 1,
                                                  child: Text(
                                                    "${step["time"] ?? "-"}",
                                                    style: const TextStyle(color: Colors.black54,fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            if (step["by"] != null &&
                                                step["by"].toString().isNotEmpty &&
                                                step["by"] != "-")
                                              Text(
                                                "By : ${step["by"]}",
                                                style: const TextStyle(color: Colors.black54,fontSize: 13),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )      ]),
    );
  }
}
