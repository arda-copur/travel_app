import 'package:flutter/material.dart';
import 'package:travel_app/utils/helpers/date_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilterDialog extends StatefulWidget {
  final String? initialCountry;
  final String? initialRegion;
  final String? initialCategory;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final List<String> countries;
  final List<String> regions;
  final List<String> categories;
  final Function(String?, String?, String?, DateTime?, DateTime?)
      onApplyFilters;
  final VoidCallback onResetFilters;

  const FilterDialog({
    super.key,
    this.initialCountry,
    this.initialRegion,
    this.initialCategory,
    this.initialStartDate,
    this.initialEndDate,
    required this.countries,
    required this.regions,
    required this.categories,
    required this.onApplyFilters,
    required this.onResetFilters,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String? _selectedCountry;
  String? _selectedRegion;
  String? _selectedCategory;
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _selectedCountry = widget.initialCountry;
    _selectedRegion = widget.initialRegion;
    _selectedCategory = widget.initialCategory;
    _selectedStartDate = widget.initialStartDate;
    _selectedEndDate = widget.initialEndDate;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2031),
      initialDateRange: _selectedStartDate != null && _selectedEndDate != null
          ? DateTimeRange(start: _selectedStartDate!, end: _selectedEndDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                  onSurface: Theme.of(context).colorScheme.onSurface,
                ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedStartDate = picked.start;
        _selectedEndDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)?.filter ?? 'Filter'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDropdown(
              AppLocalizations.of(context)?.country ?? 'Country',
              _selectedCountry,
              widget.countries,
              (value) {
                setState(() {
                  _selectedCountry = value;
                  _selectedRegion = null; // Ülke değişince bölgeyi sıfırla
                });
              },
            ),
            _buildDropdown(
              AppLocalizations.of(context)?.region ?? 'Region',
              _selectedRegion,
              // HomeViewModel'dan gelen regions listesi zaten seçili ülkeye göre filtrelenmiş olmalı
              widget.regions,
              (value) => setState(() => _selectedRegion = value),
            ),
            _buildDropdown(
              AppLocalizations.of(context)?.category ?? 'Category',
              _selectedCategory,
              widget.categories,
              (value) => setState(() => _selectedCategory = value),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)?.selectDateRange ??
                  'Select Date Range'),
              subtitle: Text(
                _selectedStartDate != null && _selectedEndDate != null
                    ? '${DateUtil.formatDate(_selectedStartDate!.toIso8601String())} - ${DateUtil.formatDate(_selectedEndDate!.toIso8601String())}'
                    : (AppLocalizations.of(context)?.selectDateRange ??
                        'Select Date Range'),
              ),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDateRange(context),
            ),
            if (_selectedStartDate != null || _selectedEndDate != null)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedStartDate = null;
                      _selectedEndDate = null;
                    });
                  },
                  child: Text(AppLocalizations.of(context)?.clearSelection ??
                      'Clear Selection'),
                ),
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.onResetFilters();
          },
          child: Text(
              AppLocalizations.of(context)?.resetFilters ?? 'Reset Filters'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onApplyFilters(
              _selectedCountry,
              _selectedRegion,
              _selectedCategory,
              _selectedStartDate,
              _selectedEndDate,
            );
          },
          child: Text(
              AppLocalizations.of(context)?.applyFilters ?? 'Apply Filters'),
        ),
      ],
    );
  }

  Widget _buildDropdown(String label, String? currentValue, List<String> items,
      ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        value: currentValue,
        items: items.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
