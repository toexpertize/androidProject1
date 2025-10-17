import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/category.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryBox = Hive.box<Category>('categories');
    final categories = categoryBox.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Course Categories')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: categories.isEmpty
            ? const Center(child: Text('No categories available.'))
            : ListView.builder(
          itemCount: categories.length,
          itemBuilder: (_, index) {
            final category = categories[index];
            return Card(
              color: category.color.withOpacity(0.1),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                leading: Icon(category.icon, color: category.color),
                title: Text(category.title),
              ),
            );
          },
        ),
      ),
    );
  }
}