import '../../../../app_theme/app_colors.dart';
import '../../../../constants/ui_constant/icons_const.dart';
import '../../../../controller/boqrevised_controller.dart';
import '../../../../controller/comman_controller.dart';
import '../../../../utilities/baseutitiles.dart';
import '../../../../utilities/requestconstant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'boq_revised_entry.dart';

class Boq_Revised_EntryList extends StatefulWidget {
  const Boq_Revised_EntryList({Key? key}) : super(key: key);

  @override
  State<Boq_Revised_EntryList> createState() => _Boq_Revised_EntryListState();
}

class _Boq_Revised_EntryListState extends State<Boq_Revised_EntryList> {
  TextEditingController editingController = TextEditingController();

  Boq_Revised_Controller boq_revised_controller = Get.put(Boq_Revised_Controller());
  CommanController commanController = Get.put(CommanController());

  @override
  void initState() {
    if (boq_revised_controller.itemCheck == 2) {
      boq_revised_controller.itemCheck = 0;
    } else if (boq_revised_controller.itemCheck == 0) {
    } else {
      boq_revised_controller.itemCheck = 1;
    }
    setState(() {
      boq_revised_controller.main_entryList.value.clear();
      boq_revised_controller.Boq_entryList.value.clear();
    });

    DateTime currentDate = DateTime.now();
    DateTime lastDayOfMonth = DateTime(currentDate.year, currentDate.month - 1, 0);
    boq_revised_controller.entryList_frdateController.text =
        lastDayOfMonth.toString().substring(0, 10);
    boq_revised_controller.entryList_todateController.text =
        BaseUtitiles.initiateCurrentDateFormat();
    boq_revised_controller.Boq_getEntryList();
    boq_revised_controller.Boq_entryList.value =
        boq_revised_controller.main_entryList.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Setmybackground,
        floatingActionButton:
        Obx(()=> Visibility(
          visible: commanController.addMode.value == 1 ? true : false,
          child: FloatingActionButton.extended(
            onPressed: () {
              boq_revised_controller.itemCheck = 0;
              boq_revised_controller.editCheck = 0;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Boq_Revised_EntryScreen()));
            },
            label: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: RequestConstant.Lable_Font_SIZE,
              ),
            ),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: RequestConstant.Heading_Font_SIZE,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BOQ - Revised",
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
                        ))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                boq_revised_controller.entryList_frdateController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "From Date",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date),
                            ),
                            onTap: () async {
                              var Frdate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          onPrimary: Colors.white,
                                          onSurface:
                                              Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                                Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              boq_revised_controller.entryList_frdateController
                                  .text = Frdate.toString().substring(0, 10);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: BaseUtitiles.getWidthtofPercentage(context, 38),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: TextFormField(
                            readOnly: true,
                            controller: boq_revised_controller.entryList_todateController,
                            cursorColor: Colors.black,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              labelText: "ToDate",
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: RequestConstant.Lable_Font_SIZE),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  child: ConstIcons.date),
                            ),
                            onTap: () async {
                              var Todate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime.now(),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: Theme.of(context).primaryColor,
                                          // header background color
                                          onPrimary: Colors.white,
                                          // header text color
                                          onSurface:
                                              Colors.black, // body text color
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary:
                                                Colors.black, // button text color
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  });
                              boq_revised_controller.entryList_todateController
                                  .text = Todate.toString().substring(0, 10);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select Date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: () async {
                          setState(() {
                            boq_revised_controller.Boq_getEntryList();
                          });
                        },
                        child: const Center(
                            child: Padding(
                          padding: EdgeInsets.only(top: 13, bottom: 13),
                          child: Text("SHOW",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: RequestConstant.App_Font_SIZE,
                                  fontWeight: FontWeight.bold)),
                        ))),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  height: BaseUtitiles.getheightofPercentage(context, 80),
                  decoration: const BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: TextField(
                          cursorColor: Theme.of(context).primaryColor,
                          controller: editingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(bottom: 10, left: 15),
                              child: ConstIcons.list_Search,
                            ),
                            hintText: "Search..",
                            hintStyle: TextStyle(color: Colors.black),
                            isDense: true,
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                          },
                          textInputAction: TextInputAction.search,
                          onChanged: (value) {
                            setState(() {
                              boq_revised_controller.Boq_entryList.value = BaseUtitiles.filterSearchResults(value, boq_revised_controller.main_entryList);
                            });
                          },
                        ),
                      ),
                      ListDetails(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget ListDetails() {
    return SizedBox(
      height: BaseUtitiles.getheightofPercentage(context, 69),
      child: Column(
        children: [
          SizedBox(
            height: BaseUtitiles.getheightofPercentage(context, 68),
            child: Obx(
              () => ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: boq_revised_controller.Boq_entryList.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 3, right: 3),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    width: BaseUtitiles.getWidthtofPercentage(
                                        context, 50),
                                    child: Row(
                                      children: [
                                        ConstIcons.list_date,
                                        Padding(
                                          padding: const EdgeInsets.only(left: 3),
                                          child: Text(
                                            boq_revised_controller.Boq_entryList.value[index].reviseDate.toString(),
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      boq_revised_controller.Boq_entryList.value[index].reviseNo.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 5, left: 10),
                                    child: const Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Project :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        boq_revised_controller
                                            .Boq_entryList.value[index].project
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(top: 2, left: 10),
                                    child: const Text(""),
                                  ),
                                  const Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Site :",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 8,
                                      child: Text(
                                        boq_revised_controller
                                            .Boq_entryList.value[index].siteName
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      )),
                                ],
                              ),
                              const Divider(thickness: 1),
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: const Text(""),
                                  ),
                                  const Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Prepared By :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        boq_revised_controller.Boq_entryList
                                            .value[index].preparedby
                                            .toString(),
                                        style: const TextStyle(color: Colors.black),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                shape: const RoundedRectangleBorder(
                                                  // <-- SEE HERE
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                          top: Radius.circular(
                                                              25.0)),
                                                ),
                                                builder: (context) {
                                                  return Container(
                                                    margin: const EdgeInsets.only(
                                                      left: 15,
                                                    ),
                                                    height: BaseUtitiles
                                                        .getheightofPercentage(
                                                            context, 25),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(right: 10),
                                                              child: Text(
                                                                boq_revised_controller.Boq_entryList.value[index].reviseNo.toString(),
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    color: Theme.of(context).primaryColor),
                                                              ),
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                icon: ConstIcons.cancle)
                                                          ],
                                                        ),
                                                        Visibility(
                                                          visible: commanController.editMode.value == 1 ? true : false,
                                                          child: InkWell(
                                                              child: const Row(
                                                                children: [
                                                                  Card(
                                                                    color: Colors
                                                                        .lightGreen,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets.all(8),
                                                                      child: Icon(
                                                                        Icons.edit,
                                                                        color: Colors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "Edit",
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontSize: 15),
                                                                  )
                                                                ],
                                                              ),
                                                              onTap: () {
                                                                boq_revised_controller.itemCheck = 1;
                                                                boq_revised_controller.delete_BoqRevised_itemlist_Table();
                                                                boq_revised_controller.Boqitem_itemview_GetDbList.clear();
                                                                boq_revised_controller.getBoqDetList.clear();
                                                                boq_revised_controller.BoqrevisedList_EditApi(
                                                                    boq_revised_controller.Boq_entryList.value[index].reviseId,
                                                                    context);
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();
                                                              }),
                                                        ),
                                                        Container(
                                                            margin: const
                                                                EdgeInsets.only(
                                                                    right: 20),
                                                            child: const Divider(
                                                                thickness: 1)),
                                                        Visibility(
                                                          visible: commanController.deleteMode.value == 1 ? true : false,
                                                          child: InkWell(
                                                              child: const Row(
                                                                children: [
                                                                  Card(
                                                                    color: Colors
                                                                        .red,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsets
                                                                              .all(8),
                                                                      child: Icon(
                                                                        Icons
                                                                            .delete_forever,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                      width: 5),
                                                                  Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            15),
                                                                  )
                                                                ],
                                                              ),
                                                              onTap: () async {
                                                                Navigator.pop(
                                                                    context);
                                                                boq_revised_controller
                                                                    .DeleteAlert(
                                                                        context,
                                                                        index);
                                                              }),
                                                        ),
                                                        const SizedBox(height: 20)
                                                      ],
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons
                                                .arrow_drop_down_circle_outlined,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
