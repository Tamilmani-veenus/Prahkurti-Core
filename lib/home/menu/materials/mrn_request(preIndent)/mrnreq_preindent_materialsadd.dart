import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_theme/app_colors.dart';
import '../../../../controller/mrnrequest_preIndent_controller.dart';
import '../../../../controller/projectcontroller.dart';
import '../../../../controller/sitecontroller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';

class MRNRequest_PreIndent_MAterialsAdd extends StatefulWidget {
  const MRNRequest_PreIndent_MAterialsAdd({Key? key,required this.list}) : super(key: key);
  final List list;

  @override
  State<MRNRequest_PreIndent_MAterialsAdd> createState() => _MRNRequest_PreIndent_MAterialsAddState();
}

class _MRNRequest_PreIndent_MAterialsAddState extends State<MRNRequest_PreIndent_MAterialsAdd> {

  TextEditingController editingController = TextEditingController();
  final ProjectController projectController = Get.put(ProjectController());
  final SiteController siteController = Get.put(SiteController());
  MRNRequest_PreIndent_Controller mrnRequest_PreIndent_Controller = Get.put(MRNRequest_PreIndent_Controller());

  String datas = "";

  @override
  void initState() {
    // mrn_request_controller.list.value.clear();
    int i = 0;
    mrnRequest_PreIndent_Controller.getmaterialvalue.forEach((element) {
      mrnRequest_PreIndent_Controller.Material_itemlist_textControllersInitiate();
      mrnRequest_PreIndent_Controller.Itemlist_qtyControllers[i].text = "0.0";
      i++;
    });
    mrnRequest_PreIndent_Controller.isChecked = List<bool>.filled(widget.list.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            mrnRequest_PreIndent_Controller.addMaterialControl=0;
            await mrnRequest_PreIndent_Controller.materiallist_Save_DB(context);
            await mrnRequest_PreIndent_Controller.getMaterialTablesDatas();
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
                            mrnRequest_PreIndent_Controller.list.value = BaseUtitiles.materialNamePopupAlert(value, mrnRequest_PreIndent_Controller.getmaterialvalue);
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
      return Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        height: BaseUtitiles.getheightofPercentage(context, 100),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.only(bottom: BaseUtitiles.getheightofPercentage(context, 20)),
                  physics: BouncingScrollPhysics(),
                  itemCount:  mrnRequest_PreIndent_Controller.getmaterialvalue.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    mrnRequest_PreIndent_Controller.Material_itemlist_textControllersInitiate();
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
                                        mrnRequest_PreIndent_Controller.setCheck(
                                            mrnRequest_PreIndent_Controller.getmaterialvalue[index].materialId, value!);
                                        mrnRequest_PreIndent_Controller.getmaterialvalue[index].isCheck = value;
                                      });
                                    },
                                    value: mrnRequest_PreIndent_Controller.getmaterialvalue[index].isCheck),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 3),
                                      width: BaseUtitiles.getWidthtofPercentage(
                                          context, 85),
                                      child: Text(
                                        mrnRequest_PreIndent_Controller.getmaterialvalue[index].material.toString(),
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
                                                text: "( " + "Balqty: " + mrnRequest_PreIndent_Controller.getmaterialvalue[index].balqty.toString() + " ) ",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: RequestConstant.ALERT_Font_SIZE,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              TextSpan(
                                                text:  mrnRequest_PreIndent_Controller.getmaterialvalue[index].scale.toString(),
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
      );
    }
    else if (mrnRequest_PreIndent_Controller.list.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        height: BaseUtitiles.getheightofPercentage(context, 100),
        child: ListView.builder(
            itemCount: mrnRequest_PreIndent_Controller.list.value.length,
            itemBuilder: (BuildContext context, int index) {
              mrnRequest_PreIndent_Controller.Material_itemlist_textControllersInitiate();
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
                                  color: Theme.of(context).primaryColor,
                                  // color: Colors.white
                                ),
                              ),
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  mrnRequest_PreIndent_Controller.serachsetCheck(mrnRequest_PreIndent_Controller.list.value[index].materialId, value!);
                                  mrnRequest_PreIndent_Controller.list.value[index].isCheck = value;
                                });
                              },
                              value: mrnRequest_PreIndent_Controller
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
                                  mrnRequest_PreIndent_Controller.list[index].material.toString(),
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
                                          text: "( " + "Balqty: " + mrnRequest_PreIndent_Controller.list[index].balqty.toString() + " ) ",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: RequestConstant.ALERT_Font_SIZE,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextSpan(
                                          text:  mrnRequest_PreIndent_Controller.list[index].scale.toString(),
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
      );
    } else {
      return Container();
    }
  }
}
