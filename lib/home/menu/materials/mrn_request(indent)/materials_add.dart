import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app_theme/app_colors.dart';
import '../../../../../controller/mrn_request_indent_controller.dart';
import '../../../../../controller/projectcontroller.dart';
import '../../../../../controller/sitecontroller.dart';
import '../../../../../utilities/baseutitiles.dart';
import '../../../../../utilities/requestconstant.dart';

class Materials_Add extends StatefulWidget {
  const Materials_Add({Key? key, required this.list}) : super(key: key);
  final List list;

  @override
  State<Materials_Add> createState() => _Materials_AddState();
}

class _Materials_AddState extends State<Materials_Add> {
  TextEditingController editingController = TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());
  final SiteController siteController = Get.put(SiteController());
  final MRN_Request_Controller mrn_request_controller = Get.put(MRN_Request_Controller());
  String datas = "";


  @override
  void initState() {
    mrn_request_controller.list.value=[];
    int i = 0;
    mrn_request_controller.getmaterialvalue.forEach((element) {
      mrn_request_controller.Material_itemlist_textControllersInitiate();
      mrn_request_controller.Itemlist_qtyControllers[i].text = "0.1";
      i++;
    });
    mrn_request_controller.isChecked = List<bool>.filled(widget.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await mrn_request_controller.materiallist_Save_DB(context);
            await mrn_request_controller.getMaterialTablesDatas();
          },
          label: Text(
            "Done",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: RequestConstant.Lable_Font_SIZE,
            ),
          ),
          icon: Icon(
            Icons.library_add_check_outlined,
            color: Colors.white,
            size: RequestConstant.Heading_Font_SIZE,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 40),
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Materials",
                      style: TextStyle(
                          fontSize: RequestConstant.Heading_Font_SIZE,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: BaseUtitiles.getheightofPercentage(context, 5),
                      width: BaseUtitiles.getWidthtofPercentage(context, 50),
                      margin: EdgeInsets.only(left: 15),
                      child: TextField(
                        cursorColor: Theme.of(context).primaryColor,
                        controller: editingController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          hintText: "Search..",
                          hintStyle: TextStyle(color: Colors.black),
                          isDense: true,
                          fillColor: Colors.white,
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          // if (onSearch != null) onSearch!(searchcontroller.text);
                        },
                        textInputAction: TextInputAction.search,
                        onChanged: (value) {
                          setState(() {
                            mrn_request_controller.list.value = BaseUtitiles.materialNamePopupAlert(value, mrn_request_controller.getmaterialvalue);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              listDetails(),
            ],
          ),
        ));
  }

  Widget listDetails() {
    if (editingController.text.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 50),
                    physics: BouncingScrollPhysics(),
                    itemCount:  mrn_request_controller.getmaterialvalue.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      mrn_request_controller.Material_itemlist_textControllersInitiate();
                      return Container(
                        color: Setmybackground,
                        margin: EdgeInsets.only(bottom: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(2.0),
                                      ),
                                      side: MaterialStateBorderSide.resolveWith(
                                            (states) => BorderSide(
                                          width: 1.0,
                                          // color: Colors.white
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Theme.of(context).primaryColor,
                                      onChanged: (value) {
                                        setState(() {
                                          mrn_request_controller.setCheck(
                                              mrn_request_controller.getmaterialvalue[index].materialId, value!);
                                          mrn_request_controller.getmaterialvalue[index].isCheck = value;
                                        });
                                      },
                                      value: mrn_request_controller.getmaterialvalue[index].isCheck),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 3),
                                        width: BaseUtitiles.getWidthtofPercentage(
                                            context, 85),
                                        child: Text(
                                          mrn_request_controller.getmaterialvalue[index].material.toString(),
                                          style: TextStyle(
                                              fontSize:
                                              RequestConstant.ALERT_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    Container(
                                      margin: EdgeInsets.only(top: 5, left: 3),
                                      child:  Row(
                                        children: <Widget>[
                                          Obx((){
                                            return mrn_request_controller.activeType.value ?
                                             RichText(
                                              text: TextSpan(
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize:
                                                    RequestConstant.Lable_Font_SIZE),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text: "( " + "Balqty: " + mrn_request_controller.getmaterialvalue[index].balqty.toString() + " ) ",
                                                    style: TextStyle(
                                                        color: Theme.of(context).primaryColor,
                                                        fontSize: RequestConstant.App_Font_SIZE,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              ),): SizedBox();}
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize:
                                                  RequestConstant.Lable_Font_SIZE),
                                              children: <TextSpan>[
                                                TextSpan(
                                                  text:  mrn_request_controller.getmaterialvalue[index].scale.toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context).primaryColor,
                                                      fontSize: RequestConstant.App_Font_SIZE,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
      );
    }
    else if (mrn_request_controller.list.isNotEmpty) {
      return  Padding(
        padding: const EdgeInsets.only(top: 10.0,bottom: 32.0),
        child: SizedBox(
          height: BaseUtitiles.getheightofPercentage(context,90),
          child: ListView.builder(
              itemCount: mrn_request_controller.list.value.length,
              itemBuilder: (BuildContext context, int index) {
                mrn_request_controller.Material_itemlist_textControllersInitiate();
                return Container(
                  color: Setmybackground,
                  margin: const EdgeInsets.only(bottom: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.0),
                                ),
                                side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                    width: 1.0,
                                    color: Theme.of(context).primaryColor,
                                    // color: Colors.white
                                  ),
                                ),
                                checkColor: Colors.white,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    mrn_request_controller.serachsetCheck(mrn_request_controller.list.value[index].materialId, value!);
                                    mrn_request_controller.list.value[index].isCheck = value;
                                  });
                                },
                                value: mrn_request_controller
                                    .list.value[index].isCheck),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 3),
                                  width: BaseUtitiles.getWidthtofPercentage(
                                      context, 85),
                                  child: Text(
                                    mrn_request_controller.list[index].material.toString(),
                                    style: TextStyle(
                                        fontSize:
                                        RequestConstant.ALERT_Font_SIZE,
                                        fontWeight: FontWeight.bold),
                                  )),

                              Container(
                                margin: EdgeInsets.only(top: 5, left: 3),
                                child:  Row(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                            RequestConstant.Lable_Font_SIZE),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:  mrn_request_controller.list[index].scale.toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontSize: RequestConstant.App_Font_SIZE,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
        ),
      );
    } else {
      return Container();
    }
  }
}
