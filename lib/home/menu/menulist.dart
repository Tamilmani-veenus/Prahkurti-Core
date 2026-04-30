// import '../../../../controller/comman_controller.dart';
// import '../../../../controller/menu_controller.dart';
// import '../../../../utilities/baseutitiles.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class MenuScreen extends StatefulWidget {
//   const MenuScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MenuScreen> createState() => _MenuScreenState();
// }
//
// class _MenuScreenState extends State<MenuScreen> {
//
//     CommanController commanController = Get.put(CommanController());
//     Menu_Controller menuController = Get.put(Menu_Controller());
//
// @override
//   void initState() {
//   var duration = const Duration(seconds: 0);
//   Future.delayed(duration,() async {
//     await menuController.getMenuList(context);
//   });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Sample App"),
//         backgroundColor: Theme.of(context).primaryColor,
//       ),
//       body: FutureBuilder(
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           return Container(
//             margin: const EdgeInsets.all(7),
//             child: expandedList(),
//           );
//         }, future: null,
//       ),
//     );
//   }
//
//   Widget expandedList() {
//     return SizedBox(
//         width: BaseUtitiles.getWidthtofPercentage(context, 100),
//         child: Obx(() => ListView.builder(
//           shrinkWrap: true,
//           physics: const ScrollPhysics(),
//           itemCount: menuController.menuListDatas.value.length,
//           itemBuilder: (context, index) {
//             return Card(
//               color: Theme.of(context).primaryColor,
//               child: ExpansionTile(
//
//                 title:  Text(
//                   menuController.menuListDatas.value[index].headName.toString(),style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),textAlign:TextAlign.center,
//                 ),
//                 children: <Widget>[
//                   menuController.menuListDatas.value[index].headName=="Materials"?  ListView.builder(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: menuController.subMatList.length,
//                     itemBuilder: (BuildContext context, int value) {
//                       return InkWell(
//                         onTap: ()async{
//                           menuController.MaterialScreen(menuController.subMatList[value],context);
//                           menuController.formName.value=menuController.subMatList[value];
//                           await commanController.getControllEntryListRights();
//                         },
//                         child: Column(
//                           children: <Widget>[
//                             const Divider(
//                               color: Colors.white,
//                             ),
//                             Container(
//                               alignment: Alignment.center,
//                               margin: const EdgeInsets.only(left: 20, right: 20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                               child: Text(menuController.subMatList[value],textAlign:TextAlign.center,style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ):Container(),
//                   menuController.menuListDatas.value[index].headName=="Main Menu"?  ListView.builder(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: menuController.subMainmenuList.length,
//                     itemBuilder: (BuildContext context, int value) {
//                       return InkWell(
//                         onTap: ()async{
//                           menuController.MainmenuScreen(menuController.subMainmenuList[value],context);
//                           menuController.formName.value=menuController.subMainmenuList[value];
//                           await commanController.getControllEntryListRights();
//                         },
//                         child: Column(
//                           children: [
//                             const Divider(color: Colors.white,),
//                             Container(
//                               alignment: Alignment.center,
//                               margin: const EdgeInsets.only(left: 20, right: 20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                               child: Text(menuController.subMainmenuList[value],style: const TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ):Container(),
//                   menuController.menuListDatas.value[index].headName=="Daily Entries"?  ListView.builder(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: menuController.dailyEntryList.length,
//                     itemBuilder: (BuildContext context, int value) {
//                       return InkWell(
//                         onTap: () async {
//                           menuController.NavigateScreen(menuController.dailyEntryList[value],context);
//                           menuController.formName.value=menuController.dailyEntryList[value];
//                           await commanController.getControllEntryListRights();
//                         },
//                         child: Column(
//                           children: [
//                             const Divider(color: Colors.white,),
//                             Container(
//                               alignment: Alignment.center,
//                               margin: const EdgeInsets.only(left: 20, right: 20),
//                               height: BaseUtitiles.getheightofPercentage(context, 4),
//                               width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                               child: Text(menuController.dailyEntryList[value],style: const TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ):Container(),
//                   menuController.menuListDatas.value[index].headName=="Accounts"?  ListView.builder(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: menuController.accountsList.length,
//                     itemBuilder: (BuildContext context, int value) {
//                       return InkWell(
//                         onTap: () async {
//                           menuController.AccountsScreen(menuController.accountsList[value],context);
//                           menuController.formName.value=menuController.accountsList[value];
//                           await commanController.getControllEntryListRights();
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(),
//                           child: Column(
//                             children: [
//                               const Divider(color: Colors.white,),
//                               Container(
//                                 alignment: Alignment.center,
//                                 margin: const EdgeInsets.only(left: 20, right: 20),
//                                 height: BaseUtitiles.getheightofPercentage(context, 4),
//                                 width: BaseUtitiles.getWidthtofPercentage(context, 90),
//                                 child: Text(menuController.accountsList[value],style: const TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold),),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ):Container(),
//                 ],
//               ),
//             );
//           },
//         )));
//   }
// }
