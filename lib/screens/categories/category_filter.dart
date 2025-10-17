import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/category.dart';

class CategoryFilter extends StatefulWidget {
  final Function(String?) onFilterChanged;

  const CategoryFilter({super.key, required this.onFilterChanged});

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final categoryBox = Hive.box<Category>('categories');
    final categories = categoryBox.values.toList();

    return Wrap(
      spacing: 12,
      children: [
        ChoiceChip(
          label: const Text('All'),
          selected: _selectedCategoryId == null,
          onSelected: (_) {
            setState(() => _selectedCategoryId = null);
            widget.onFilterChanged(null);
          },
        ),
        ...categories.map((category) {
          final isSelected = _selectedCategoryId == category.id;
          return ChoiceChip(
            label: Text(category.title),
            selected: isSelected,
            onSelected: (_) {
              setState(() => _selectedCategoryId = category.id);
              widget.onFilterChanged(category.id);
            },
            selectedColor: category.color.withOpacity(0.3),
            backgroundColor: category.color.withOpacity(0.1),
            labelStyle: TextStyle(
              color: isSelected ? Colors.black : Colors.grey.shade800,
            ),
          );
        }),
      ],
    );
  }
}