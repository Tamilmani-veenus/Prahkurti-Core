
import '../../app_theme/app_colors.dart';
import '../../utilities/baseutitiles.dart';
import 'package:flutter/material.dart';

class inwardPopup extends StatelessWidget {
  const inwardPopup({Key? key, required this.list,required this.inwardNo}) : super(key: key);
  final List list;
  final String inwardNo;

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
                width: BaseUtitiles.getWidthtofPercentage(context, 100),
                height: BaseUtitiles.getheightofPercentage(context, 2),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 3,
                        color:Colors.white10
                    ),
                  ],
                ),

                child: Text(inwardNo,style: TextStyle(color:Colors.white),)
            ),

            Container(
              margin: const EdgeInsets.only(top: 30),
              width: BaseUtitiles.getWidthtofPercentage(context, 80),
              height: BaseUtitiles.getheightofPercentage(context, 60),
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: BaseUtitiles.getheightofPercentage(context, 8),
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 5, left: 5),
                          child: Text(list[index].materialName.toString() + " ( " + list[index].scaleName.toString() + " ) "
                              ,style: TextStyle(color: Theme.of(context).primaryColor)),
                        ),
                      ),

                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Text("PO QTY",style: TextStyle(fontWeight: FontWeight.bold),),
                                    ),
                                  ),
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      child: Text(list[index].poqty.toString()),
                                    ),
                                  ),
                                  Expanded(
                                    flex:3,
                                    child: Container(
                                      child: Text("IWD QTY",style: TextStyle(fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  Expanded(
                                    flex:2,
                                    child: Container(
                                      child: Text(list[index].inwQty.toString()),
                                    ),
                                  ),
                                ],
                              ),
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
