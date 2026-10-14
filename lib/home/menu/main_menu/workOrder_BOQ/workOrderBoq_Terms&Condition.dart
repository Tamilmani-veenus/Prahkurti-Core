import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prahkurticore/controller/workOrderBoq_Controller.dart';
import 'package:prahkurticore/models/termsandCondition_model.dart';
import 'package:prahkurticore/utilities/requestconstant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../../../../utilities/baseutitiles.dart';

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({super.key});

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  WorkOrderBoqController workOrderBoqController =
      Get.put(WorkOrderBoqController());

  final TextEditingController searchController = TextEditingController();

  Set<int> selectedIds = <int>{};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    loadTerms();
  }

  Future<void> loadTerms() async {
    await workOrderBoqController.WorkOrdBoq_TermsCondition();

    if (!mounted) return;

    setState(() {
      selectedIds.clear();
      selectAll = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: SizedBox(
        width: 850,
        height: 520,
        child: Column(
          children: [
            /// Header
            Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.description, color: Colors.white),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      "Select Terms & Conditions",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close,
                          size: 18, color: Colors.white))
                ],
              ),
            ),

            /// Search & Buttons
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: searchController,
                        style: TextStyle(fontSize: 11, color: Colors.black),
                        onChanged: (value) {
                          workOrderBoqController.searchTerms(value);
                        },
                        decoration: InputDecoration(
                          hintText: "Search",
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 13,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .primaryColor, // Change to your desired color
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      for (final item
                          in workOrderBoqController.filteredTermsAndCondition) {
                        if (selectedIds.contains(item.id)) {
                          if (!workOrderBoqController.selectedTerms
                              .any((e) => e.id == item.id)) {
                            workOrderBoqController.selectedTerms.add(item);
                          }
                        }
                      }
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(
                      Icons.add,
                      size: 10,
                    ),
                    label: const Text(
                      "Add Selected",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const StageWiseTermsDialog(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    icon: const Icon(Icons.settings, size: 11),
                    label:
                        const Text("View All", style: TextStyle(fontSize: 10)),
                  )
                ],
              ),
            ),

            /// Table
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    /// Header
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FixedColumnWidth(40),
                        1: FlexColumnWidth(),
                        2: FixedColumnWidth(55),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "S.No",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Checkbox(
                                  value: selectAll,
                                  checkColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      selectAll = value ?? false;

                                      if (selectAll) {
                                        selectedIds.addAll(
                                            workOrderBoqController
                                                .filteredTermsAndCondition
                                                .map((e) => e.id!));
                                      } else {
                                        selectedIds.removeAll(
                                            workOrderBoqController
                                                .filteredTermsAndCondition
                                                .map((e) => e.id!));
                                      }
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Expanded(
                      child: Obx(
                        () => ListView.builder(
                          itemCount: workOrderBoqController
                              .filteredTermsAndCondition.length,
                          itemBuilder: (context, index) {
                            final item = workOrderBoqController
                                .filteredTermsAndCondition[index];

                            final bool isAdded = workOrderBoqController
                                .selectedTerms
                                .any((e) => e.id == item.id);

                            return Table(
                              border: TableBorder(
                                left: BorderSide(color: Colors.grey.shade300),
                                right: BorderSide(color: Colors.grey.shade300),
                                bottom: BorderSide(color: Colors.grey.shade300),
                                verticalInside:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              columnWidths: const {
                                0: FixedColumnWidth(40),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(55),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: RichText(
                                        text: TextSpan(
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                          children: [
                                            TextSpan(
                                              text:
                                                  item.termsAndCondition ?? "",
                                            ),
                                            if (isAdded)
                                              const TextSpan(
                                                text: "  (Added)",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: IgnorePointer(
                                        ignoring: isAdded,
                                        child: Opacity(
                                          opacity: isAdded ? 0.2 : 1.0,
                                          child: Checkbox(
                                            activeColor: Theme.of(context)
                                                .primaryColor, // Checkbox background when checked
                                            checkColor: Colors.white,
                                            value: isAdded
                                                ? true
                                                : selectedIds.contains(item.id),
                                            onChanged: isAdded
                                                ? null
                                                : (v) {
                                                    setState(() {
                                                      if (v == true) {
                                                        selectedIds
                                                            .add(item.id!);
                                                      } else {
                                                        selectedIds
                                                            .remove(item.id);
                                                      }
                                                    });
                                                  },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      for (final item
                          in workOrderBoqController.filteredTermsAndCondition) {
                        if (selectedIds.contains(item.id)) {
                          if (!workOrderBoqController.selectedTerms
                              .any((e) => e.id == item.id)) {
                            workOrderBoqController.selectedTerms.add(item);
                          }
                        }
                      }
                      // for (int i = 0; i < selected.length; i++) {
                      //   if (selected[i]) {
                      //     final item = workOrderBoqController.termsAndCondition[i];
                      //
                      //     // Prevent duplicates
                      //     if (!workOrderBoqController.selectedTerms
                      //         .any((e) => e.id == item.id)) {
                      //       workOrderBoqController.selectedTerms.add(item);
                      //     }
                      //   }
                      // }

                      Navigator.pop(context); // Close dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      "Add Selected",
                      style: TextStyle(fontSize: 10),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class StageWiseTermsDialog extends StatefulWidget {
  const StageWiseTermsDialog({super.key});

  @override
  State<StageWiseTermsDialog> createState() => _StageWiseTermsDialogState();
}

class _StageWiseTermsDialogState extends State<StageWiseTermsDialog>
    with SingleTickerProviderStateMixin {
  bool isActive = true;
  bool isEdit = false;
  int editId = 0;
  final TextEditingController termsController = TextEditingController();
  WorkOrderBoqController workOrderBoqController =
      Get.put(WorkOrderBoqController());
  final TextEditingController searchController = TextEditingController();
  final ScrollController verticalController = ScrollController();
  final ScrollController newverticalController = ScrollController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 850,
        height: workOrderBoqController.tempTerms.length >= 1 ? 480 : 400,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              /// Header
              Container(
                height: 55,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.description,
                        color: Colors.white, size: 18),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Stage-wise Terms & Conditions",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              TabBar(
                controller: _tabController,
                indicatorColor: Color(0xff1E4BE9),
                labelColor: Color(0xff1E4BE9),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    height: 35,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.add,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text("New"),
                      ],
                    ),
                  ),
                  Tab(
                    height: 35,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.list,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text("List"),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    /// NEW TAB
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(text: "Terms & Conditions "),
                                  TextSpan(
                                    text: "*",
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextField(
                                  cursorColor: Colors.black,
                                  controller: termsController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText: "Enter terms and conditions...",
                                    hintStyle: TextStyle(fontSize: 14),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text(isActive ? "Active" : "Inactive"),
                                  //     Switch(
                                  //       value: isActive,
                                  //       activeColor:
                                  //       Colors.white,
                                  //       activeTrackColor:
                                  //       Colors.green,
                                  //       onChanged: (v) {
                                  //         setState(() {
                                  //           isActive = v;
                                  //         });
                                  //       },
                                  //     ),
                                  //   ],
                                  // ),
                                  FlutterSwitch(
                                    width: 85,
                                    height: 36,
                                    toggleSize: 20,
                                    value: isActive,
                                    borderRadius: 20,
                                    padding: 4,
                                    activeColor: Colors.green,
                                    inactiveColor: Colors.red,
                                    activeText: "Active",
                                    inactiveText: "Inactive",
                                    showOnOff: true,
                                    activeTextColor: Colors.white,
                                    inactiveTextColor: Colors.white,
                                    activeTextFontWeight: FontWeight.w600,
                                    inactiveTextFontWeight: FontWeight.w600,
                                    onToggle: (value) {
                                      setState(() {
                                        isActive = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 10),
                                  isEdit
                                      ? SizedBox()
                                      : SizedBox(
                                          width: 90,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              if (termsController.text
                                                  .trim()
                                                  .isEmpty) {
                                                BaseUtitiles.showToast(
                                                    "Enter Terms & Conditions");
                                                return;
                                              }
                                              workOrderBoqController.tempTerms
                                                  .add(
                                                Result(
                                                    id: 0,
                                                    termsAndCondition:
                                                        termsController.text
                                                            .trim(),
                                                    active: isActive,
                                                    createdDt: BaseUtitiles
                                                        .initiateCurrentDateFormat(),
                                                    createdBy: 0),
                                              );
                                              termsController.clear();
                                              isActive = true;
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            label: const Text("New"),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                              foregroundColor: Colors.white,
                                            ),
                                          ),
                                        )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                // Header
                                Table(
                                  border: TableBorder.all(
                                      color: Colors.grey.shade300),
                                  columnWidths: const {
                                    0: FixedColumnWidth(40),
                                    1: FlexColumnWidth(),
                                    2: FixedColumnWidth(75),
                                    3: FixedColumnWidth(55),
                                  },
                                  children: [
                                    TableRow(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 14, horizontal: 6),
                                          child: Center(
                                            child: Text(
                                              "S.No",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              "Terms & Conditions",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              "Status",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              "Action",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                Expanded(
                                  child: workOrderBoqController
                                          .tempTerms.isEmpty
                                      ? const SizedBox()
                                      : ScrollbarTheme(
                                          data: ScrollbarThemeData(
                                            thumbColor:
                                                MaterialStateProperty.all(
                                              Colors.grey.shade400,
                                            ),
                                            trackColor:
                                                MaterialStateProperty.all(
                                              Colors.grey.shade200,
                                            ),
                                            trackBorderColor:
                                                MaterialStateProperty.all(
                                              Colors.transparent,
                                            ),
                                            thickness:
                                                MaterialStateProperty.all(6),
                                            radius: const Radius.circular(10),
                                          ),
                                          child: Scrollbar(
                                            controller: newverticalController,
                                            thumbVisibility: true,
                                            trackVisibility: true,
                                            thickness: 6,
                                            child: ListView.builder(
                                              controller: newverticalController,
                                              itemCount: workOrderBoqController
                                                  .tempTerms.length,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    workOrderBoqController
                                                        .tempTerms[index];

                                                return Table(
                                                  border: TableBorder(
                                                    left: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                    right: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                    bottom: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                    verticalInside: BorderSide(
                                                        color: Colors
                                                            .grey.shade300),
                                                  ),
                                                  columnWidths: const {
                                                    0: FixedColumnWidth(40),
                                                    1: FlexColumnWidth(),
                                                    2: FixedColumnWidth(75),
                                                    3: FixedColumnWidth(55),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Center(
                                                            child: Text(
                                                              "${index + 1}",
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Text(
                                                            item.termsAndCondition ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: Container(
                                                            width: 80,
                                                            margin:
                                                                const EdgeInsets
                                                                    .all(6),
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        6),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: item.active ==
                                                                      true
                                                                  ? Colors.green
                                                                      .shade100
                                                                  : Colors.red
                                                                      .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                item.active ==
                                                                        true
                                                                    ? "Active"
                                                                    : "Inactive",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 13,
                                                                  color: item.active ==
                                                                          true
                                                                      ? Colors
                                                                          .green
                                                                          .shade700
                                                                      : Colors
                                                                          .red
                                                                          .shade700,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Center(
                                                          child: IconButton(
                                                            icon: const Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              color: Colors.red,
                                                              size: 20,
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                workOrderBoqController
                                                                    .tempTerms
                                                                    .removeAt(
                                                                        index);
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              isEdit
                                  ? OutlinedButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          isEdit = false;
                                          editId = 0;
                                          termsController.clear();
                                          isActive = true;
                                          _tabController.animateTo(0);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_outlined,
                                        color: Colors.black54,
                                        size: 20,
                                      ),
                                      label: const Text(
                                        "Back",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    )
                                  : OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.grey.shade700,
                                        side: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1.2,
                                        ),
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                          vertical: 7,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          termsController.clear();
                                          workOrderBoqController.tempTerms
                                              .clear();
                                        });
                                      },
                                      icon: const Icon(Icons.clear,
                                          color: Colors.black54),
                                      label: const Text(
                                        "Clear",
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  side: BorderSide(
                                    width: 1.2,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () async {
                                  if (isEdit) {
                                    // Update API
                                    bool success = await workOrderBoqController
                                        .SaveTermsAndCondition(
                                            [
                                          Result(
                                            id: editId,
                                            termsAndCondition:
                                                termsController.text.trim(),
                                            active: isActive,
                                            createdBy: 0,
                                            createdDt: BaseUtitiles
                                                .initiateCurrentDateFormat(),
                                          )
                                        ],
                                            workOrderBoqController
                                                    .saveButton.value =
                                                RequestConstant.RESUBMIT);

                                    if (success) {
                                      await workOrderBoqController
                                          .WorkOrdBoq_TermsCondition();

                                      setState(() {
                                        isEdit = false;
                                        editId = 0;
                                        termsController.clear();
                                        isActive = true;
                                      });

                                      _tabController.animateTo(1);
                                    }
                                  } else {
                                    if (workOrderBoqController
                                        .tempTerms.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Alert"),
                                          content: const Text(
                                            'Please add at least one term using the "New" button.',
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("OK"),
                                            ),
                                          ],
                                        ),
                                      );

                                      return;
                                    }

                                    bool success = await workOrderBoqController
                                        .SaveTermsAndCondition(
                                      workOrderBoqController.tempTerms,
                                      workOrderBoqController.saveButton.value =
                                          RequestConstant.SUBMIT,
                                    );

                                    if (success) {
                                      await workOrderBoqController
                                          .WorkOrdBoq_TermsCondition();

                                      // Clear temporary list
                                      workOrderBoqController.tempTerms.clear();

                                      // Switch to List tab
                                      _tabController.animateTo(1);

                                      setState(() {});
                                    }
                                  }
                                },
                                icon: Icon(
                                  isEdit ? Icons.edit : Icons.save,
                                  size: 20,
                                ),
                                label: Text(
                                  isEdit ? "Update" : "Save",
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    /// LIST TAB
                    Obx(() {
                      return Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Search : "),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: TextField(
                                    cursorColor: Colors.black,
                                    controller: searchController,
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.black),
                                    onChanged: (value) {
                                      workOrderBoqController.searchTerms(value);
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Type Something...",
                                      hintStyle: TextStyle(fontSize: 13),
                                      isDense: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 12,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey
                                              .shade400, // Change to your desired color
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Header
                            Table(
                              border: TableBorder.all(
                                  color: Colors.grey.shade300, width: 1),
                              columnWidths: const {
                                0: FixedColumnWidth(40),
                                1: FlexColumnWidth(),
                                2: FixedColumnWidth(85),
                                3: FixedColumnWidth(70),
                              },
                              children: [
                                TableRow(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "S\nNO",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "TERMS & CONDITIONS",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "ACTIVE",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                        child: Text(
                                          "ACTION",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Expanded(
                              child: ScrollbarTheme(
                                data: ScrollbarThemeData(
                                  thumbColor: MaterialStateProperty.all(
                                    Colors.grey.shade500,
                                  ),
                                  trackColor: MaterialStateProperty.all(
                                    Colors.grey.shade200,
                                  ),
                                  trackBorderColor: MaterialStateProperty.all(
                                    Colors.transparent,
                                  ),
                                  thickness: MaterialStateProperty.all(6),
                                  radius: const Radius.circular(10),
                                ),
                                child: Scrollbar(
                                  controller: verticalController,
                                  thumbVisibility: true,
                                  trackVisibility: true,
                                  thickness: 6,
                                  child: ListView.builder(
                                    controller: verticalController,
                                    itemCount: workOrderBoqController
                                        .filteredTermsAndCondition.length,
                                    itemBuilder: (context, index) {
                                      final item = workOrderBoqController
                                          .filteredTermsAndCondition[index];

                                      return Table(
                                        border: TableBorder(
                                          left: BorderSide(
                                              color: Colors.grey.shade300),
                                          right: BorderSide(
                                              color: Colors.grey.shade300),
                                          bottom: BorderSide(
                                              color: Colors.grey.shade300),
                                          verticalInside: BorderSide(
                                              color: Colors.grey.shade300),
                                        ),
                                        columnWidths: const {
                                          0: FixedColumnWidth(40),
                                          1: FlexColumnWidth(),
                                          2: FixedColumnWidth(85),
                                          3: FixedColumnWidth(70),
                                        },
                                        children: [
                                          TableRow(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Center(
                                                  child: Text(
                                                    "${index + 1}",
                                                    style: const TextStyle(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  item.termsAndCondition ?? "",
                                                  style: const TextStyle(
                                                      fontSize: 13),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Center(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 4),
                                                    decoration: BoxDecoration(
                                                      color: item.active == true
                                                          ? Colors
                                                              .green.shade100
                                                          : Colors.red.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: Text(
                                                      item.active == true
                                                          ? "Active"
                                                          : "Inactive",
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            item.active == true
                                                                ? Colors.green
                                                                : Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        isEdit = true;
                                                        editId = item.id ?? 0;
                                                        termsController.text =
                                                            item.termsAndCondition ??
                                                                "";
                                                        isActive =
                                                            item.active ??
                                                                false;

                                                        _tabController
                                                            .animateTo(0);

                                                        setState(() {});
                                                      },
                                                      child: const Icon(
                                                        Icons.edit_outlined,
                                                        color: Colors.blue,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        workOrderBoqController
                                                            .DeleteAlert(
                                                                context,
                                                                item.id!,
                                                                "Terms");
                                                      },
                                                      child: const Icon(
                                                        Icons.delete_outline,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
