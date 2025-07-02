import 'package:cinemarket/core/theme/app_colors.dart';
import 'package:cinemarket/core/theme/app_text_style.dart';
import 'package:cinemarket/features/favorite/widget/item_type.dart';
import 'package:flutter/material.dart';

class SortDropdown extends StatefulWidget {
  final ItemType itemType;

  const SortDropdown({super.key, required this.itemType});

  @override
  State<SortDropdown> createState() => _SortDropdownState();
}

class _SortDropdownState extends State<SortDropdown> {
  late List<String> sortOptions;
  late String selected;

  @override
  void initState() {
    super.initState();
    sortOptions = _getSortOptions(widget.itemType);
    selected = sortOptions.first;
  }

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.widgetBackground,
        borderRadius: BorderRadius.circular(8),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.only(left: 10),
          isDense: true,
          style: AppTextStyle.bodySmall,
          dropdownColor: AppColors.widgetBackground,
          value: selected,
          icon: const Padding(
            padding: EdgeInsets.only(left: 0),
            child: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.textSecondary,
            ),
          ),
          items:
              sortOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() => selected = value);
            }
          },
        ),
      ),
    );
  }
}
