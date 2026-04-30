
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/material_controller.dart';
import '../utilities/baseutitiles.dart';
import '../utilities/requestconstant.dart';
class MaterialAddQtyAlert extends StatefulWidget {
  const MaterialAddQtyAlert({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<MaterialAddQtyAlert> createState() => _MaterialAddQtyState();
}

class _MaterialAddQtyState extends State<MaterialAddQtyAlert> {

  MaterialController materialController=Get.put(MaterialController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: BaseUtitiles.getWidthtofPercentage(context, 100),
                color: Colors.indigo.shade800,
                child: Center(child: Text("Scale Lists",style: TextStyle(color: Colors.white),)),
              ),

              Container(
                margin: const EdgeInsets.only(top: 10),
                // width: BaseUtitiles.getWidthtofPercentage(context, 80),
                 height: BaseUtitiles.getheightofPercentage(context, 55),
                child: ListView.builder(
                    itemCount: widget.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: (){
                          materialController.MaterialQty.text=widget.list[index].scale.toString();
                          Navigator.pop(context);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    width:
                                    BaseUtitiles.getWidthtofPercentage(
                                        context, 60),
                                    child: Text(widget.list[index].scale
                                        .toString(), textAlign: TextAlign.center,style: TextStyle(fontSize: RequestConstant.ALERT_Font_SIZE,fontWeight: FontWeight.bold),)),
                                Divider(
                                  color: Theme.of(context).primaryColorLight,
                                )
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
