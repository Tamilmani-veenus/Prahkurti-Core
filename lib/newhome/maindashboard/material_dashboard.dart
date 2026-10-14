import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../commonpopup/material_dash_view_all.dart';
import '../../controller/logincontroller.dart';
import '../../controller/material_dashboard_controller.dart';
import '../../utilities/baseutitiles.dart';
import 'dashboard.dart';

class _MaterialHomeScreenState extends State<MaterialHomeScreen> {
  MaterialDashboardController materialDashboardController =
  Get.put(MaterialDashboardController());
  LoginController loginController = Get.put(LoginController());
  String activeFilterTab = "today";
  String rangeLabel = "";
  late TooltipBehavior _tooltipBehavior;

  final List<String> tabs = [
    "Project Wise",
    "Material Head",
    "Supplier Wise",
  ];

  final List<Map<String, String>> filterTabs = [
    {"key": "today", "label": "Today"},
    {"key": "week", "label": "This Week"},
    {"key": "month", "label": "This Month"},
    {"key": "quarter", "label": "This Qtr"},
    {"key": "fy", "label": "This FY"},
    {"key": "lastfy", "label": "Last FY"},
  ];

  @override
  void initState() {
    super.initState();

    _tooltipBehavior = TooltipBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap,
      builder: (
          dynamic data,
          dynamic point,
          dynamic series,
          int pointIndex,
          int seriesIndex,
          ) {
        // New donut chart
        if (data is Map<String, dynamic>) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["name"] as String? ?? "",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  data["percentageText"] as String? ?? "0%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        }

        // Old donut chart
        final item = data;

        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.materialHeadName ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                "₹ ${item.totalAmount ?? "0.00"}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectFilterTab("today");
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Dashboard_screen(),
          ),
        );
        return false;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              if (materialDashboardController.selectedTab.value == 0) {
                await materialDashboardController
                    .getMatProjWiseDashboardDetails();
              } else if (materialDashboardController.selectedTab.value == 1) {
                await materialDashboardController.getMatHeadDashboardDetails();
              } else {
                await materialDashboardController.getSupWiseDashboardDetails();
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Container(
                        height: 38,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F2F5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: List.generate(
                            tabs.length,
                                (index) {
                              final isSelected = materialDashboardController.selectedTab.value == index;

                              return Expanded(
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {
                                    if (materialDashboardController.selectedTab.value == index) {
                                      return;
                                    }

                                    // ----------------------------------------
                                    // CHANGE TAB UI IMMEDIATELY
                                    // ----------------------------------------
                                    setState(() {
                                      activeFilterTab = "today";

                                      final today = DateTime.now();

                                      materialDashboardController.entryFromDate.text =
                                          formatDate(today);

                                      materialDashboardController.entryToDate.text =
                                          formatDate(today);

                                      rangeLabel = formatRangeLabel(
                                        today,
                                        today,
                                      );
                                    });

                                    // Change selected tab immediately
                                    materialDashboardController.selectedTab.value = index;

                                    // ----------------------------------------
                                    // API AFTER UI HAS A CHANCE TO PAINT
                                    // ----------------------------------------
                                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                                      if (index == 0) {
                                        await materialDashboardController
                                            .getMatProjWiseDashboardDetails();
                                      } else if (index == 1) {
                                        await materialDashboardController
                                            .getMatHeadDashboardDetails();
                                      } else {
                                        await materialDashboardController
                                            .getSupWiseDashboardDetails();
                                      }
                                    });
                                  },

                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: isSelected
                                          ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 5,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                          : null,
                                    ),
                                    child: Text(
                                      tabs[index],
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : const Color(0xFF5F6570),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xffE4E7EC),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: durationFilter(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (materialDashboardController.isLoading.value) {
                        return
                          _buildDashboardShimmer();
                      } else {
                        return Obx(() {
                          if (materialDashboardController.selectedTab.value ==
                              0) {
                            return _buildProjectWise();
                          } else if (materialDashboardController
                              .selectedTab.value ==
                              1) {
                            return _buildMaterialHead();
                          } else if (materialDashboardController
                              .selectedTab.value ==
                              2) {
                            return _buildSupplierWise();
                          }
                          return const SizedBox.shrink();
                        });
                      }
                    }),
                     SizedBox(
                      height:!Platform.isAndroid?100: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectWise() {
    return materialDashboardController.projectWiseResponse.value == null
        ? const DashboardErrorWidget()
        : Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          // height: 110,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${BaseUtitiles().getGreeting()}, ${loginController.UserName()}  👋",
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 10),
                Text(
                  "Track your project progress.",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 25),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: GreetingCard(
                          item: greetingCards[0],
                          index: 0,
                        ),
                      ),

                      // Small vertical divider
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),

                      Expanded(
                        child: GreetingCard(
                          item: greetingCards[1],
                          index: 1,
                        ),
                      ),

                      // Small vertical divider
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),

                      Expanded(
                        child: GreetingCard(
                          item: greetingCards[2],
                          index: 2,
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Obx(
              () => GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridInfoCardsProjWise.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (_, index) {
              return GridInfoCard(
                item: gridInfoCardsProjWise[index],
                index: index,
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Billing Completion",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .billingCompletionList.length >
                          3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BillingCompletionViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                final itemList =
                    materialDashboardController.billingCompletionList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No billing data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 3 ? 3 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    final percentage = item.billingCompletionPercentage ?? 0.0;
                    final progress = (percentage / 100).clamp(0.0, 1.0);
                    final progressColor = materialDashboardController
                        .getProgressColor(percentage);
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Avatar
                            Container(
                              width: 42,
                              height: 46,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: progressColor,
                                    width: 4,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  item.projectName!
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: progressColor,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Project details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name + Percentage
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.projectName!,
                                          // maxLines: 1,
                                          // overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        "${item.billingCompletionPercentage ?? 0} %",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: progressColor,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Progress bar
                                  AnimatedProgressBar(
                                    progress: progress,
                                    progressColor: progressColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ));
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PO Value vs Billed Amount",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible:
                      materialDashboardController.poVsBillTableList.length >
                          3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillListViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList = materialDashboardController.poVsBillTableList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No PO data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 3 ? 3 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return MaterialHeadCard(
                      name: item.projectName ?? "",
                      poAmount: item.poAmountInLakhs,
                      billAmount: item.billAmountInLakhs,
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Project PO vs Bill Register",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible:
                      materialDashboardController.poVsBillRegList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillRegViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color:
                            Theme.of(context).primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                final itemList = materialDashboardController.poVsBillRegList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    final statusColor = materialDashboardController
                        .getStatusColor(item.billingStatus);
                    final percentage = item.billingPercentage ?? 0.0;
                    final progressColor = materialDashboardController
                        .getProgressColor(percentage);
                    final primaryColor = Theme.of(context).primaryColor;

                    return Container(
                      padding: const EdgeInsets.all(10),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ───────── HEADER ROW ─────────
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.projectName ?? '',
                                  softWrap: true,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        item.address ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // ───────── METRICS TABLE CONTAINER ─────────
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: primaryColor.withOpacity(0.25),
                              //   width: 1,
                              // ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  primaryColor.withOpacity(0.02),
                                  primaryColor.withOpacity(0.05),
                                  primaryColor.withOpacity(0.02),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                // TOP ROW (4 Items)
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildItem(
                                        title: "POs",
                                        value: "${item.totalPos}",
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "PO Value",
                                        value: "${item.poAmountInLakhs}",
                                        valueColor: Colors.blueAccent,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Billed",
                                        value: "${item.billAmountInLakhs}",
                                        valueColor: const Color(0xFF10B981),
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Approved",
                                        value: "${item.billAmountInLakhs}",
                                        valueColor: Colors.lightGreen,
                                      ),
                                    ),
                                  ],
                                ),

                                // Horizontal Divider
                                Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),

                                // BOTTOM ROW (3 Items)
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildItem(
                                        title: "UnBilled",
                                        value: "${item.unbilledAmountInLakhs}",
                                        valueColor: Colors.brown.shade400,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Over-Billed",
                                        value: "${item.overBillAmountInLakhs}",
                                        valueColor: Colors.red,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Billing %",
                                        value: "${item.billingPercentage} %",
                                        valueColor: progressColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // ───────── BOTTOM PROGRESS & BADGE ROW ─────────
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final bool isNarrow = constraints.maxWidth < 280;

                              if (isNarrow) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: ChevronProgressIndicator(
                                        progress: materialDashboardController
                                            .getPercentProgress(
                                          item.billingPercentage.toString(),
                                        ),
                                        activeColor: progressColor,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: statusColor.withOpacity(0.5),
                                        ),
                                      ),
                                      child: Text(
                                        item.billingStatus ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: statusColor,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }

                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                      20, // optional, keeps indicator height consistent
                                      child: ChevronProgressIndicator(
                                        progress: materialDashboardController
                                            .getPercentProgress(
                                          item.billingPercentage.toString(),
                                        ),
                                        activeColor: progressColor,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  // Fixed width for status
                                  SizedBox(
                                    width: 80,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.05),
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: statusColor.withOpacity(0.5),
                                        ),
                                      ),
                                      child: Text(
                                        item.billingStatus ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 11,
                                          color: statusColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialHead() {
    return materialDashboardController.materialHeadResponse.value == null
        ? const DashboardErrorWidget()
        : Column(
      children: [
        Obx(
              () => GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridInfoCardsMatHead.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (_, index) {
              return GridInfoCard(
                item: gridInfoCardsMatHead[index],
                index: index,
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PO Value vs Billed Amount by Head",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillChartList.length >
                          3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillChartViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillChartList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No PO data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return MaterialHeadCard(
                      name: item.materialHeadName ?? "",
                      poAmount: item.totalPoAmount,
                      billAmount: item.totalBillAmount,
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Variance by Head",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillChartList.length >
                          3,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillChartViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillChartList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No variance data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return MaterialHeadCard(
                      name: item.materialHeadName ?? "",
                      poAmount: item.totalPoAmount,
                      billAmount: item.totalBillAmount,
                      type: "Variance",
                      varianceLabel: item.varianceLabel,
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Spend Distribution",
                style:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      const AnimatedDottedCircle(
                        size: 125,
                      ),
                      OverflowBox(
                        maxWidth: 260,
                        maxHeight: 260,
                        child: SfCircularChart(
                          tooltipBehavior: _tooltipBehavior,
                          margin: EdgeInsets.zero,
                          series: <CircularSeries>[
                            DoughnutSeries(
                              dataSource: materialDashboardController
                                  .spendDistributionList,
                              xValueMapper: (item, _) =>
                              item.materialHeadName ?? "",
                              yValueMapper: (item, _) =>
                                  materialDashboardController.parseAmount(
                                    item.totalAmount,
                                  ),
                              pointColorMapper: (item, index) =>
                                  materialDashboardController
                                      .getMaterialHeadColor(index),
                              innerRadius: '77%',
                              radius: '75%',
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "TOTAL PO",
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: CupertinoColors.inactiveGray,
                            ),
                          ),
                          Text(
                            "${materialDashboardController.materialHeadResponse.value?.overallTotalspendDistributioncount ?? "0.00"}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Obx(() {
                final list =
                    materialDashboardController.spendDistributionList;

                final maxPercentage = list.isEmpty
                    ? 0.0
                    : list
                    .map((e) => e.contributionPercentage ?? 0)
                    .reduce(max);

                final isExpanded = materialDashboardController
                    .isSpendDistributionExpanded.value;

                final displayList =
                isExpanded ? list : list.take(2).toList();

                return Column(
                  children: [
                    Column(
                      children: List.generate(
                        displayList.length,
                            (index) {
                          final item = displayList[index];

                          return buildSpendDistributionItem(
                              name: item.materialHeadName ?? "",
                              amount: "₹ ${item.totalAmount ?? "0.00 L"}",
                              percentageText:
                              item.contributionPercentageText ?? "0%",
                              percentage:
                              item.contributionPercentage ?? 0,
                              color: materialDashboardController
                                  .getMaterialHeadColor(index),
                              maxPercentage: maxPercentage,
                              isMatHead: true,
                              isLast: false);
                        },
                      ),
                    ),
                    if (list.length > 2)
                      GestureDetector(
                        onTap: () {
                          materialDashboardController
                              .isSpendDistributionExpanded
                              .toggle();
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.only(top: 8, bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                isExpanded ? "Show Less" : "Show More",
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (list.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _buildSpendSummaryCard(
                              icon: Icons.trending_up_rounded,
                              label: "TOP CATEGORY",
                              value: list.first.materialHeadName ?? "-",
                              subValue:
                              "${list.first.contributionPercentageText ?? "0%"}",
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            flex: 2,
                            child: _buildSpendSummaryCard(
                              icon: Icons.category_outlined,
                              label: "CATEGORIES",
                              value: "${list.length} tracked",
                              subValue: "",
                            ),
                          ),
                        ],
                      ),
                    ]
                  ],
                );
              }),
              SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Material Head PO vs Bill Register",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillMatHeadList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillMatHeadViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillMatHeadList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No Data Found",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    final percentage = double.tryParse(
                      (item.billingPercent ?? '0')
                          .replaceAll('%', '')
                          .trim(),
                    ) ??
                        0.0;
                    final progressColor = materialDashboardController
                        .getProgressColor(percentage);
                    final overBilledValue = double.tryParse(
                      item.overBilled?.replaceAll(',', '') ?? '',
                    ) ??
                        0.0;
                    final isOverBilledFlag =
                        overBilledValue < 0 || overBilledValue != 0;

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                            children: [
                              // ───────── ACCENT BAR ─────────
                              Container(
                                width: 4,
                                color: progressColor,
                              ),

                              // ───────── CARD BODY ─────────
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      // ───────── HEADER ROW ─────────
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(right: 6),
                                                  child: Icon(
                                                    Icons.layers_outlined,
                                                    color:progressColor,
                                                    size: 20,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${item.materialHeadName}" ,
                                                    style: const TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 13,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 6,
                                                vertical: 2,
                                              ),
                                              decoration: BoxDecoration(
                                                color:
                                                materialDashboardController
                                                    .getVarianceColor(
                                                    item.variance)
                                                    .withOpacity(
                                                    0.06),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    6),
                                              ),
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .swap_vert_rounded,
                                                      color: Colors.grey,
                                                      size: 20),
                                                  const SizedBox(
                                                      width: 4),
                                                  Flexible(
                                                    child: Text(
                                                      item.variance ?? '',
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w600,
                                                        color: materialDashboardController
                                                            .getVarianceColor(
                                                            item.variance),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),

                                      // ───────── ICON CHIP GRID (2 rows x 3) ─────────
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "POs",
                                              value: "${item.totalPOs}",
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "PO Value",
                                              value: "${item.poValue}",
                                              valueColor:
                                              Colors.blueAccent,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "Billed",
                                              value: "${item.billed}",
                                              valueColor:
                                              const Color(0xFF10B981),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 3),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "UnBilled",
                                              value: "${item.unbilled}",
                                              valueColor:
                                              Colors.brown.shade400,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "Over-Billed",
                                              value: "${item.overBilled}",
                                              valueColor: Colors.red,
                                              highlight: isOverBilledFlag,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: CommonIconChip(
                                              title: "Billing %",
                                              value:
                                              "${item.billingPercent}",
                                              valueColor: progressColor,
                                              highlight: progressColor ==
                                                  Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSupplierWise() {
    return materialDashboardController.supplierWiseResponse.value == null
        ? const DashboardErrorWidget()
        : Column(
      children: [
        Obx(
              () => GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: gridInfoCardsSupWise.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
            ),
            itemBuilder: (_, index) {
              return GridInfoCard(
                item: gridInfoCardsSupWise[index],
                index: index,
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Top Suppliers Breakdown",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillRegSupWiseList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillSupWiseViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillRegSupWiseList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return buildSupplierCard(
                      supplierName: item.supplierName!,
                      poValue: "₹ ${item.totalPo!}",
                      billed: "₹ ${item.totalBill!}",
                      overBill: "₹ ${item.overBill!}",
                      billingPercentage: "${item.billingPercent!} %",
                      progress: item.billingPercent!,
                      bottomRight: materialDashboardController
                          .poVsBillSupWiseList[index].variance! ??
                          "-",
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PO Value vs Billed Amount",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillSupWiseList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillSupWiseViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillSupWiseList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No PO data available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return MaterialHeadCard(
                      name: item.supplierName ?? "",
                      poAmount: item.totalPo,
                      billAmount: item.billAmount,
                      type: "ViewAll",
                      varianceLabel: item.variance,
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Supplier Performance",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillSupWiseList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillSupWiseViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillSupWiseList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No suppliers available",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    return MaterialHeadCard(
                      name: item.supplierName ?? "",
                      poAmount: item.totalPo,
                      billAmount: item.billAmount,
                      type: "ViewPercentOnly",
                      variancePercent: item.billingPercent,
                    );
                  },
                );
              })
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Supplier Billing Status",
                style:
                TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Obx(() {
                final poRaised = materialDashboardController
                    .supplierWiseResponse.value?.poRaisedCount
                    ?.toDouble();

                final billIssued = materialDashboardController
                    .supplierWiseResponse.value?.billIssuedCount
                    ?.toDouble();

                final billPending = materialDashboardController
                    .supplierWiseResponse.value?.billPendingCount
                    ?.toDouble();

                final total = poRaised! + billIssued! + billPending!;

                final poPercentage =
                total == 0 ? 0.0 : (poRaised / total) * 100;

                final billIssuedPercentage =
                total == 0 ? 0.0 : (billIssued / total) * 100;

                final billPendingPercentage =
                total == 0 ? 0.0 : (billPending / total) * 100;

                final chartData = [
                  {
                    "name": "PO Raised",
                    "value": poRaised.toDouble(),
                    "percentageText":
                    "${poPercentage.toStringAsFixed(1)}%",
                    "color": const Color(0xff2864E8),
                  },
                  {
                    "name": "Bill Issued",
                    "value": billIssued.toDouble(),
                    "percentageText":
                    "${billIssuedPercentage.toStringAsFixed(1)}%",
                    "color": const Color(0xff10B981),
                  },
                  {
                    "name": "Bill Pending",
                    "value": billPending.toDouble(),
                    "percentageText":
                    "${billPendingPercentage.toStringAsFixed(1)}%",
                    "color": const Color(0xffF59E0B),
                  },
                ];
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            const AnimatedDottedCircle(
                              size: 125,
                            ),
                            OverflowBox(
                              maxWidth: 260,
                              maxHeight: 260,
                              child: SfCircularChart(
                                tooltipBehavior: _tooltipBehavior,
                                margin: EdgeInsets.zero,
                                series: <CircularSeries>[
                                  DoughnutSeries<Map<String, dynamic>,
                                      String>(
                                    dataSource: chartData,
                                    xValueMapper: (item, _) =>
                                    item["name"] as String,
                                    yValueMapper: (item, _) =>
                                    item["value"] as double,
                                    pointColorMapper: (item, _) =>
                                    item["color"] as Color,
                                    innerRadius: '77%',
                                    radius: '75%',
                                    cornerStyle: CornerStyle.bothCurve,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "TOTAL ITEMS",
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.inactiveGray,
                                  ),
                                ),
                                Text(
                                  "${total.toInt()}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: List.generate(
                        chartData.length,
                            (index) {
                          final item = chartData[index];

                          return buildSpendDistributionItem(
                            name: item["name"] as String,
                            amount:
                            "${(item["value"] as double).toInt()}",
                            percentageText: total == 0
                                ? "0%"
                                : "${(((item["value"] as double) / total) * 100).toStringAsFixed(1)}%",
                            percentage: total == 0
                                ? 0
                                : ((item["value"] as double) / total) *
                                100,
                            color: item["color"] as Color,
                            maxPercentage: 100,
                            isMatHead: false,
                            isLast: index == chartData.length - 1,
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.15),
                blurRadius: 8,
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Supplier PO vs Bill Register",
                    style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Obx(
                        () => Visibility(
                      visible: materialDashboardController
                          .poVsBillRegSupWiseList.length >
                          2,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => POVsBillRegSupWiseViewAll(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor
                                .withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "View All",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Obx(() {
                final itemList =
                    materialDashboardController.poVsBillRegSupWiseList;
                if (itemList.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "No register data matches your search",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemList.length > 2 ? 2 : itemList.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = itemList[index];
                    final percentage = item.billingPercent ?? 0.0;
                    final progressColor = materialDashboardController
                        .getProgressColor(percentage);
                    final primaryColor = Theme.of(context).primaryColor;
                    return Container(
                      padding: const EdgeInsets.all(10),
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // ───────── HEADER ROW ─────────
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.supplierName ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.swap_vert_rounded,
                                        color: Colors.grey, size: 20),
                                    const SizedBox(width: 2),
                                    Flexible(
                                      child: Text(
                                        materialDashboardController
                                            .poVsBillSupWiseList[
                                        index]
                                            .variance ??
                                            '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: materialDashboardController
                                                .getVarianceColor(
                                                materialDashboardController
                                                    .poVsBillSupWiseList[
                                                index]
                                                    .variance),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // ───────── METRICS TABLE CONTAINER ─────────
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(
                              //   color: primaryColor.withOpacity(0.25),
                              //   width: 1,
                              // ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  primaryColor.withOpacity(0.02),
                                  primaryColor.withOpacity(0.05),
                                  primaryColor.withOpacity(0.02),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                // TOP ROW (4 Items)
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildItem(
                                        title: "POs",
                                        value: "${item.pOs}",
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "PO Value",
                                        value: "${item.totalPo}",
                                        valueColor: Colors.blueAccent,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Billed",
                                        value: "${item.totalBill}",
                                        valueColor:
                                        const Color(0xFF10B981),
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Approved",
                                        value: "${item.approved}",
                                        valueColor: Colors.brown.shade400,
                                      ),
                                    ),
                                  ],
                                ),

                                // Horizontal Divider
                                Container(
                                  height: 1,
                                  color: Colors.grey.shade300,
                                ),

                                // BOTTOM ROW (3 Items)
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildItem(
                                        title: "Pending",
                                        value: "${item.pending}",
                                        valueColor: Colors.purple,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Over-Bill %",
                                        value: "${item.overBill}",
                                        valueColor: Colors.red,
                                      ),
                                    ),
                                    _buildDivider(),
                                    Expanded(
                                      child: _buildItem(
                                        title: "Billing %",
                                        value: "${item.billingPercent}",
                                        valueColor: progressColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 3),
                        ],
                      ),
                    );
                  },
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 15),

          _buildDashboardShimmerGrid(),

          const SizedBox(height: 15),

          // ───────── SUMMARY CARD ─────────
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 15),

          // ───────── SECOND CARD ─────────
          Container(
            width: double.infinity,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          const SizedBox(height: 20),

          // ───────── SECTION TITLE ─────────
          Container(
            height: 18,
            width: 190,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
          ),

          const SizedBox(height: 12),

          // ───────── BOTTOM CARD ─────────
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade100,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 6, // number of shimmer placeholders
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 10,
          mainAxisExtent: 105, // same as your LabourCard grid
        ),
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
  //Others

  DateTimeRange getRangeForTab(String tab) {
    final now = DateTime.now();

    final int y = now.year;
    final int m = now.month;
    final int d = now.day;

    switch (tab) {
      case "today":
        return DateTimeRange(
          start: DateTime(y, m, d),
          end: DateTime(y, m, d),
        );

      case "week":
      // Monday to Sunday
        final day = now.weekday; // Monday = 1, Sunday = 7

        final from = DateTime(
          y,
          m,
          d - (day - 1),
        );

        final to = from.add(const Duration(days: 6));

        return DateTimeRange(
          start: from,
          end: to,
        );

      case "month":
        return DateTimeRange(
          start: DateTime(y, m, 1),
          end: DateTime(y, m + 1, 0),
        );

      case "quarter":
        final quarter = ((m - 1) ~/ 3);

        final startMonth = quarter * 3 + 1;

        return DateTimeRange(
          start: DateTime(y, startMonth, 1),
          end: DateTime(y, startMonth + 3, 0),
        );

      case "fy":
      // April 1 -> March 31
        final startYear = m >= 4 ? y : y - 1;

        return DateTimeRange(
          start: DateTime(startYear, 4, 1),
          end: DateTime(startYear + 1, 3, 31),
        );

      case "lastfy":
        final currentFYStartYear = m >= 4 ? y : y - 1;
        final startYear = currentFYStartYear - 1;

        return DateTimeRange(
          start: DateTime(startYear, 4, 1),
          end: DateTime(startYear + 1, 3, 31),
        );

      default:
        return DateTimeRange(
          start: DateTime(y, m, 1),
          end: DateTime(y, m + 1, 0),
        );
    }
  }

  String formatDate(DateTime date) {
    return DateFormat("dd-MM-yyyy").format(date);
  }

  String formatRangeLabel(DateTime from, DateTime to) {
    return "${DateFormat("d MMM yyyy").format(from)} – "
        "${DateFormat("d MMM yyyy").format(to)}";
  }

  Future<void> selectFilterTab(String tab) async {
    final range = getRangeForTab(tab);

    // ----------------------------------------
    // CHANGE SELECTED BUTTON IMMEDIATELY
    // ----------------------------------------
    setState(() {
      activeFilterTab = tab;

      materialDashboardController.entryFromDate.text =
          formatDate(range.start);

      materialDashboardController.entryToDate.text =
          formatDate(range.end);

      rangeLabel = formatRangeLabel(
        range.start,
        range.end,
      );
    });

    // ----------------------------------------
    // START API AFTER CURRENT FRAME
    // ----------------------------------------
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (materialDashboardController.selectedTab.value == 0) {
        await materialDashboardController
            .getMatProjWiseDashboardDetails();
      } else if (materialDashboardController.selectedTab.value == 1) {
        await materialDashboardController
            .getMatHeadDashboardDetails();
      } else {
        await materialDashboardController
            .getSupWiseDashboardDetails();
      }
    });
  }

  void resetDateToToday() {
    final today = DateTime.now();

    materialDashboardController.entryFromDate.text = formatDate(today);

    materialDashboardController.entryToDate.text = formatDate(today);

    rangeLabel = formatRangeLabel(today, today);

    activeFilterTab = "today";
  }

  Widget durationFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "DURATION",
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
                color: Color(0xff667085),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: filterTabs.map((tab) {
                    final key = tab["key"]!;
                    final label = tab["label"]!;

                    final isSelected =
                        activeFilterTab == key;

                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,

                      onTap: () {
                        if (activeFilterTab == key) {
                          return;
                        }

                        selectFilterTab(key);
                      },

                      child: Container(
                        margin: const EdgeInsets.only(
                          right: 6,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,

                          borderRadius:
                          BorderRadius.circular(20),

                          boxShadow: isSelected
                              ? [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ]
                              : null,
                        ),
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff475467),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        customDateFilter(),
      ],
    );
  }

  Widget customDateFilter() {
    return Row(
      children: [
        const Text(
          "CUSTOM RANGE",
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: Color(0xff667085),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _compactDateField(
            controller: materialDashboardController.entryFromDate,
            onTap: () => selectCustomFromDate(),
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.arrow_forward,
          size: 15,
          color: Color(0xff98A2B3),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: _compactDateField(
            controller: materialDashboardController.entryToDate,
            onTap: () => selectCustomToDate(),
          ),
        ),
      ],
    );
  }

  Widget _compactDateField(
      {required TextEditingController controller,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xffD0D5DD),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                controller.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff344054),
                ),
              ),
            ),
            const Icon(
              Icons.calendar_today_outlined,
              size: 13,
              color: Color(0xff98A2B3),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectCustomFromDate() async {
    final date = await showDatePicker(
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
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        activeFilterTab = "custom";

        materialDashboardController.entryFromDate.text =
            date.toString().substring(0, 10);

        updateCustomRangeLabel();
      });
    }
  }

  Future<void> selectCustomToDate() async {
    final date = await showDatePicker(
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
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() {
        activeFilterTab = "custom";

        materialDashboardController.entryToDate.text =
            date.toString().substring(0, 10);

        updateCustomRangeLabel();
      });
    }
  }

  void updateCustomRangeLabel() {
    try {
      final from = DateFormat("dd-MM-yyyy").parse(
        materialDashboardController.entryFromDate.text,
      );

      final to = DateFormat("dd-MM-yyyy").parse(
        materialDashboardController.entryToDate.text,
      );

      rangeLabel = formatRangeLabel(from, to);
    } catch (_) {
      rangeLabel = "";
    }
  }

  List<GreetingCardModel> get greetingCards {
    final data = materialDashboardController.projectWiseResponse.value?.result;

    return [
      GreetingCardModel(
        title: "ACTIVE PROJECTS",
        value: "${data?.activeprojectCounts ?? 0}",
        icon: Icons.account_tree,
      ),
      GreetingCardModel(
        title: "SUPPLIERS",
        value: "${data?.activeSuppliers ?? 0}",
        icon: Icons.local_shipping,
      ),
      GreetingCardModel(
        title: "MATERIAL HEADS",
        value: "${data?.activeMaterialHeads ?? 0}",
        icon: Icons.layers_outlined,
      ),
    ];
  }

  List<GreetingCardModel> get gridInfoCardsProjWise {
    final data = materialDashboardController.projectWiseResponse.value?.result;

    return [
      GreetingCardModel(
          title: "TOTAL PO VALUE",
          subtitle: "${data?.activeprojectCounts ?? 0} Active Projects",
          value: "₹ ${data?.poTotalValue ?? 0}",
          icon: Icons.content_copy_rounded,
          color: Colors.blueAccent),
      GreetingCardModel(
          title: "TOTAL BILLED",
          subtitle: "Bills Received",
          value: "₹ ${data?.totalBilledAmount ?? 0}",
          icon: Icons.poll_outlined,
          color: Colors.green),
      GreetingCardModel(
          title: "UNBILLED AMOUNT",
          subtitle: "Yet to be Billed",
          value: "₹ ${data?.unBilledAmount ?? 0}",
          icon: Icons.description_outlined,
          color: Colors.orange),
      GreetingCardModel(
          title: "OVER-BILLED",
          subtitle: "Bills Exceed PO",
          value: "₹ ${data?.overBilledAmount ?? 0}",
          icon: Icons.lock,
          color: Colors.pink),
      GreetingCardModel(
          title: "BILLS APPROVED",
          subtitle: "Ready for Payment",
          value: "₹ ${data?.totalBillApproved ?? 0}",
          icon: Icons.check_circle,
          color: Colors.deepPurpleAccent),
      GreetingCardModel(
          title: "BILLS PENDING",
          subtitle: "Under Review",
          value: "₹ ${data?.totalBillPending ?? 0}",
          icon: Icons.access_time_filled,
          color: Colors.red)
    ];
  }

  List<GreetingCardModel> get gridInfoCardsMatHead {
    final data = materialDashboardController.materialHeadResponse.value?.result;

    return [
      GreetingCardModel(
          title: "ACTIVE HEADS",
          subtitle: "Material head types",
          value: "${data?.activeMaterialHeadCount ?? 0}",
          icon: Icons.business,
          color: const Color(0xff2563EB)),
      GreetingCardModel(
          title: "HIGHEST NET AMOUNT",
          subtitle: data?.highestMatHead ?? "",
          value: "₹ ${data?.highestTotalNetAmount ?? 0}",
          icon: Icons.money,
          color: const Color(0xff16A34A)),
      GreetingCardModel(
          title: "OVER-BILLED HEADS",
          subtitle: "Heads exceeding PO",
          value: "${data?.overBilledMaterialHeadCount ?? 0}",
          icon: Icons.warning,
          color: const Color(0xffF43F5E)),
      GreetingCardModel(
          title: "AVG BILLING %",
          subtitle: "Across all heads",
          value: "${data?.avgBillPercent ?? 0}",
          icon: Icons.percent,
          color: const Color(0xff2563EB)),
      GreetingCardModel(
          title: "PENDING BILL",
          subtitle: "Yet to be approved",
          value: "₹ ${data?.pendingBillAmount ?? 0}",
          icon: Icons.request_quote,
          color: const Color(0xff16A34A)),
      GreetingCardModel(
          title: "BEST BILLED HEAD",
          subtitle: data?.mostMatchingHead ?? "",
          value: "${data?.mostMatchingHeadPercentage ?? 0}",
          icon: Icons.star,
          color: const Color(0xffE11D48))
    ];
  }

  List<GreetingCardModel> get gridInfoCardsSupWise {
    final data = materialDashboardController.supplierWiseResponse.value?.result;

    return [
      GreetingCardModel(
          title: "ACTIVE SUPPLIERS",
          subtitle: "Suppliers with POs",
          value: "${data?.activeSuppliers ?? 0}",
          icon: FontAwesomeIcons.usersGear,
          color: const Color(0xFF2563EB)),
      GreetingCardModel(
        title: "TOTAL PO VALUE",
        subtitle: "Across all suppliers",
        value: "₹ ${data?.poTotalValue ?? 0}",
        icon: FontAwesomeIcons.fileInvoice,
        color: const Color(0xFF2563EB),
      ),
      GreetingCardModel(
        title: "TOTAL BILLED",
        subtitle: "Bills received",
        value: "₹ ${data?.totalBilledAmount ?? 0}",
        icon: FontAwesomeIcons.handHoldingDollar,
        color: const Color(0xFF059669),
      ),
      GreetingCardModel(
        title: "OVER-BILLED SUPPLIERS",
        subtitle: "Suppliers exceeding PO",
        value: "${data?.overBilledCount ?? 0}",
        icon: FontAwesomeIcons.userXmark,
        color: const Color(0xFFE11D48),
      ),
      GreetingCardModel(
        title: "AVG BILLING %",
        subtitle: "Across all suppliers",
        value: "${data?.avgBillPercentage ?? 0}",
        icon: FontAwesomeIcons.percent,
        color: const Color(0xFFF59E0B),
      ),
      GreetingCardModel(
        title: "PENDING BILL",
        subtitle: "Yet to be approved",
        value: "₹ ${data?.pendingBillAmount ?? 0}",
        icon: FontAwesomeIcons.hourglassHalf,
        color: const Color(0xFF2563EB),
      )
    ];
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 45,
      color: Colors.grey.shade300,
    );
  }

  Widget _buildItem({
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: (valueColor ?? Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSpendDistributionItem(
      {required String name,
        required String amount,
        required String percentageText,
        required double percentage,
        required Color color,
        required double maxPercentage,
        bool isMatHead = false,
        bool isLast = false}) {
    final progress =
    maxPercentage == 0 ? 0.0 : (percentage / maxPercentage).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 4,
      ),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
          bottom: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Dot
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 8),

          // Name + percentage
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  percentageText,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Progress
          Expanded(
            flex: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                backgroundColor: const Color(0xFFF0F3F7),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Amount
          SizedBox(
            width: 62,
            child: Text(
              amount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: isMatHead == true ? TextAlign.right : TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpendSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    required String subValue,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF7F9FC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffE3E7ED),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: const Color(0xff4F5FE8),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (subValue.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 0,
                        child: Text(
                          subValue,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff4F5FE8),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSupplierCard({
    required String supplierName,
    required String poValue,
    required String billed,
    required String overBill,
    required String billingPercentage,
    required double progress,
    required String bottomRight,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= HEADER =================
          Row(
            children: [
              Container(
                width: 35,
                height: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: materialDashboardController.getProgressColor(progress),
                ),
                child: Text(
                  supplierName.isNotEmpty ? supplierName[0].toUpperCase() : "S",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  supplierName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF17213A),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Over-Billed",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFF04444),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // ================= AMOUNTS =================
          Row(
            children: [
              Expanded(
                child: _buildAmountBox(
                  title: "PO Value",
                  value: poValue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAmountBox(
                  title: "Billed",
                  value: billed,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildAmountBox(
                  title: "Over-Bill",
                  value: overBill,
                  isOverBill: true,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ================= BILLING COMPLETION =================
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: materialDashboardController.getProgressColor(progress),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              const Expanded(
                child: Text(
                  "Billing Completion",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF7B8495),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                billingPercentage,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: materialDashboardController.getProgressColor(progress),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // ================= PROGRESS BAR =================
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 7,
              backgroundColor: const Color(0xFFF5F1F1),
              valueColor: AlwaysStoppedAnimation<Color>(
                materialDashboardController.getProgressColor(progress),
              ),
            ),
          ),

          const SizedBox(height: 9),

          // ================= BOTTOM =================
          Text(
            bottomRight,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountBox({
    required String title,
    required String value,
    bool isOverBill = false,
  }) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isOverBill ? const Color(0xFFFFF1F2) : const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isOverBill
                    ? const Color(0xFFF04444)
                    : const Color(0xFF17213A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MaterialHomeScreen extends StatefulWidget {
  final bool isMaterial;
  const MaterialHomeScreen({
    super.key,
    this.isMaterial = false,
  });

  @override
  State<MaterialHomeScreen> createState() => _MaterialHomeScreenState();
}

class GreetingCardModel {
  final String? title;
  final String? value;
  final IconData? icon;
  final String? subtitle;
  final Color? color;

  GreetingCardModel({
    this.title,
    this.value,
    this.icon,
    this.subtitle,
    this.color,
  });
}

class GreetingCard extends StatelessWidget {
  final GreetingCardModel item;
  final int index;

  const GreetingCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final double apiValue = double.tryParse(item.value ?? '0') ?? 0.0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Icon Box
        Container(
          height: 40,
          width: 38,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.icon,
            color: Colors.white,
            size: 18,
          ),
        ),

        const SizedBox(width: 8),

        /// Text Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 18,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: apiValue,
                    ),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeOutCubic,
                    builder: (
                        BuildContext context,
                        double animatedValue,
                        Widget? child,
                        ) {
                      return Text(
                        animatedValue.toStringAsFixed(
                          apiValue % 1 == 0 ? 0 : 2,
                        ),
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
              // Text(
              //   item.value!,
              //   maxLines: 2,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(
              //     fontSize: 15,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
              const SizedBox(height: 4),
              Text(
                item.title!.toUpperCase(),
                maxLines: 2,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white.withOpacity(.9),
                  fontWeight: FontWeight.w700,
                  letterSpacing: .3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridInfoCard extends StatelessWidget {
  final GreetingCardModel item;
  final int index;

  const GridInfoCard({
    super.key,
    required this.item,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON + TITLE
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: item.color!.withOpacity(.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item.icon,
                  color: item.color,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  item.title!.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .3,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// VALUE
          // FittedBox(
          //   fit: BoxFit.scaleDown,
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     item.value!,
          //     maxLines: 1,
          //     style: const TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 18,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 0,
                  end: parseAnimatedValue(item.value!),
                ),
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeOutCubic,
                builder: (
                    BuildContext context,
                    double animatedValue,
                    Widget? child,
                    ) {
                  String displayValue;

                  final originalValue =
                  item.value?.replaceAll("₹", "").trim().toUpperCase();

                  if (originalValue!.endsWith("CR")) {
                    displayValue = "₹ ${animatedValue.toStringAsFixed(2)} CR";
                  } else if (originalValue!.endsWith("L")) {
                    displayValue = "₹ ${animatedValue.toStringAsFixed(2)} L";
                  } else {
                    displayValue = animatedValue.toInt().toString();

                    if (item.value!.contains("₹")) {
                      displayValue = "₹ $displayValue";
                    }
                  }

                  return Text(
                    displayValue,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),

          /// SUBTITLE
          Text(
            item.subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  double parseAnimatedValue(String value) {
    String cleanValue =
    value.replaceAll("₹", "").replaceAll(",", "").trim().toUpperCase();

    if (cleanValue.endsWith("CR")) {
      return double.tryParse(
        cleanValue.replaceAll("CR", "").trim(),
      ) ??
          0;
    }

    if (cleanValue.endsWith("L")) {
      return double.tryParse(
        cleanValue.replaceAll("L", "").trim(),
      ) ??
          0;
    }

    return double.tryParse(cleanValue) ?? 0;
  }
}

class SegmentedProgressBar extends StatelessWidget {
  final double progress; // 0 to 1
  final int totalSegments;
  final Color activeColor;
  final Color inactiveColor;
  final double height;
  final double spacing;
  final double radius;

  const SegmentedProgressBar({
    super.key,
    required this.progress,
    this.totalSegments = 34,
    this.activeColor = const Color(0xff7381e8),
    this.inactiveColor = const Color(0xffE8EBFF),
    this.height = 18,
    this.spacing = 4,
    this.radius = 4,
  });

  @override
  Widget build(BuildContext context) {
    final activeSegments = (progress * totalSegments).round();

    return Row(
      children: List.generate(
        totalSegments * 2 - 1,
            (index) {
          if (index.isOdd) {
            return SizedBox(width: spacing);
          }

          final segmentIndex = index ~/ 2;

          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: height,
              decoration: BoxDecoration(
                color:
                segmentIndex < activeSegments ? activeColor : inactiveColor,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChevronProgressIndicator extends StatelessWidget {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;
  final int segments;

  const ChevronProgressIndicator({
    super.key,
    required this.progress,
    required this.activeColor,
    this.inactiveColor = const Color(0xFFE5E7EB),
    this.segments = 16,
  });

  @override
  Widget build(BuildContext context) {
    final value = progress.clamp(0.0, 1.0);

    final completedSegments = (value * segments).round();

    return SizedBox(
      height: 28,
      child: Row(
        children: List.generate(
          segments,
              (index) {
            final isActive = index < completedSegments;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 2),
                child: CustomPaint(
                  size: const Size(18, 16),
                  painter: ChevronPainter(
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChevronPainter extends CustomPainter {
  final Color color;

  ChevronPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width * 0.65, 0);

    path.lineTo(size.width, size.height / 2);

    path.lineTo(size.width * 0.65, size.height);

    path.lineTo(0, size.height);

    path.lineTo(size.width * 0.35, size.height / 2);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ChevronPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class MaterialHeadCard extends StatelessWidget {
  final String name;
  final dynamic poAmount;
  final dynamic billAmount;
  final String? type;
  final String? varianceLabel;
  final String? variancePercent;

  MaterialHeadCard(
      {super.key,
        required this.name,
        required this.poAmount,
        required this.billAmount,
        this.type,
        this.varianceLabel,
        this.variancePercent});
  MaterialDashboardController materialDashboardController =
  Get.put(MaterialDashboardController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
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
            type == "ViewAll"
                ? Row(
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
                      name.isNotEmpty
                          ? name.substring(0, 1).toUpperCase()
                          : "",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "PO: ₹$poAmount",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "$varianceLabel",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: materialDashboardController
                              .getVarianceColor(varianceLabel),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Bill: ₹$billAmount",
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : type == "ViewPercentOnly"
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      name.isNotEmpty
                          ? name.substring(0, 1).toUpperCase()
                          : "",
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        variancePercent == null
                            ? "-"
                            : "${double.tryParse(
                          variancePercent!
                              .replaceAll("%", "")
                              .trim(),
                        )?.toStringAsFixed(2) ?? "0.00"} %",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: materialDashboardController
                              .getProgressColor(
                            double.tryParse(
                              variancePercent!
                                  .replaceAll("%", "")
                                  .trim(),
                            ) ??
                                0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : Row(
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
                      name.isNotEmpty
                          ? name.substring(0, 1).toUpperCase()
                          : "",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 8),
                      type != "Variance"
                          ? Text(
                        "PO: ₹$poAmount",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                          : Text(
                        "$varianceLabel",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: materialDashboardController
                              .getVarianceColor(varianceLabel),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                if (type != "Variance")
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Bill: ₹$billAmount",
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 13),
            SegmentedProgressBar(
              progress: materialDashboardController.getProgress(
                billAmount,
                poAmount,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ));
  }
}

class CommonIconChip extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;
  final bool highlight;

  const CommonIconChip({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color chipValueColor = valueColor ?? Colors.black;

    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: const Color(0xffD0D5DD),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: chipValueColor,
                ),
              ),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDottedCircle extends StatefulWidget {
  final double size;

  const AnimatedDottedCircle({
    super.key,
    this.size = 145,
  });

  @override
  State<AnimatedDottedCircle> createState() => _AnimatedDottedCircleState();
}

class _AnimatedDottedCircleState extends State<AnimatedDottedCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: DottedCirclePainter(),
      ),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD1DCEB)
      ..style = PaintingStyle.fill;

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius = size.width / 2 - 3;

    const dotCount = 45;

    for (int i = 0; i < dotCount; i++) {
      final angle = (2 * pi / dotCount) * i;

      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);

      canvas.drawCircle(
        Offset(x, y),
        2.2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
