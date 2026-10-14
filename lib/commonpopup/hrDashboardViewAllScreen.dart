import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prahkurticore/controller/hrDashboard_controller.dart';
import '../models/hrDashboardCardsRes.dart';
import '../models/hr_Dashboard_Response.dart';
import '../models/onclick_pendinglist_model.dart';
import '../utilities/baseutitiles.dart';

class EmployeeListDialog extends StatefulWidget {
  final String title;
  final List<Employee> employees;
  final IconData icon;
  final Color color;

  const EmployeeListDialog({
    super.key,
    required this.title,
    required this.employees,
    required this.icon,
    required this.color,
  });

  @override
  State<EmployeeListDialog> createState() =>
      _EmployeeListDialogState();
}

class _EmployeeListDialogState extends State<EmployeeListDialog> {
  final TextEditingController searchController = TextEditingController();
  HrDashboardController hrDashboardController = Get.put(HrDashboardController());
  List<Employee> filteredEmployees = [];

  @override
  void initState() {
    super.initState();

    filteredEmployees = List.from(widget.employees);

    searchController.addListener(_searchEmployees);
  }

  void _searchEmployees() {
    final search = searchController.text.trim().toLowerCase();

    setState(() {
      if (search.isEmpty) {
        filteredEmployees = List.from(widget.employees);
      } else {
        filteredEmployees = widget.employees.where((employee) {
          final name = employee.employeeName
              ?.toLowerCase() ??
              "";

          return name.contains(search);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String getInitials(String name) {
    final parts = name.trim().split(" ");

    if (parts.length == 1) {
      return parts.first.isNotEmpty
          ? parts.first[0].toUpperCase()
          : "";
    }

    return (
        parts.first.isNotEmpty ? parts.first[0] : ""
    ) +
        (
            parts.length > 1 && parts.last.isNotEmpty
                ? parts.last[0]
                : ""
        ).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// HEADER
        Container(
          // padding: const EdgeInsets.fromLTRB(
          //   24,
          //   16,
          //   16,
          //   16,
          // ),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(22),
              topRight: Radius.circular(22),
            ),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade200,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  widget.icon,
                  color: widget.color,
                  size: 23,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff1F2937),
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      "Employee List (${hrDashboardController.entryFromDate.text} - ${hrDashboardController.entryToDate.text})",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade500,
                  size: 22,
                ),
              ),
            ],
          ),
        ),

        /// SEARCH
        Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            8,
            24,
            8,
          ),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search employee by name...",
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade400,
              ),
              prefixIcon: Icon(
                Icons.search,
                size: 20,
                color: Colors.grey.shade500,
              ),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 18,
                ),
                onPressed: () {
                  searchController.clear();
                },
              )
                  : null,
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 12,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xff4F46E5),
                ),
              ),
            ),
          ),
        ),

        /// TABLE HEADER
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF8FAFC),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: const Row(
            children: [
              SizedBox(
                width: 48,
                child: Text(
                  "#",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff64748B),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  "Employee Name",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff64748B),
                  ),
                ),
              ),
            ],
          ),
        ),

        /// EMPLOYEE LIST
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.shade300,
                ),
                right: BorderSide(
                  color: Colors.grey.shade300,
                ),
                // bottom: BorderSide(
                //   color: Colors.grey.shade300,
                // ),
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: filteredEmployees.isEmpty
                ? Center(
              child: Text(
                "No Record Found",
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 13,
                ),
              ),
            )
                : ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final employee =
                filteredEmployees[index];

                final name =
                    employee.employeeName ?? "";

                return Container(
                  height: 50,
                  padding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      // bottom: BorderSide(
                      //   color: Colors.grey.shade100,
                      // ),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                        child: Text(
                          "${index + 1}",
                          style: const TextStyle(
                            fontSize: 13,
                            color:
                            Color(0xff94A3B8),
                          ),
                        ),
                      ),

                      Container(
                        height: 32,
                        width: 32,
                        decoration:
                        BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.withOpacity(0.10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          getInitials(name),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            widget.color,
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            Color(0xff111827),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 5),
      ],
    );
  }
}



class UpcomingHolidaysPage extends StatefulWidget {
  final List<UpcomingHoliday> holidays;

  const UpcomingHolidaysPage({
    super.key,
    required this.holidays,
  });

  @override
  State<UpcomingHolidaysPage> createState() => _UpcomingHolidaysPageState();
}

class _UpcomingHolidaysPageState extends State<UpcomingHolidaysPage> {

  List<UpcomingHoliday> filteredHolidays = [];
  final TextEditingController _searchController =
  TextEditingController();

  final RxInt selectedHolidayIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    // Initially show all holidays
    filteredHolidays = List.from(widget.holidays);

    _searchController.addListener(_searchHolidays);
  }

  @override
  void dispose() {
    _searchController.removeListener(_searchHolidays);
    _searchController.dispose();
    super.dispose();
  }

  void _searchHolidays() {
    final String query =
    _searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredHolidays = List.from(widget.holidays);
        return;
      }

      filteredHolidays = widget.holidays.where((holiday) {
        final String holidayName =
        (holiday.holidayRemarks ?? "").toLowerCase();

        final String holidayDate =
        (holiday.dateValue ?? "").toLowerCase();

        return holidayName.contains(query) ||
            holidayDate.contains(query);
      }).toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,

          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 19,
              color: Color(0xff172B4D),
            ),
          ),

          title: const Text(
            "Upcoming Holidays",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xff172B4D),
            ),
          ),

          centerTitle: false,
        ),
        body: Column(
          children: [
            // SEARCH
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                10,
                16,
                12,
              ),
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xffF8FAFA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xffE1E5E9),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search holidays...",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Color(0xff98A2B3),
                    ),
                    prefixIcon: Icon(
                      Icons.search_rounded,
                      size: 25,
                      color: Color(0xff299C91),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 13,
                    ),
                  ),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff172B4D),
                  ),
                ),
              ),
            ),

            Expanded(
              child: filteredHolidays.isEmpty
                  ? Center(child: Text("No matching results"))
                  : ListView(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  8,
                  16,
                  24,
                ),
                children: [
                  // ============================
                  // NEXT UP
                  // ============================
                  if (filteredHolidays.isNotEmpty) ...[
                    _nextHolidayCard(
                      filteredHolidays.first,
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      "Coming up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff172B4D),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ============================
                    // REMAINING HOLIDAYS
                    // ============================
                    ...filteredHolidays
                        .skip(1)
                        .map(
                          (holiday) =>
                          _comingHolidayCard(holiday),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _nextHolidayCard(UpcomingHoliday holiday) {
    final String holidayName =
        holiday.holidayRemarks ?? "";

    final String holidayDate =
        holiday.dateValue ?? "";

    final int daysLeft =
        holiday.remainingDays ?? 0;

    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            // primaryColor,
            // Color.lerp(
            //   primaryColor,
            //   Colors.white,
            //   0.35,
            // )!,
            Color(0xff64D0BA),
            Color(0xff52B8E9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            // color: primaryColor.withOpacity(0.20),
            color: const Color(0xff52B8E9)
                .withOpacity(0.20),
            blurRadius: 14,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ==========================
          // LEFT CONTENT
          // ==========================
          Padding(
            padding: const EdgeInsets.fromLTRB(
              22,
              20,
              145,
              20,
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                const Text(
                  "Next up",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  holidayName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 25,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 20,
                      color: Colors.white,
                    ),

                    const SizedBox(width: 8),

                    Flexible(
                      child: Text(
                        BaseUtitiles.dateformat(
                          holidayDate,
                        ),
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==========================
          // DAYS LEFT CIRCLE
          // ==========================
          Positioned(
            right: 18,
            top: 25,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    "$daysLeft",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff299C91),
                    ),
                  ),

                  const Text(
                    "Days left",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff299C91),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _comingHolidayCard(
      UpcomingHoliday holiday,
      ) {
    final String holidayName =
        holiday.holidayRemarks ?? "";

    final String holidayDate =
        holiday.dateValue ?? "";

    final int daysLeft =
        holiday.remainingDays ?? 0;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xffE8ECEF),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        child: Row(
          children: [
            // ==========================
            // DATE CIRCLE
            // ==========================
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff64D0BA),
                    Color(0xff52B8E9),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Text(
                    _getDay(holidayDate),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),

                  Text(
                    _getMonth(holidayDate),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // ==========================
            // HOLIDAY DETAILS
            // ==========================
            Expanded(
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    holidayName,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff172B4D),
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                        color: Color(0xff667085),
                      ),

                      const SizedBox(width: 5),

                      Flexible(
                        child: Text(
                          BaseUtitiles.dateformat(
                            holidayDate,
                          ),
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff667085),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ==========================
            // DAYS LEFT PILL
            // ==========================
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffE8F6F2),
                borderRadius:
                BorderRadius.circular(25),
              ),
              child: Text(
                "$daysLeft days",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff258B7C),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDay(String date) {
    if (date.isEmpty) return "";

    try {
      final parsedDate = DateTime.tryParse(date);

      if (parsedDate != null) {
        return parsedDate.day
            .toString()
            .padLeft(2, '0');
      }

      final parts = date.split(RegExp(r'[-/]'));

      if (parts.length >= 3) {
        // dd-MM-yyyy / dd/MM/yyyy
        if (parts[0].length <= 2) {
          return parts[0].padLeft(2, '0');
        }

        // yyyy-MM-dd
        return parts[2].padLeft(2, '0');
      }
    } catch (_) {}

    return date;
  }

  String _getMonth(String date) {
    if (date.isEmpty) return "";

    try {
      final parsedDate = DateTime.tryParse(date);

      if (parsedDate != null) {
        return _monthName(parsedDate.month);
      }

      final parts = date.split(RegExp(r'[-/]'));

      if (parts.length >= 3) {
        int? month;

        // dd-MM-yyyy
        if (parts[0].length <= 2) {
          month = int.tryParse(parts[1]);
        }
        // yyyy-MM-dd
        else {
          month = int.tryParse(parts[1]);
        }

        if (month != null &&
            month >= 1 &&
            month <= 12) {
          return _monthName(month);
        }
      }
    } catch (_) {}

    return "";
  }

  String _monthName(int month) {
    const months = [
      "JAN",
      "FEB",
      "MAR",
      "APR",
      "MAY",
      "JUN",
      "JUL",
      "AUG",
      "SEP",
      "OCT",
      "NOV",
      "DEC",
    ];

    return months[month - 1];
  }

}



class LeaveRequestCard extends StatefulWidget {
  final List<OnClickListResult> requests;
  final String type;
  final String title;

  const LeaveRequestCard({
    super.key,
    required this.requests,
    required this.type,
    required this.title,
  });

  @override
  State<LeaveRequestCard> createState() => _LeaveRequestCardState();
}

class _LeaveRequestCardState extends State<LeaveRequestCard> {

  HrDashboardController hrDashboardController = Get.put(HrDashboardController());
  final TextEditingController searchController =
  TextEditingController();

  List<OnClickListResult> filteredAttendance = [];

  @override
  void initState() {
    super.initState();

    filteredAttendance = List<OnClickListResult>.from(widget.requests); // ✅ match the actual source

    searchController.addListener(
      _searchAttendance,
    );
  }

  @override
  void dispose() {
    searchController.removeListener(
      _searchAttendance,
    );

    searchController.dispose();

    super.dispose();
  }

  void _searchAttendance() {
    final String query = searchController.text.trim().toLowerCase();

    setState(() {
      if (query.isEmpty) {
        filteredAttendance = List<OnClickListResult>.from(widget.requests); // ✅
        return;
      }

      filteredAttendance = widget.requests.where((item) {   // ✅ filter from widget.requests
        final String employeeName = (item.employeeName ?? '').toLowerCase();
        final String reqNo = (item.requisitionNo ?? '').toLowerCase();
        final String entryDate = (item.entryDate ?? '').toLowerCase();
        final String employeeCode = (item.projectName ?? '').toLowerCase();
        final String department = (item.LeaveReason ?? '').toLowerCase();

        return employeeName.contains(query) ||
            employeeCode.contains(query) ||
            reqNo.contains(query) ||
            entryDate.contains(query) ||
            department.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xff172B4D),
            ),
          ),
          actions: [
            TextButton(onPressed: ()
            {
              Navigator.pop(context);
            }, child: Text("Back",style: TextStyle(fontSize: 18,color: Colors.black87),))
          ],
        ),
        body: widget.requests.isEmpty
            ? const Center(
          child: Text("No pending leave requests"),
        )
            : Column(
          children: [
            SizedBox(height: 10,),
            _searchBar(),
            Expanded(
              child: filteredAttendance.isEmpty
                  ? const Center(child: Text("No matching results"))   // ✅ nice UX bonus
                  : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: filteredAttendance.length,
                itemBuilder: (context, index) {
                  final request = filteredAttendance[index];
                  return _requestItem(request);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffDEE3E8),
          ),
        ),
        child: TextField(
          controller: searchController,
          cursorColor: Colors.black87,
          cursorWidth: 1,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            decoration: TextDecoration.none, // Removes text underline
          ),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: const TextStyle(
              fontSize: 12,
              color: Color(0xff98A2B3),
            ),
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 20,
              color: Color(0xff98A2B3),
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: searchController,
              builder: (
                  context,
                  value,
                  child,
                  ) {
                if (value.text.isEmpty) {
                  return const SizedBox.shrink();
                }

                return IconButton(
                  onPressed: () {
                    searchController.clear();
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: Color(0xff98A2B3),
                  ),
                );
              },
            ),
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
          ),
        ),
      ),
    );
  }

  Widget _requestItem(OnClickListResult request) {
    final double leaveDays = request.totalLeaveDays ?? 0.0;

    final String requisitionType =
    (request.requisitionType ?? '').toUpperCase();

    final bool isPermission =
        requisitionType == 'PERMISSION';

    final bool isOnDuty =
        requisitionType == 'ON DUTY';

    final bool isLeave =
        requisitionType == 'LEAVE';

    final Color primaryColor = isPermission
        ? const Color(0xff7C5CFC) : isOnDuty ? Color(0xFFF59E0B) : isLeave ?
    const Color(0xff2563EB) : Color(0xFF10B981);

    final Color lightPrimary =
    primaryColor.withOpacity(0.08);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xffE4E7EC),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.fromLTRB(
                14,
                11,
                10,
                9,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(.045),
                border: Border(
                  bottom: BorderSide(
                    color: primaryColor.withOpacity(.20),
                  ),
                ),
              ),
              child: Row(
                children: [

                  // REQUISITION ICON
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: lightPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPermission || isOnDuty
                          ? Icons.access_time_rounded
                          : Icons
                          .event_available_rounded,
                      color: primaryColor,
                      size: 20,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // REQUISITION NUMBER
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          request.requisitionNo ?? '-',
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight:
                            FontWeight.w800,
                            color:
                            Color(0xff172B4D),
                          ),
                        ),

                        const SizedBox(height: 3),

                        const Text(
                          'Requisition No',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                            FontWeight.w500,
                            color:
                            Color(0xff98A2B3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ENTRY DATE
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.circular(7),
                      border: Border.all(
                        color: primaryColor
                            .withOpacity(.12),
                      ),
                    ),
                    child: Row(
                      mainAxisSize:
                      MainAxisSize.min,
                      children: [
                        Icon(
                          Icons
                              .calendar_month_outlined,
                          size: 16,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          request.entryDate ?? '-',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                14,
                8,
                14,
                10,
              ),
              child: Row(
                children: [

                  Expanded(
                    child: _compactInfo(
                      icon: Icons
                          .person_outline_rounded,
                      iconColor: primaryColor,
                      label: 'Employee Name',
                      value:
                      request.StaffName ?? '-',
                    ),
                  ),
                  _verticalDivider(),

                  Expanded(
                    child: _compactInfo(
                      icon: Icons
                          .apartment_outlined,
                      iconColor: primaryColor,
                      label: 'Project',
                      value:
                      request.projectName ?? '-',
                    ),
                  ),
                ],
              ),
            ),
            _horizontalDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                14,
                11,
                14,
                11,
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [

                  // DATE SECTION
                  Expanded(
                    flex: 7,
                    child: _dateSection(
                      request: request,
                      leaveDays: leaveDays,
                      primaryColor:
                      primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            _horizontalDivider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                14,
                11,
                14,
                11,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: _compactInfo(
                      icon: Icons
                          .notes_rounded,
                      iconColor:
                      const Color(0xffF59E0B),
                      label: 'Reason',
                      value:
                      request.LeaveReason ?? '-',
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _compactInfo({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 17,
            color: iconColor,
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              // Text(
              //   label,
              //   style: const TextStyle(
              //     fontSize: 8,
              //     fontWeight: FontWeight.w500,
              //     color: Color(0xff98A2B3),
              //   ),
              // ),
              //
              // const SizedBox(height: 3),

              Text(
                value.isEmpty ? '-' : value,
                maxLines: 2,
                overflow:
                TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff344054),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _dateSection({
    required OnClickListResult request,
    required double leaveDays,
    required Color primaryColor,
  }) {

    final bool isPermission =
        widget.type.trim().toUpperCase() == 'PERMISSION';
    final bool isOnDuty =
        widget.type.trim().toUpperCase() == 'ON DUTY';

    final String from =
        request.leaveFromDate ?? '-';

    final String to =
        request.leaveToDate ?? '-';

    final String daysText =
    leaveDays % 1 == 0
        ? '${leaveDays.toInt()} Days'
        : '${leaveDays.toStringAsFixed(1)} Days';

    final String permissionFromTime =
        request.permissionFromTime ?? '-';

    final String permissionToTime =
        request.permissionToTime ?? '-';

    final String fromDisplay =
    isPermission || isOnDuty
        ? permissionFromTime
        : from;

    final String toDisplay =
    isPermission || isOnDuty
        ? permissionToTime
        : to;

    final String durationDisplay =
    isPermission || isOnDuty
        ? formatPermissionDuration(
      permissionFromTime,
      permissionToTime,
    )
        : daysText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xffEAF8EF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPermission || isOnDuty
                          ? Icons.access_time_rounded
                          : Icons.calendar_month_outlined,
                      size: 17,
                      color: const Color(0xff27AE60),
                    ),
                  ),

                  const SizedBox(width: 7),

                  Flexible(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          fromDisplay,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              width: 75,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  // DURATION
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color:
                      primaryColor.withOpacity(.10),
                      borderRadius:
                      BorderRadius.circular(5),
                    ),
                    child: Text(
                      durationDisplay,
                      maxLines: 1,
                      overflow:
                      TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight:
                        FontWeight.w800,
                        color: primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // DOTTED LINE
                  Row(
                    children: List.generate(
                      7,
                          (index) {
                        return Expanded(
                          child: Container(
                            height: 1.5,
                            margin:
                            const EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                            color:
                            const Color(0xffC8CDD3),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 3),

                  // TO TEXT
                  const Text(
                    'to',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xff98A2B3),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.end,
                children: [

                  Flexible(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'To',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 2),

                        Text(
                          toDisplay,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          textAlign:
                          TextAlign.right,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w700,
                            color:
                            Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 7),

                  Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(
                      color: Color(0xffEAF8EF),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPermission || isOnDuty
                          ? Icons.access_time_rounded
                          : Icons.calendar_month_outlined,
                      size: 17,
                      color: const Color(0xff27AE60),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  String formatPermissionDuration(
      String? startTime,
      String? endTime,
      ) {
    if (startTime == null ||
        endTime == null ||
        startTime.trim().isEmpty ||
        endTime.trim().isEmpty ||
        startTime == '-' ||
        endTime == '-') {
      return '-';
    }

    try {
      DateTime start;
      DateTime end;

      // Try 12-hour format first
      try {
        start = DateFormat('hh:mm a').parse(
          startTime.trim(),
        );

        end = DateFormat('hh:mm a').parse(
          endTime.trim(),
        );
      } catch (_) {
        // Try 24-hour format
        start = DateFormat('HH:mm').parse(
          startTime.trim(),
        );

        end = DateFormat('HH:mm').parse(
          endTime.trim(),
        );
      }

      Duration duration =
      end.difference(start);

      // Permission crossing midnight
      if (duration.isNegative) {
        duration += const Duration(days: 1);
      }

      final int totalMinutes =
          duration.inMinutes;

      final int hours =
          totalMinutes ~/ 60;

      final int minutes =
          totalMinutes % 60;

      // Example: 2 Hrs 30 Mins
      if (hours > 0 && minutes > 0) {
        return '${hours} Hr${hours > 1 ? 's' : ''} '
            '${minutes} Min${minutes > 1 ? 's' : ''}';
      }

      // Example: 2 Hrs
      if (hours > 0) {
        return '${hours} Hr${hours > 1 ? 's' : ''}';
      }

      // Example: 30 Mins
      return '${minutes} Min${minutes > 1 ? 's' : ''}';
    } catch (e) {
      return '-';
    }
  }


  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 38,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
      ),
      color: const Color(0xffEAECF0),
    );
  }

  Widget _horizontalDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xffF0F2F4),
    );
  }
}


class RecentActivityCard extends StatelessWidget {
  final RecentActivity activity;

  const RecentActivityCard({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LEFT BLUE LINE
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: Color(0xff2878F0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
                child: Column(
                  children: [
                    // EMPLOYEE HEADER
                    _employeeHeader(),

                    const SizedBox(height: 16),

                    // IN DETAILS
                    _attendanceRow(
                      icon: Icons.calendar_today_outlined,
                      title: "In Date",
                      value: dateformat(activity.indate!),
                      // value: _value(activity.indate),
                      secondIcon: Icons.access_time_outlined,
                      secondTitle: "In Time",
                      secondValue: _value(activity.inTime),
                      thirdTitle: "In Status",
                      thirdValue: _value(activity.instatus),
                      isStatus: true,
                      statusValue: activity.instatus,
                    ),

                    const Divider(
                      height: 10,
                      color: Color(0xffE9EDF3),
                    ),

                    // OUT DETAILS
                    _attendanceRow(
                      icon: Icons.calendar_today_outlined,
                      title: "Out Date",
                      value: dateformat(activity.outDate),
                      secondIcon: Icons.access_time_outlined,
                      secondTitle: "Out Time",
                      secondValue: _value(activity.outTime),
                      thirdTitle: "Out Status",
                      thirdValue: _value(activity.outstatus),
                      isStatus: true,
                      statusValue: activity.outstatus,
                      isOut: true,
                    ),

                    const Divider(
                      height: 10,
                      color: Color(0xffE9EDF3),
                    ),

                    // LOCATIONS
                    _locationRow(
                      icon: Icons.location_on_outlined,
                      title: "In Location",
                      value: activity.inLoc,
                    ),

                    const SizedBox(height: 9),

                    _locationRow(
                      icon: Icons.location_on_outlined,
                      title: "Out Location",
                      value: activity.outLoc,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _employeeHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // PROFILE ICON
        Container(
          width: 35,
          height: 35,
          decoration: const BoxDecoration(
            color: Color(0xffEAF2FF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person_outline,
            color: Color(0xff2878F0),
            size: 25,
          ),
        ),

        const SizedBox(width: 12),

        // EMPLOYEE DETAILS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                _value(activity.employeeName),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff10264A),
                ),
              ),
            ],
          ),
        ),

        // AL BADGE
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF8FBFF),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: const Color(0xffC8DDFB),
            ),
          ),
          child: Text(
            _value(activity.punchNo),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xff2878F0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _attendanceRow({
    required IconData icon,
    required String title,
    required String value,
    required IconData secondIcon,
    required String secondTitle,
    required String secondValue,
    required String thirdTitle,
    required String thirdValue,
    bool isStatus = false,
    bool isOut = false,
    String? statusValue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // DATE
        Expanded(
          flex: 5,
          child: _infoItem(
            icon: icon,
            title: title,
            value: value,
            isOut: isOut,
          ),
        ),

        _verticalDivider(),

        // TIME
        Expanded(
          flex: 5,
          child: _infoItem(
            icon: secondIcon,
            title: secondTitle,
            value: secondValue,
            valueColor: secondValue == "-"
                ? const Color(0xff172B4D)
                : isOut
                ? const Color(0xffE5484D) // 🔴 Out Time
                : const Color(0xff0B963D), // 🟢 In Time
            isOut: isOut,
          ),
        ),

        _verticalDivider(),

        // STATUS
        Expanded(
          flex: 5,
          child: _statusItem(
            title: thirdTitle,
            value: thirdValue,
            statusValue: statusValue,
            isOut: isOut,
          ),
        ),
      ],
    );
  }

  Widget _infoItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
    required bool isOut,
  }) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // ICON
        Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Color(0xff71829D),
            ),
            const SizedBox(width: 10),

            // TITLE
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xff71829D),
              ),
            ),
          ],
        ),



        const SizedBox(height: 5),

        // VALUE
        SizedBox(
          width: double.infinity,
          child: Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xff172B4D),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusItem({
    required String title,
    required String value,
    required String? statusValue,
    required bool isOut,
  }) {
    final bool active =
        statusValue != null &&
            statusValue.trim().isNotEmpty &&
            statusValue.trim() != "-";

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // STATUS ICON
          Row(
            children: [
              Icon(
                isOut
                    ? Icons.logout_rounded
                    : Icons.login_rounded,
                size: 18,
                color: Color(0xff71829D),
              ),
              const SizedBox(width: 5),

              // STATUS TITLE
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff71829D),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // STATUS VALUE
          Container(
            constraints: const BoxConstraints(
              maxWidth: 80,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 6,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: active
                  ? (isOut
                  ? const Color(0xffFFF1F0)
                  : const Color(0xffE7F7ED))
                  : const Color(0xffF2F4F7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: active
                    ? (isOut
                    ? const Color(0xffE5484D)
                    : const Color(0xff0B963D))
                    : const Color(0xff667085),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationRow({
    required IconData icon,
    required String title,
    required String? value,
  }) {
    final String location = _value(value);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.pin_drop,
          size: 20,
          color: Colors.red,
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff71829D),
                ),
              ),

              const SizedBox(height: 3),

              Text(
                location,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 13,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 48,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: const Color(0xffE6EAF0),
    );
  }

  String _value(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "-";
    }
    return value.trim();
  }

  String dateformat(String? date) {
    if (date == null || date.trim().isEmpty) {
      return "-";
    }

    try {
      final parsedDate = DateTime.parse(date);

      return DateFormat(
        'dd MMM yyyy',
      ).format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

