import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/category.dart';

class CategoryEditor extends StatefulWidget {
  const CategoryEditor({super.key});

  @override
  State<CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends State<CategoryEditor> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  IconData _selectedIcon = Icons.category;
  Color _selectedColor = Colors.blue;

  void _saveCategory() {
    if (_formKey.currentState!.validate()) {
      final categoryBox = Hive.box<Category>('categories');
      final newCategory = Category(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        iconCodePoint: _selectedIcon.codePoint, // ✅ Hive-safe
        colorValue: _selectedColor.value,       // ✅ Hive-safe
      );
      categoryBox.put(newCategory.id, newCategory);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Category saved successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Category')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Category Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<IconData>(
                initialValue: _selectedIcon,
                decoration: const InputDecoration(labelText: 'Icon'),
                items: [
                  Icons.code,
                  Icons.design_services,
                  Icons.business,
                  Icons.campaign,
                  Icons.science,
                  Icons.language,
                ].map((icon) {
                  return DropdownMenuItem(
                    value: icon,
                    child: Icon(icon),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedIcon = val!),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Color>(
                initialValue: _selectedColor,
                decoration: const InputDecoration(labelText: 'Color'),
                items: [
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                  Colors.teal,
                ].map((color) {
                  return DropdownMenuItem(
                    value: color,
                    child: Container(
                      width: 24,
                      height: 24,
                      color: color,
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _selectedColor = val!),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save Category'),
                onPressed: _saveCategory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}