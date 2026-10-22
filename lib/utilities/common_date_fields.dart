import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prahkurticore/utilities/baseutitiles.dart';
import 'package:prahkurticore/utilities/requestconstant.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../app_theme/app_colors.dart';
import '../constants/ui_constant/icons_const.dart';


class CommonDateFieldConfig {
  final String title;

  /// Existing value support
  final String value;

  /// Optional controller.
  /// If provided, the widget automatically listens
  /// for controller changes.
  final TextEditingController? controller;

  final bool selectable;

  final DateTime? initialDate;

  final DateTime? firstDate;

  final DateTime? lastDate;

  final SelectableDayPredicate? selectableDayPredicate;

  final ValueChanged<DateTime>? onChanged;

  const CommonDateFieldConfig({
    required this.title,
    required this.value,
    this.controller,
    this.selectable = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.selectableDayPredicate,
    this.onChanged,
  });
}

class CommonDateFields extends StatefulWidget {
  /// Date 1 is always displayed.
  final CommonDateFieldConfig date1;

  /// Date 2 is optional.
  final CommonDateFieldConfig? date2;

  const CommonDateFields({
    super.key,
    required this.date1,
    this.date2,
  });

  @override
  State<CommonDateFields> createState() =>
      _CommonDateFieldsState();
}

class _CommonDateFieldsState extends State<CommonDateFields> {

  @override
  void initState() {
    super.initState();

    widget.date1.controller?.addListener(_controllerChanged);
    widget.date2?.controller?.addListener(_controllerChanged);
  }

  // =================================================
  // CONTROLLER CHANGE
  // =================================================

  void _controllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(
      covariant CommonDateFields oldWidget,
      ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.date1.controller != widget.date1.controller) {
      oldWidget.date1.controller?.removeListener(_controllerChanged);
      widget.date1.controller?.addListener(_controllerChanged);
    }

    if (oldWidget.date2?.controller != widget.date2?.controller) {
      oldWidget.date2?.controller?.removeListener(_controllerChanged);
      widget.date2?.controller?.addListener(_controllerChanged);
    }
  }

  @override
  void dispose() {
    widget.date1.controller?.removeListener(_controllerChanged);
    widget.date2?.controller?.removeListener(_controllerChanged);

    super.dispose();
  }

  // =================================================
  // GET CURRENT VALUE
  // =================================================

  String _getValue(CommonDateFieldConfig config) {
    if (config.controller != null) {
      return config.controller!.text;
    }

    return config.value;
  }

  // =================================================
  // DATE PICKER
  // =================================================

  Future<void> _pickDate({
    required int dateNumber,
    required CommonDateFieldConfig config,
  }) async {

    final DateTime now = DateTime.now();

    final DateTime firstDate =
        config.firstDate ?? DateTime(2000);

    final DateTime lastDate =
        config.lastDate ?? DateTime.now();

    // ---------------------------------------------
    // INITIAL DATE
    // ---------------------------------------------

    DateTime initialDate =
        config.initialDate ?? now;

    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    }

    if (initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    // ---------------------------------------------
    // DATE PICKER
    // ---------------------------------------------

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      selectableDayPredicate:
      config.selectableDayPredicate,

      builder: (context, child) {

        final Color primary =
            Theme.of(context).primaryColor;

        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) {
      return;
    }

    // ---------------------------------------------
    // API FORMAT
    // yyyy-MM-dd
    // ---------------------------------------------

    final String formattedDate =
    CommonDateUtils.formatApiDate(
      pickedDate,
    );

    // ---------------------------------------------
    // UPDATE CONTROLLER
    // ---------------------------------------------

    if (config.controller != null) {
      config.controller!.text = formattedDate;
    }

    // ---------------------------------------------
    // CALLBACK
    // ---------------------------------------------

    config.onChanged?.call(pickedDate);

    // Controller listener will rebuild automatically.
    //
    // For fields without a controller, rebuild here.
    if (config.controller == null && mounted) {
      setState(() {});
    }
  }

  // =================================================
  // BUILD
  // =================================================

  @override
  Widget build(BuildContext context) {

    Color primary =
        Theme.of(context).primaryColor;

    // IMPORTANT:
    // Always read the latest controller value here.
    final String date1Value =
    _getValue(widget.date1);

    final String date2Value =
    widget.date2 == null
        ? ""
        : _getValue(widget.date2!);

    // =================================================
    // ONLY DATE 1
    // =================================================

    if (widget.date2 == null) {

      return _buildSingleDate(
        config: widget.date1,
        value: date1Value,
        primary: primary,
        onTap: widget.date1.selectable
            ? () {
          _pickDate(
            dateNumber: 1,
            config: widget.date1,
          );
        }
            : null,
      );
    }

    // =================================================
    // DATE 1 + DATE 2
    // =================================================

    return Container(
      margin: const EdgeInsets.fromLTRB(
        10,
        2,
        5,
        2,
      ),
      child: Row(
        children: [

          // -----------------------------------------
          // DATE 1
          // -----------------------------------------

          Expanded(
            child: _buildDateContainer(
              config: widget.date1,
              value: date1Value,
              primary: primary,
              onTap: widget.date1.selectable
                  ? () {
                _pickDate(
                  dateNumber: 1,
                  config: widget.date1,
                );
              }
                  : null,
            ),
          ),

          const SizedBox(width: 10),

          // -----------------------------------------
          // DATE 2
          // -----------------------------------------

          Expanded(
            child: _buildDateContainer(
              config: widget.date2!,
              value: date2Value,
              primary: primary,
              onTap: widget.date2!.selectable
                  ? () {
                _pickDate(
                  dateNumber: 2,
                  config: widget.date2!,
                );
              }
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  // =================================================
  // SINGLE DATE
  // =================================================

  Widget _buildSingleDate({
    required CommonDateFieldConfig config,
    required String value,
    required Color primary,
    VoidCallback? onTap,
  }) {

    return Container(
      margin: const EdgeInsets.fromLTRB(
        10,
        2,
        5,
        2,
      ),
      child: _buildDateContainer(
        config: config,
        value: value,
        primary: primary,
        onTap: onTap,
        fullWidth: true,
      ),
    );
  }

  // =================================================
  // DATE CONTAINER
  // =================================================

  Widget _buildDateContainer({
    required CommonDateFieldConfig config,
    required String value,
    required Color primary,
    VoidCallback? onTap,
    bool fullWidth = false,
  }) {
    return Container(
      width: fullWidth ? double.infinity : null,
      margin: const EdgeInsets.only(
        top: 2,
        left: 0,
        right: 5,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white70,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 3,
            left: 10,
            bottom: 5,
          ),
          child: InkWell(
            onTap: onTap,
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                labelText: config.title,
                labelStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: RequestConstant.Lable_Font_SIZE,
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: ConstIcons.date,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value.isEmpty
                      ? ''
                      : CommonDateUtils.formatDateForDisplay(value),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonDateUtils {
  /// Sets dates in API format: yyyy-MM-dd
  static void setCommonDateRange({
    required TextEditingController fromController,
    required TextEditingController toController,
  }) {
    final currentDate = DateTime.now();

    // Last day of previous month
    final lastDayOfPreviousMonth =
    DateTime(currentDate.year, currentDate.month, 0);

    final oneWeekBefore = currentDate.subtract(const Duration(days: 7));

    fromController.text = formatApiDate(oneWeekBefore);

    toController.text = formatApiDate(currentDate);
  }

  /// DateTime -> yyyy-MM-dd
  static String formatApiDate(DateTime date) {
    return "${date.year}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  static DateTime parseApiDate(String date) {
    if (date
        .trim()
        .isEmpty) {
      return DateTime.now();
    }

    return DateTime.parse(date);
  }

  static String formatDateForDisplay(String date) {
    if (date.isEmpty) return '';

    try {
      // 15-10-2026 → 2026-10-15
      if (RegExp(r'^\d{2}-\d{2}-\d{4}$').hasMatch(date)) {
        final parsedDate = DateFormat('dd-MM-yyyy').parse(date);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      }

      // 15-Oct-2026 → 2026-10-15
      if (RegExp(r'^\d{2}-[A-Za-z]{3}-\d{4}$').hasMatch(date)) {
        final parsedDate = DateFormat('dd-MMM-yyyy').parse(date);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      }

      // Already in API format: 2026-10-15
      if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(date)) {
        final parsedDate = DateFormat('yyyy-MM-dd').parse(date);
        return DateFormat('yyyy-MM-dd').format(parsedDate);
      }
    } catch (e) {
      return date;
    }

    return date;
  }
}