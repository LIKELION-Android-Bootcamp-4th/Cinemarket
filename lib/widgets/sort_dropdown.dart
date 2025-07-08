import 'package:cinemarket/core/constants/enums/item_type.dart';
import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class SortDropdown extends StatelessWidget {
  final ItemType itemType;
  final String? selectedValue;
  final void Function(String)? onSelected;

  const SortDropdown({
    super.key,
    required this.itemType,
    this.selectedValue,
    this.onSelected,
  });

  List<String> _getSortOptions(ItemType itemType) {
    switch (itemType) {
      case ItemType.goods:
        return ['최신순', '오래된순', '인기순'];
      case ItemType.movie:
        return ['최신순', '평점순', '굿즈판매량순'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortOptions = _getSortOptions(itemType);

    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,
        value: selectedValue,
        items: sortOptions
            .map((String item) =>
            DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: AppTextStyle.bodySmall),
            ))
            .toList(),
        onChanged: (String? value) {
          if (value != null) {
            onSelected?.call(value);
          }
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
