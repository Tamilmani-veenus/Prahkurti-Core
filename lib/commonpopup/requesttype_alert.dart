import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/mrn_request_indent_controller.dart';
import '../controller/mrnrequest_preIndent_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';

class RequestType_Alert extends StatefulWidget {
  const RequestType_Alert({Key? key}) : super(key: key);

  @override
  State<RequestType_Alert> createState() => _RequestType_AlertState();
}

class _RequestType_AlertState extends State<RequestType_Alert> {

  MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());


  final list=["General Items","Asset Materials"];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: BaseUtitiles.getheightofPercentage(context, 4),
                color: Theme.of(context).primaryColor,
                child: const Center(child: Text("Request Type",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 20),
                width: BaseUtitiles.getWidthtofPercentage(context, 80),
                height: BaseUtitiles.getheightofPercentage(context,12),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: ()  async {
                          await mrn_request_controller.delete_MaterialIntent_itemlist_Table();
                          mrn_request_controller.Material_itemview_GetDbList.value=[];

                          await mrnRequest_PreIndent_Controller.delete_MaterialIntent_itemlist_Table();
                          mrnRequest_PreIndent_Controller.Material_itemview_GetDbList.value = [];
                          Navigator.pop(context);

                          setState(() {
                            if(index==0){
                              mrn_request_controller.ReqTypeController.text="General Items";
                              mrn_request_controller.ReqType.value = "PO";
                              mrnRequest_PreIndent_Controller.ReqTypeController.text = "General Items";
                              mrnRequest_PreIndent_Controller.ReqType.value = "PO";
                            }
                            else{
                              mrn_request_controller.ReqTypeController.text="Asset Materials";
                              mrn_request_controller.ReqType.value = "CP";
                              mrnRequest_PreIndent_Controller.ReqTypeController.text = "Asset Materials";
                              mrnRequest_PreIndent_Controller.ReqType.value = "CP";
                            }
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width: BaseUtitiles.getWidthtofPercentage(context, 60),
                                    child: Text(list[index].toString(), textAlign: TextAlign.center,style: const TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(color: Theme.of(context).primaryColorLight,)
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}