import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math' as math;
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
                                      "PO: ₹${item.poValue!}",
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
                  padding: const EdgeInsets.all(12),
                  shrinkWrap: true,
                  itemCount: adminDashboardController.boqProgressTableList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = adminDashboardController.boqProgressTableList[index];

                    final statusColor = adminDashboardController.getStatusColor(item.status);

                    final projectName = item.projectName ?? "Unknown Project";

                    final initial = projectName.trim().isNotEmpty
                        ? projectName.trim()[0].toUpperCase()
                        : "P";

                    final boq = BaseUtitiles().formatAmount(item.boqValue.toString());
                    final planned = BaseUtitiles().formatAmount(item.plannedPercentage.toString());
                    final actual = BaseUtitiles().formatAmount(item.actualPercentage.toString());

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.035),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 5,
                              decoration: BoxDecoration(
                                color: statusColor,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // PROJECT INITIAL
                                        Container(
                                          width: 42,
                                          height: 42,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: statusColor.withOpacity(.08),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            initial,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: statusColor,
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 11),

                                        // PROJECT NAME + DATE
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                projectName,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),
                                              ),

                                              const SizedBox(height: 5),

                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.calendar_month_outlined,
                                                    size: 12,
                                                    color: Colors.black54,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      "${item.startDate ?? "-"}  →  ${item.endDate ?? "-"}",
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        // STATUS
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 9,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: statusColor.withOpacity(.09),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                width: 6,
                                                height: 6,
                                                decoration: BoxDecoration(
                                                  color: statusColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                item.status ?? "",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: statusColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 13),

                                    // STATS CONTAINER
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF8F9FB),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: _dashboardStat("BOQ", "₹$boq"),
                                          ),
                                          _verticalDivider(),
                                          Expanded(
                                            child: _dashboardStat(
                                              "PLANNED",
                                              "$planned%",
                                              valueColor: const Color(0xff4F46E5),
                                            ),
                                          ),
                                          _verticalDivider(),
                                          Expanded(
                                            child: _dashboardStat(
                                              "ACTUAL",
                                              "$actual%",
                                              valueColor: statusColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      children: [
                                        Text(
                                          "Project Progress",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          "${item.progress ?? 0}",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: statusColor,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 7),

                                    segmentedProgress(
                                      progress: item.progress!,
                                      color: statusColor.withOpacity(0.85),
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
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dashboardStat(
      String label,
      String value, {
        Color? valueColor,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500,
            letterSpacing: .3,
          ),
        ),

        const SizedBox(height: 4),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: valueColor ?? Colors.grey.shade800,
            ),
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 28,
      width: 1,
      color: Colors.grey.shade200,
    );
  }
}

class BudgetVsSpendDialog extends StatefulWidget {
  const BudgetVsSpendDialog({super.key});

  @override
  State<BudgetVsSpendDialog> createState() => _BudgetVsSpendDialogState();
}

class _BudgetVsSpendDialogState extends State<BudgetVsSpendDialog> {

  AdminDashboardController adminDashboardController = Get.put(AdminDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All Status";

  final List<String> filterItems = [
    "All Status",
    "Under",
    "Over",
    "On Track",
  ];

  late ZoomPanBehavior _zoomPanBehavior;

  final ScrollController _horizontalScrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      adminDashboardController.filteredBudgetVsSpendList.assignAll(
          adminDashboardController.allBudgetVsSpendList     );
    });

    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      zoomMode: ZoomMode.x,
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: false,
      enableSelectionZooming: false,
    );

  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        adminDashboardController.filteredBudgetVsSpendList.assignAll(adminDashboardController.allBudgetVsSpendList);
        searchController.clear();
        filterValue = "All Status";

        return true;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          height: 430,
          child: Column(
            children: [

              /// Header
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Budget Vs Spent (Project-wise)",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        adminDashboardController.filteredBudgetVsSpendList.assignAll(
                          adminDashboardController.allBudgetVsSpendList,
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close,size: 20,),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              /// Search & Filter
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextField(
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: searchController,
                            cursorColor: Colors.black87,
                            cursorWidth: 1,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              decoration: TextDecoration.none, // Removes text underline
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                fontSize: 13,
                              ),
                              prefixIcon:
                              const Icon(Icons.search,color: Colors.grey,),
                              contentPadding: EdgeInsets.all(5),
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
                                borderSide:  BorderSide(
                                  color: Colors.grey, // Purple when focused
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              searchController.text = value;
                              applyFilters();
                            }
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    SizedBox(
                      width: 140,
                      height: 36,
                      child: DropdownButtonFormField<String>(
                          value: filterValue,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            filled: true,
                            isDense: true,
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
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          items: filterItems
                              .map(
                                (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,style: TextStyle(fontSize: 12),),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              filterValue = value;
                              applyFilters();
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _legend(
                      const Color(0xff2F5BEA),
                      "Budget (₹)",
                    ),
                    const SizedBox(width: 15),
                    _legend(
                      const Color(0xff34C759),
                      "Spent (₹)",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 5,
                      right: 5,
                      bottom: 10,
                    ),
                    child: Obx(() {

                      final chartData = List<BudgetVsSpend>.from(
                        adminDashboardController.filteredBudgetVsSpendList,
                      )
                        ..sort(
                              (a, b) => adminDashboardController.parseChartValue(b.budget)
                              .compareTo(adminDashboardController.parseChartValue(a.budget)),
                        );

                      final axisValues = getYAxisValues(
                        adminDashboardController.allBudgetVsSpendList,
                      );

                      return chartData.isEmpty
                          ? const Center(
                        child: Text(
                          "No Data Available",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ):SizedBox(
                        width: math.max(
                          MediaQuery.of(context).size.width,
                          math.max(
                            adminDashboardController.allBudgetVsSpendList.length,
                            3,
                          ) *
                              160.0,
                        ),
                        child: SfCartesianChart(
                          zoomPanBehavior: _zoomPanBehavior,
                          plotAreaBorderWidth: 0,
                          legend:  Legend(
                            isVisible: false,
                            position: LegendPosition.top,
                          ),
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          primaryXAxis: CategoryAxis(
                            visibleMinimum: 0,
                            visibleMaximum: 2,
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            axisLine: const AxisLine(width: 0),
                            labelStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                            labelPlacement: LabelPlacement.betweenTicks,
                            maximumLabelWidth: 90,
                            labelRotation: 0,
                            autoScrollingDelta:3,
                            autoScrollingMode: AutoScrollingMode.start,
                            interval: 1,
                          ),

                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: axisValues["maximum"]!,
                            interval: axisValues["interval"]!,
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            majorGridLines: MajorGridLines(
                              color: Colors.grey.shade300,
                            ),
                            axisLabelFormatter: (AxisLabelRenderDetails details) {
                              return ChartAxisLabel(
                                formatAxisLabel(details.value),
                                const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<BudgetVsSpend, String>(
                              dataSource: chartData,
                              width: 0.8,
                              spacing: 0.15,
                              color: const Color(0xff2F5BEA),

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),

                              xValueMapper: (BudgetVsSpend item, _) =>
                                  BaseUtitiles.formatProjectName(item.projectName ?? ""),

                              yValueMapper: (item, _) => adminDashboardController.parseChartValue(item.budget),
                              dataLabelMapper: (BudgetVsSpend item, _) =>
                                  formatChartLabel(item.budget),
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.outer,
                                textStyle: TextStyle(
                                  color: Color(0xff2F5BEA),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            ColumnSeries<BudgetVsSpend, String>(
                              dataSource: chartData,
                              width: 0.8,
                              spacing: 0.15,
                              color: const Color(0xff34C759),

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),

                              xValueMapper: (BudgetVsSpend item, _) =>
                                  BaseUtitiles.formatProjectName(item.projectName ?? ""),

                              yValueMapper: (item, _) => adminDashboardController.parseChartValue(item.spent),
                              dataLabelMapper: (BudgetVsSpend item, _) =>
                                  formatChartLabel(item.spent),
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.outer,
                                textStyle: TextStyle(
                                  color: Color(0xff34C759),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatChartLabel(String? value) {
    if (value == null || value.isEmpty) return "0";

    // Don't modify values with units
    if (value.contains("L") || value.contains("Cr")) {
      return value;
    }

    final number = double.tryParse(value.replaceAll("₹", "").trim());

    if (number == null) return value;

    if (number == number.toInt()) {
      return number.toInt().toString(); // 105.00 -> 105
    }

    return number.toString(); // 100.50 -> 100.5
  }

  String formatAxisLabel(num value) {
    if (value >= 10000000) {
      return "${(value / 10000000).toStringAsFixed(2)} Cr";
    }

    if (value >= 100000) {
      return "${(value / 100000).toStringAsFixed(2)} L";
    }

    // Remove trailing .00
    if (value == value.toInt()) {
      return value.toInt().toString();
    }

    return value.toStringAsFixed(2);
  }

  Widget _legend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }

  Map<String, double> getYAxisValues(List<BudgetVsSpend> list) {
    double maxValue = 0;

    for (final item in list) {
      maxValue = math.max(
        maxValue,
        math.max(
          adminDashboardController.parseChartValue(item.budget),
          adminDashboardController.parseChartValue(item.spent),
        ),
      );
    }

    // Handle all zero values
    if (maxValue <= 0) {
      return {
        "maximum": 5,
        "interval": 1,
      };
    }

    final maximum = (maxValue * 1.1).ceilToDouble();
    final interval = math.max(1.0, maximum / 5);

    return {
      "maximum": maximum,
      "interval": interval,
    };
  }
  /// ---------- Search based on projects ----------
  // void searchProjects(String query) {
  //   final search = query.trim().toLowerCase();
  //
  //   final sourceList = adminDashboardController.allBudgetVsSpendList;
  //
  //
  //   if (search.isEmpty) {
  //     filterProjects(filterValue); // Retain the selected dropdown filter
  //     return;
  //   }
  //
  //   adminDashboardController.filteredBudgetVsSpendList.assignAll(
  //     sourceList.where((item) {
  //       return (item.projectName ?? "")
  //           .trim()
  //           .toLowerCase()
  //           .contains(search);
  //     }).toList(),
  //   );
  //
  //   // Apply the selected dropdown filter on the searched results
  //   switch (filterValue) {
  //     case "Under":
  //       adminDashboardController.filteredBudgetVsSpendList.assignAll(
  //         adminDashboardController.filteredBudgetVsSpendList.where((e) {
  //           return parseChartValue(e.budget) < parseChartValue(e.spent);
  //         }).toList(),
  //       );
  //       break;
  //
  //     case "Over":
  //       adminDashboardController.filteredBudgetVsSpendList.assignAll(
  //         adminDashboardController.filteredBudgetVsSpendList.where((e) {
  //           return parseChartValue(e.spent) > parseChartValue(e.budget);
  //         }).toList(),
  //       );
  //       break;
  //
  //     case "On Track":
  //       adminDashboardController.filteredBudgetVsSpendList.assignAll(
  //         adminDashboardController.filteredBudgetVsSpendList.where((e) {
  //           return (parseChartValue(e.budget) - parseChartValue(e.spent)).abs() < 0.01;
  //         }).toList(),
  //       );
  //       break;
  //   }
  //
  // }

  /// Dropdown Allstatus, under, Over ---------

  void applyFilters() {
    List<BudgetVsSpend> list =
    List.from(adminDashboardController.allBudgetVsSpendList);

    // Search
    if (searchController.text.trim().isNotEmpty) {
      list = list.where((e) {
        return (e.projectName ?? "")
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      }).toList();
    }

    // Status Filter
    switch (filterValue) {
      case "Under":
        list = list.where((e) =>
        adminDashboardController.parseChartValue(e.spent) < adminDashboardController.parseChartValue(e.budget)).toList();
        break;

      case "Over":
        list = list.where((e) =>
        adminDashboardController.parseChartValue(e.spent) > adminDashboardController.parseChartValue(e.budget)).toList();
        break;

      case "On Track":
        list = list.where((e) =>
        (adminDashboardController.parseChartValue(e.spent) - adminDashboardController.parseChartValue(e.budget)).abs() < 0.01).toList();
        break;

      case "All Status":
      default:
        break;
    }

    // Sort by budget (Highest first)
    list.sort((a, b) =>
        adminDashboardController.parseChartValue(b.budget).compareTo(adminDashboardController.parseChartValue(a.budget)));

    adminDashboardController.filteredBudgetVsSpendList.assignAll(list);
  }
}

class BudgetVsActualDialog extends StatefulWidget {
  const BudgetVsActualDialog({super.key});

  @override
  State<BudgetVsActualDialog> createState() => _BudgetVsActualDialogState();
}

class _BudgetVsActualDialogState extends State<BudgetVsActualDialog> {

  AdminDashboardController adminDashboardController = Get.put(AdminDashboardController());
  final TextEditingController searchController = TextEditingController();
  String filterValue = "All Status";

  final List<String> filterItems = [
    "All Status",
    "Under",
    "Over",
    "On Track",
  ];

  late ZoomPanBehavior _zoomPanBehavior;

  final ScrollController _horizontalScrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      adminDashboardController.filteredBudgetVsActualList.assignAll(
          adminDashboardController.allBudgetVsActualList     );
    });

    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,        // allows horizontal drag/scroll
      enablePinching: true,       // pinch to zoom (optional)
      zoomMode: ZoomMode.x,       // restrict zoom/pan to X-axis only
      enableMouseWheelZooming: true,
      enableDoubleTapZooming: false,
      enableSelectionZooming: false,// desktop/web mouse-wheel support
    );

  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        adminDashboardController.filteredBudgetVsActualList.assignAll(adminDashboardController.allBudgetVsActualList);
        searchController.clear();
        filterValue = "All Status";

        return true;
      },
      child: Dialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 30,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * .85,
          height: 430,
          child: Column(
            children: [

              /// Header
              Padding(
                padding: const EdgeInsets.all(6),
                child: Row(
                  children: [
                    const SizedBox(width: 15),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Completion Vs Budget Actual",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        adminDashboardController.filteredBudgetVsActualList.assignAll(
                          adminDashboardController.allBudgetVsActualList,
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close,size: 20,),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              /// Search & Filter
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 36,
                        child: TextField(
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: searchController,
                            cursorColor: Colors.black87,
                            cursorWidth: 1,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              decoration: TextDecoration.none, // Removes text underline
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              hintText: "Search",
                              hintStyle: TextStyle(
                                fontSize: 13,
                              ),
                              prefixIcon:
                              const Icon(Icons.search,color: Colors.grey,),
                              contentPadding: EdgeInsets.all(5),
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
                                borderSide:  BorderSide(
                                  color: Colors.grey, // Purple when focused
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              searchController.text = value;
                              applyProjectCompletionSearch();
                            }
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    SizedBox(
                      width: 140,
                      height: 36,
                      child: DropdownButtonFormField<String>(
                          value: filterValue,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            filled: true,
                            isDense: true,
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
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          items: filterItems
                              .map(
                                (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e,style: TextStyle(fontSize: 12),),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              filterValue = value;
                              applyProjectCompletionFilters();
                            }
                          }
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  bottom: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _legend(
                      const Color(0xffF97316),
                      "Budget %",
                    ),
                    const SizedBox(width: 15),
                    _legend(
                      const Color(0xff2F5BEA),
                      "Actual %",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                    padding:
                    const EdgeInsets.only(left: 5,
                      right: 5,
                      bottom: 10,
                    ),
                    child: Obx(() {

                      final data = List<ProjectCompletion>.from(
                        adminDashboardController.filteredBudgetVsActualList,
                      );

                      if (data.isEmpty) {
                        return const Center(
                          child: Text(
                            "No Record Found",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }

                      final budgetPercentage = parse_Percentage(
                        adminDashboardController
                            .dashboardResponse
                            .value
                            ?.budgetUsed,
                      );

                      return data.isEmpty
                          ? const Center(
                        child: Text(
                          "No Data Available",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ):SizedBox(
                        width: math.max(
                          MediaQuery.of(context).size.width,
                          math.max(
                            adminDashboardController.allBudgetVsActualList.length,
                            3,
                          ) *
                              160.0,
                        ),
                        child: SfCartesianChart(
                          zoomPanBehavior: _zoomPanBehavior,
                          plotAreaBorderWidth: 0,
                          legend:  Legend(
                            isVisible: false,
                            position: LegendPosition.top,
                          ),
                          margin: const EdgeInsets.only(top: 20, right: 10),
                          primaryXAxis: CategoryAxis(
                            visibleMinimum: 0,
                            visibleMaximum: 2,
                            majorGridLines: const MajorGridLines(width: 0),
                            majorTickLines: const MajorTickLines(size: 0),
                            axisLine: const AxisLine(width: 0),
                            labelStyle: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
                            labelPlacement: LabelPlacement.betweenTicks,
                            maximumLabelWidth: 90,
                            labelRotation: 0,
                            autoScrollingDelta:3,
                            autoScrollingMode: AutoScrollingMode.start,
                            interval: 1,
                          ),

                          primaryYAxis: NumericAxis(
                            minimum: 0,
                            maximum: 110,
                            interval: 20,
                            axisLine: const AxisLine(width: 0),
                            labelFormat: '{value}%',
                            majorTickLines: const MajorTickLines(size: 0),
                            majorGridLines: MajorGridLines(
                              color: Colors.grey.shade300,
                            ),
                            axisLabelFormatter: (AxisLabelRenderDetails details) {
                              return ChartAxisLabel(
                                '${details.value.toInt()}%',
                                const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            },
                          ),
                          series: <CartesianSeries>[
                            ColumnSeries<ProjectCompletion, String>(
                              name: "Budget %",
                              dataSource: data,

                              width: 0.8,
                              spacing: 0.15,

                              color: const Color(0xffF97316),

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),

                              xValueMapper: (ProjectCompletion item, _) => BaseUtitiles.formatProjectName(item.projectName ?? ""),

                              yValueMapper: (ProjectCompletion item, _) => budgetPercentage,

                              dataLabelMapper: (ProjectCompletion item, _) => '${budgetPercentage.toStringAsFixed(0)}%',

                              dataLabelSettings:
                              const DataLabelSettings(
                                isVisible: true,

                                labelAlignment:
                                ChartDataLabelAlignment.outer,

                                textStyle: TextStyle(
                                  color: Color(0xffF97316),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                            // ACTUAL
                            ColumnSeries<ProjectCompletion, String>(
                              name: "Actual %",
                              dataSource: data,

                              width: 0.8,
                              spacing: 0.15,

                              color: const Color(0xff2563EB),

                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),

                              xValueMapper:
                                  (ProjectCompletion item, _) =>
                                  BaseUtitiles
                                      .formatProjectName(
                                    item.projectName ?? "",
                                  ),

                              yValueMapper:
                                  (ProjectCompletion item, _) =>
                              item.completionPercentage ??
                                  0.0,

                              dataLabelMapper:
                                  (ProjectCompletion item, _) =>
                              '${(item.completionPercentage ?? 0.0).toStringAsFixed(0)}%',


                              dataLabelSettings:
                              const DataLabelSettings(
                                isVisible: true,

                                labelAlignment:
                                ChartDataLabelAlignment.outer,

                                textStyle: TextStyle(
                                  color: Color(0xff2563EB),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double parse_Percentage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 0.0;
    }

    return double.tryParse(
      value.replaceAll('%', '').trim(),
    ) ??
        0.0;
  }

  Widget _legend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }


  /// Dropdown Allstatus, under, Over ---------

  void applyProjectCompletionSearch() {
    List<ProjectCompletion> list =
    List<ProjectCompletion>.from(
      adminDashboardController.allBudgetVsActualList,
    );

    final searchText =
    searchController.text.trim().toLowerCase();

    if (searchText.isNotEmpty) {
      list = list.where((e) {
        return (e.projectName ?? "")
            .toLowerCase()
            .contains(searchText);
      }).toList();
    }

    adminDashboardController.filteredBudgetVsActualList
        .assignAll(list);
  }

  void applyProjectCompletionFilters() {
    List<ProjectCompletion> list =
    List<ProjectCompletion>.from(
      adminDashboardController.allBudgetVsActualList,
    );

    final searchText =
    searchController.text.trim().toLowerCase();

    if (searchText.isNotEmpty) {
      list = list.where((e) {
        return (e.projectName ?? "")
            .toLowerCase()
            .contains(searchText);
      }).toList();
    }


    final budget = parse_Percentage(
      adminDashboardController
          .dashboardResponse
          .value
          ?.budgetUsed,
    );


    switch (filterValue) {
      case "Under":
        list = list.where((e) {
          final actual = e.completionPercentage ?? 0.0;

          // Actual is HIGHER than budget
          return actual < budget;
        }).toList();
        break;

      case "Over":
        list = list.where((e) {
          final actual = e.completionPercentage ?? 0.0;

          // Actual is LOWER than budget
          return actual > budget;
        }).toList();
        break;

      case "On Track":
        list = list.where((e) {
          final actual = e.completionPercentage ?? 0.0;

          return (actual - budget).abs() < 0.01;
        }).toList();
        break;

      case "All Status":
      default:
      // Do nothing.
      // Entire list remains.
        break;
    }

    adminDashboardController
        .filteredBudgetVsActualList
        .assignAll(list);
  }
}