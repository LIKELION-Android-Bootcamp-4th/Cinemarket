import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SortDropdown extends StatefulWidget {
  final ItemType itemType;
  final String? selectedValue;
  final void Function(String)? onSelected;

  const SortDropdown({
    super.key,
    required this.itemType,
    this.selectedValue,
    this.onSelected,
  });

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  late List<String> sortOptions;
  late String selected;

  List<String> _getSortOptions(ItemType itemType) {
    switch (itemType) {
      case ItemType.goods:
        return ['최신순', '오래된순', '인기순'];
      case ItemType.movie:
        return ['최신순', '평점순', '굿즈판매량순'];
    }
  }

  @override
  void initState() {
    super.initState();
    sortOptions = _getSortOptions(widget.itemType);
    selected = sortOptions.first;
  }



  @override
  void didUpdateWidget(covariant SortDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != null && widget.selectedValue != selected) {
      setState(() {
        selected = widget.selectedValue!;
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,
        hint: Text(selected, style: AppTextStyle.bodySmall),
        items:
            sortOptions
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: AppTextStyle.bodySmall),
                  ),
                )
                .toList(),
        value: selected,
        onChanged: (String? value) {
          setState(() {
            selected = value!;
          });
          widget.onSelected?.call(value!);
        },
        buttonStyleData: ButtonStyleData(
          padding: const EdgeInsets.only(left: 0, right: 4),
          height: 30,
          decoration: BoxDecoration(
            color: AppColors.widgetBackground,
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: AppColors.widgetBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40),
      ),
    );
  }
}
