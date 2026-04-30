import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/mrn_preapproval_controller.dart';
import '../../../constants/ui_constant/icons_const.dart';
import '../../../utilities/baseutitiles.dart';

class Mrnpreapr_Stockmaterialwise_Popup extends StatefulWidget {
  const Mrnpreapr_Stockmaterialwise_Popup({Key? key, required this.MaterialName, required this.MaterialId, required this.Scale}) : super(key: key);
final String MaterialName;
final int MaterialId;
final String Scale;

  @override
  State<Mrnpreapr_Stockmaterialwise_Popup> createState() => _Mrnpreapr_Stockmaterialwise_PopupState();
}

class _Mrnpreapr_Stockmaterialwise_PopupState extends State<Mrnpreapr_Stockmaterialwise_Popup> {

  MrnPreApprovalController mrnPreApprovalController = Get.put(MrnPreApprovalController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              // height: MediaQuery.of(context).size.height*6/100,
              width: MediaQuery.of(context).size.width*25/100,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(
                      thickness: 1.5,
                      color: Colors.red,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text("Material List",
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                    ),
                    Divider(
                      thickness: 1.5,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),


            Container(
              width: MediaQuery.of(context).size.width*80/100,
              alignment: Alignment.center,
              child: Text(widget.MaterialName.toString() + "  (" + widget.Scale.toString() + ") ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)
              ),
            ),

            Container(
              margin: const EdgeInsets.only(top: 5),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 60),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: mrnPreApprovalController.StockListMaterialWise.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(left: 3, right: 3),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 5, bottom: 5, top:5 ),
                        child: Column(
                          children: [

                            SizedBox(height: 5),

                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("Project",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text( mrnPreApprovalController.StockListMaterialWise[index].projectName.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),

                            SizedBox(height: 5),

                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text("Site",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text( mrnPreApprovalController.StockListMaterialWise[index].siteName.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Divider(color: Theme.of(context).primaryColor),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ConstIcons.list_date,
                                Expanded(
                                    flex: 4,
                                    child: Text(
                                        mrnPreApprovalController.StockListMaterialWise[index].lastDate.toString(),
                                    ),
                                ),
                                const Expanded(
                                  flex: 3,
                                  child: Text("StockQty:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Text(mrnPreApprovalController.StockListMaterialWise[index].stockQty.toString())),
                              ],
                            ),

                            const SizedBox(height: 5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  flex: 3,
                                  child: Text("IdelDays:",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                    flex: 6,
                                    child: Text(mrnPreApprovalController.StockListMaterialWise[index].idleDays.toString())),
                                Expanded(
                                    flex: 4,
                                    child: Text("")),
                              ],
                            ),

                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
            ),

          ],
        ),
      ),
    );
  }
}
