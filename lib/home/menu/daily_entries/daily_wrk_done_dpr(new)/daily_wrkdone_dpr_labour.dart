import '../../../../controller/dailywrk_done_dpr_controller.dart';
import '../../../../controller/dailywrk_done_dprnew_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'daily_wrkdone_dpr_material.dart';

class DailyWork_done_DPR_Labour extends StatefulWidget {
  const DailyWork_done_DPR_Labour({Key? key}) : super(key: key);

  @override
  State<DailyWork_done_DPR_Labour> createState() => _DailyWork_done_DPR_LabourState();
}

class _DailyWork_done_DPR_LabourState extends State<DailyWork_done_DPR_Labour> {
  DailyWrkDone_DPR_Controller dailyWrkDone_DPR_Controller=Get.put(DailyWrkDone_DPR_Controller());
  DailyWrkDone_DPRNEW_Controller dailyWrkDone_DPRNEW_Controller=Get.put(DailyWrkDone_DPRNEW_Controller());

  @override
  void initState() {
    dailyWrkDone_DPRNEW_Controller.entrycheck = 1;
    dailyWrkDone_DPRNEW_Controller.nosAndothrsZerovalueset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        bottomSheet: SizedBox(
          height: kToolbarHeight,
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                const Text("Total Amount ",style: TextStyle(color: Colors.black87,fontSize: 14),),
                Text(RequestConstant.CURRENCY_SYMBOL+dailyWrkDone_DPRNEW_Controller.totalNetAmnt.toString(),style: TextStyle(color: dailyWrkDone_DPRNEW_Controller.totalNetAmnt > 0 ? Colors.green.shade800 : Colors.red.shade800,fontSize: 17 )),
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DailyWork_done_DPR_Material()));
                  },
                  child: const Row(
                    children: [
                      Text("NEXT",style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold),),
                      Icon(Icons.navigate_next_sharp,color: Colors.grey )
                    ],
                  ),
                )

              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "DPR - NEW (Labour)",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )),

                  ],
                ),
              ),
              const SizedBox(height: 5),
              ListDetails(),
              // Divider(thickness: 1,color: Colors.grey)
            ],
          ),


        ),
      ),
    );
  }

  Widget ListDetails() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 87/100,
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 86/100,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList.length,
              itemBuilder: (BuildContext context, int index) {
                dailyWrkDone_DPRNEW_Controller.textControllersInitiate();
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  margin: const EdgeInsets.all(3),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 25,
                              child: Text(
                                dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList[index].catName,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                RequestConstant.CURRENCY_SYMBOL + dailyWrkDone_DPRNEW_Controller.dprNew_LabourReadList[index].wages.toString(),
                                style: TextStyle(color: Colors.green.shade800,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            Visibility(
                              visible: false,
                              child: Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height:
                                  BaseUtitiles.getheightofPercentage(context, 2),
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 8),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            AlertDialog(
                                              title: const Text(
                                                  RequestConstant.DO_YOU_WANT_DELETE),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    child: const Text(RequestConstant.NO),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    }
                                                ),
                                                ElevatedButton(
                                                    child: const Text(RequestConstant.YES),
                                                    onPressed: () {
                                                      // dailyEntriesController.deleteParticularList(dailyWrkDone_DPRNEW_Controller.dprNew_LabourList[index]);
                                                      // dailyEntriesController. getDetTablesDatas();
                                                      // dailyEntriesController.readListdata.remove(dailyWrkDone_DPRNEW_Controller.dprNew_LabourList[index]);
                                                      Navigator.pop(context);
                                                    }
                                                ),
                                              ],
                                            ),
                                      );
                                    },
                                    child: Image.asset('assets/cancle.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Text(
                                RequestConstant.NOS,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        dailyWrkDone_DPRNEW_Controller.NosControllers[index].text = "";
                                        setState(() {
                                          dailyWrkDone_DPRNEW_Controller.clickEdit();
                                          dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                                        });
                                      },
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.black),
                                      controller: dailyWrkDone_DPRNEW_Controller.NosControllers[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyWrkDone_DPRNEW_Controller.clickEdit();
                                          dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                                        });
                                      }
                                  ),
                                )),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                RequestConstant.OTHRS,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(context, 4),
                                  child: TextFormField(
                                      onTap: () {
                                        dailyWrkDone_DPRNEW_Controller.OtHrsController[index].text = "";
                                        setState(() {
                                          dailyWrkDone_DPRNEW_Controller.clickEdit();
                                          dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                                        });
                                      },
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      controller: dailyWrkDone_DPRNEW_Controller.OtHrsController[index],
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                            borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          dailyWrkDone_DPRNEW_Controller.clickEdit();
                                          dailyWrkDone_DPRNEW_Controller.getLabourTablesDatas();
                                        });
                                      }

                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Text(
                                RequestConstant.OTAMT,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 11),
                                  height: BaseUtitiles.getheightofPercentage(context, 4),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    readOnly: true,
                                    controller: dailyWrkDone_DPRNEW_Controller.OtAmtController[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),
                                )),
                            const Expanded(
                              flex: 2,
                              child: Text(
                                RequestConstant.NETAMT,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  height: BaseUtitiles.getheightofPercentage(context, 4),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    readOnly: true,
                                    controller: dailyWrkDone_DPRNEW_Controller.NetAmtController[index],
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                        child: Row(
                          children: <Widget>[
                            const Expanded(
                              flex: 3,
                              child: Text(
                                RequestConstant.REMARKSES,
                                style: TextStyle(
                                    color: Colors.black),
                              ),
                            ),
                            Expanded(
                                flex: 11,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0),
                                  height: BaseUtitiles
                                      .getheightofPercentage(
                                      context, 4),
                                  child: TextFormField(
                                    onTap: (){
                                      dailyWrkDone_DPRNEW_Controller.RemarksController[index].text = "";
                                    },
                                    style: const TextStyle(color: Colors.black),
                                    textAlign: TextAlign.center,
                                    controller: dailyWrkDone_DPRNEW_Controller.RemarksController[index],
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },

            ),
          ),
        ],
      ),
    );
  }

}