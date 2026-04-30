
import '../../app_theme/app_colors.dart';
import '../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';
import '../../utilities/requestconstant.dart';


class AttendancePopup extends StatelessWidget {
  const AttendancePopup({Key? key, required this.list,required this.attendNo}) : super(key: key);
  final List list;
  final String attendNo;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Setmybackground,
      contentPadding: const EdgeInsets.all(5.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),

      ),
      content: Stack(
          children: <Widget>[
            Container(
              height: BaseUtitiles.getheightofPercentage(context,3),
              alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  boxShadow:  const [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        color: Colors.white10,
                    ),
                  ],
                ),
                child: Text(attendNo,style: const TextStyle(color: Colors.white))
            ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: BaseUtitiles.getWidthtofPercentage(context, 80),
          height: BaseUtitiles.getheightofPercentage(context, 60),
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: const EdgeInsets.only(top: 5,bottom: 5),
                child: Card(
                  elevation: 3,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(list[index].categoryName.toString(),style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
                            Text(RequestConstant.CURRENCY_SYMBOL+list[index].Wages.toString(),style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3,  left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: const Text("Nos",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].nos.toString(),),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Extras",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].Extra.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                        margin: const EdgeInsets.only(top: 3,  left: 5, right: 5, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Mrng OT Hrs",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].MOROTHrs.toString()),
                              ),
                            ),

                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Mrng OT Amt",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].MOROTAmt.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),


                      Container(
                        margin: const EdgeInsets.only(top: 3,  left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Eve OT Hrs",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].EVEOTHrs.toString()),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Eve OT Amt",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: Text(list[index].EVEOTAmt.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 3,  left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("ExtraAmt",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3,bottom: 3),
                                child: Text(list[index].ExtraAmt.toString()),
                              ),
                            ),

                            Expanded(
                              flex:3,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3),
                                child: const Text("Net Amt",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                              flex:2,
                              child: Container(
                                margin: const EdgeInsets.only(top: 3,bottom: 3),
                                child: Text(list[index].TotAmt.toString()),
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
