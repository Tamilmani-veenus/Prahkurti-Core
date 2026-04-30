
import '../../app_theme/app_colors.dart';

import '../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';


class DprPopup extends StatelessWidget {
  const DprPopup({Key? key, required this.list,required this.workNo}) : super(key: key);
  final List list;
  final String workNo;

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
                  color:Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        color: Colors.white10
                    ),
                  ],
                ),

                child: Text(workNo,style: TextStyle(color: Colors.white),)
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
                      color: Colors.white,
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 5, right: 5),
                            width: BaseUtitiles.getWidthtofPercentage(context, 75),
                            child: Text(list[index].workName.toString(),style:TextStyle(color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.justify,
                            ),
                          ),
                          Divider(thickness: 1),
                          Container(
                            margin: EdgeInsets.only(top: 3,left: 4),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    flex:4,
                                    child: Text("Boq Code ",style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex:3,
                                    child: Text(list[index].boqCode.toString(),)),
                                Expanded(
                                    flex:3,
                                    child: Text("Rate",style: TextStyle(fontWeight: FontWeight.bold))),
                                Expanded(
                                    flex:3,
                                    child: Text(list[index].rate.toString(),)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3,left: 4),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:4,
                                  child: Text("Unit",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text(list[index].unit.toString()),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text("BalQty",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text(list[index].balQty.toString()),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3,left: 4,bottom: 3),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex:4,
                                  child: Text("Qty",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text(list[index].qty.toString()),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text("Amount",style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Expanded(
                                  flex:3,
                                  child: Text(list[index].amt.toString()),
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
