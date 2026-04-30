
import '../../app_theme/app_colors.dart';

import '../../../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';


class mrnPopup extends StatelessWidget {
  const mrnPopup({Key? key, required this.list,required this.MrnReqNo}) : super(key: key);
  final List list;
  final String MrnReqNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Setmybackground,
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack(
          children: <Widget>[
            Container(
                height: BaseUtitiles.getheightofPercentage(context, 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        color:  Colors.white
                    ),
                  ],
                ),

                child: Text(MrnReqNo,style: TextStyle(color: Colors.white))
            ),

            Container(
              margin: const EdgeInsets.only(top: 30),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 60),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 5,bottom: 5),
                    child: Card(
                      elevation: 3,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.only(top: 5, left: 5),
                            child: Container(
                                width: BaseUtitiles.getWidthtofPercentage(context,55),
                                child: Text(list[index].material.toString()+" ("+list[index].scale.toString()+")",style: TextStyle(color: Theme.of(context).primaryColor),)),
                          ),

                          // Container(
                          //
                          //
                          //
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: <Widget>[
                          //       Container(
                          //         child: Text("Name",style: TextStyle(color: Colors.white)),
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),

                          Container(
                            margin: EdgeInsets.only(top: 5,left: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:3,
                                  child: Container(
                                    child: Text("Req Qty: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Container(
                                    child: Text(list[index].reqQty.toString()),
                                  ),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Container(
                                    child: Text("AppQty: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child: Container(
                                    child: Text(list[index].appQty.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top:5, left: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:3,
                                  child: Container(
                                    child: Text("Status: ",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  flex:7,
                                  child: Container(
                                    child: Text(list[index].appType.toString()),
                                  ),
                                ),


                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5,left: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:2,
                                  child: Container(
                                    child: Text("Remarks",style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Container(
                                    child: Text(list[index].remarks.toString()),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
    );
  }
}
