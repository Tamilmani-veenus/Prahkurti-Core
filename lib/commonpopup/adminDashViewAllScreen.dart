import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/admin_dashboard_controller.dart';
import '../models/admin_dashboard_response.dart';
import '../newhome/maindashboard/admin_dashboard.dart';
import '../utilities/baseutitiles.dart';

class POVsBillListViewAll extends StatefulWidget {

  const POVsBillListViewAll({Key? key})
      : super(key: key);

  @override
  State<POVsBillListViewAll> createState() => _POVsBillListViewAllState();
}

class _POVsBillListViewAllState extends State<POVsBillListViewAll> {
  AdminDashboardController adminDashboardController =
      Get.put(AdminDashboardController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        adminDashboardController.poVsBillTableList
            .assignAll(adminDashboardController.allPoVsBillTableList);
        searchController.clear();
        adminDashboardController.selectedStatus.value = "All Status";
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "PO Value vs Billed Amount",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, // Hide left back button
            actions: [
              TextButton(
                  onPressed: () {
                    adminDashboardController.poVsBillTableList.assignAll(
                        adminDashboardController.allPoVsBillTableList);
                    searchController.clear();
                    adminDashboardController.selectedStatus.value =
                        "All Status";
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        width: 150,
                        child: TextField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 14),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Purple when focused
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              adminDashboardController
                                  .filterPoVsBillValues(value);
                            }),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Obx(() => SizedBox(
                          width: 180,
                          height: 42,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              alignment: Alignment.centerLeft,
                              hint: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "All",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              items: adminDashboardController.poVsBillStatusList
                                  .map((status) => DropdownMenuItem<String>(
                                        value: status,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            status,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value:
                                  adminDashboardController.selectedStatus.value,
                              onChanged: (value) {
                                adminDashboardController.selectedStatus.value =
                                    value!;
                                adminDashboardController.filterProjects();
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 42,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 22,
                                iconEnabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 220,
                                offset: const Offset(0, 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() => ListView.separated(
                      padding: EdgeInsets.all(12),
                      shrinkWrap: true,
                      itemCount:
                          adminDashboardController.poVsBillTableList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item =
                            adminDashboardController.poVsBillTableList[index];
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 44,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.projectName!
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.blueGrey.shade700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.projectName!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Text(
                                          "PO: ${item.poValue!}",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        item.varianceLabel!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: adminDashboardController
                                              .getVarianceColor(
                                                  item.varianceLabel),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              SegmentedProgressBar(
                                progress: adminDashboardController
                                    .getProgress(item.billingPercent),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Bill: ₹${item.billValue!}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      "${item.billingPercent!} of PO",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BOQProgressViewAll extends StatefulWidget {

  const BOQProgressViewAll({Key? key}) : super(key: key);

  @override
  State<BOQProgressViewAll> createState() => _BOQProgressViewAllState();
}

class _BOQProgressViewAllState extends State<BOQProgressViewAll> {
  AdminDashboardController adminDashboardController =
      Get.put(AdminDashboardController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        adminDashboardController.boqProgressTableList
            .assignAll(adminDashboardController.allBoqProgressTableList);
        searchController.clear();
        adminDashboardController.selectedStatus.value = "All Status";
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "All Projects",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false, // Hide left back button
            actions: [
              TextButton(
                  onPressed: () {
                    adminDashboardController.boqProgressTableList.assignAll(
                        adminDashboardController.allBoqProgressTableList);
                    searchController.clear();
                    adminDashboardController.selectedStatus.value =
                        "All Status";
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ))
            ],
          ),
          body: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        width: 150,
                        child: TextField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(fontSize: 14),
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Colors.grey, // Purple when focused
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              adminDashboardController
                                  .filterBOQProgressValues(value);
                            }),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Obx(() => SizedBox(
                          width: 180,
                          height: 42,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              alignment: Alignment.centerLeft,
                              hint: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "All",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              items: adminDashboardController.boqProgressStatusList
                                  .map((status) => DropdownMenuItem<String>(
                                        value: status,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            status,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value:
                                  adminDashboardController.selectedStatus.value,
                              onChanged: (value) {
                                adminDashboardController.selectedStatus.value =
                                    value!;
                                adminDashboardController.filterBOQProgressProjects();
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 42,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 22,
                                iconEnabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 220,
                                offset: const Offset(0, 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() => ListView.separated(
                      padding: EdgeInsets.all(12),
                      shrinkWrap: true,
                      itemCount:
                          adminDashboardController.boqProgressTableList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item =
                            adminDashboardController.boqProgressTableList[index];
                        final statusColor = adminDashboardController.getStatusColor(item.status);
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.08),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child:  Column(
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 44,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                                      borderRadius:
                                      BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.projectName!
                                            .substring(0, 1)
                                            .toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.projectName!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                "Start: ${item.startDate ?? "-"}",
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withOpacity(.1),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            item.status!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(flex: 1,
                                    child: Text(
                                      "BOQ: ₹${BaseUtitiles().formatAmount(item.boqValue.toString())}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1,
                                    child: Text(
                                      "Planned % : ${BaseUtitiles().formatAmount(item.plannedPercentage.toString())}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(flex: 1,
                                    child: Text(
                                      "Actual % : ${BaseUtitiles().formatAmount(item.actualPercentage.toString())}",
                                      textAlign: TextAlign.end,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  segmentedProgress(
                                    progress: item.progress!,
                                    color: adminDashboardController.getStatusColor(item.status).withOpacity(0.8),
                                  ),

                                  const SizedBox(height: 12),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Text(
                                        item.progress!,
                                        style: TextStyle(
                                          color: adminDashboardController.getStatusColor(item.status),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      Text(
                                        "End : ${item.endDate ?? "-"}",
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
