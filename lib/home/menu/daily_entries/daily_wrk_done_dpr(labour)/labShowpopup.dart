import '../../../../controller/dailywrk_done_dprlabour_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LabourShowPopup extends StatefulWidget {
   LabourShowPopup({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<LabourShowPopup> createState() => _LabourShowPopupState();
}

class _LabourShowPopupState extends State<LabourShowPopup> {

  DailyWrkDone_DPRLabour_Controller dailyWrkDone_DPRLabour_Controller=Get.put(DailyWrkDone_DPRLabour_Controller());


  @override
  void initState() {
    dailyWrkDone_DPRLabour_Controller.nosAndothrsZerovalueset(widget.list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Stack( children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: BaseUtitiles.getheightofPercentage(context, 63),
            child: Column(
              children: <Widget>[
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 100),
                  height: BaseUtitiles.getheightofPercentage(context, 3),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 9,
                          child: Center(
                              child: Text(
                                RequestConstant.CATEGORY,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ))),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height:
                          BaseUtitiles.getheightofPercentage(context, 3),
                          width: BaseUtitiles.getWidthtofPercentage(context, 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Image.asset('assets/cancle.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 9),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                        color: Colors.black, // Set border color
                        width: 3.0), // Set border width
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Text(
                            RequestConstant.WAGES,
                            style: TextStyle(color: Colors.white),
                          )),
                      Expanded(
                          flex: 4,
                          child: Text(RequestConstant.HEAD_NOS,
                              style: TextStyle(color: Colors.white))),
                      Expanded(
                          flex: 2,
                          child: Text(RequestConstant.HEAD_OTHRS,
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                ),
                SizedBox(
                  height: BaseUtitiles.getheightofPercentage(context, 1),
                ),
                Container(
                  width: BaseUtitiles.getWidthtofPercentage(context, 100),
                  height: BaseUtitiles.getheightofPercentage(context, 40),
                  child: ListView.builder(
                    itemCount: widget.list.length,
                    itemBuilder: (BuildContext context, int index) {
                      dailyWrkDone_DPRLabour_Controller.textControllersInitiate();
                      return Column(children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        widget.list[index].categoryName
                                            .toString(),
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      SizedBox(
                                        height:
                                        BaseUtitiles.getheightofPercentage(
                                            context, 1),
                                      ),
                                      Text(RequestConstant.CURRENCY_SYMBOL +
                                          widget.list[index].wages.toString()),
                                    ],
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 11),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    child: TextField(
                                      controller: dailyWrkDone_DPRLabour_Controller.ShowNosControllers[index],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 11),
                                    height: BaseUtitiles.getheightofPercentage(
                                        context, 4),
                                    child: TextField(
                                      controller: dailyWrkDone_DPRLabour_Controller
                                          .ShowOtHrsController[index],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.red,
                        ),
                      ]);
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    //background color of button
                    side: BorderSide(width: 3, color: Colors.brown),
                    //border width and color
                    elevation: 3,
                    //elevation of button
                    shape: RoundedRectangleBorder(
                      //to set border radius to button
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: ()async {
                    await dailyWrkDone_DPRLabour_Controller.saveLabTableDatas(context);
                    dailyWrkDone_DPRLabour_Controller.getLabourTablesDatas();
                  },
                  child: Text(RequestConstant.OK),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
