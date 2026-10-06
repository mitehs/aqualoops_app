import 'package:flutter/material.dart';
import 'package:aqualoops_app/models/product.dart';
import 'package:aqualoops_app/utils/app_colors.dart';
import 'package:aqualoops_app/widgets/custom_button.dart';
import 'package:aqualoops_app/widgets/custom_textfield.dart';

class AddProductScreen extends StatefulWidget {
  /// Pass an existing product to edit it, leave null to add a new one.
  final Product? product;

  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<String> categories = const ['20L', '1L', '500ml', '5L'];

  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    if (product == null) return;
    // Prefill the form when editing an existing product.
    nameController.text = product.name;
    priceController.text = product.price.toStringAsFixed(0);
    stockController.text = product.stock.toString();
    descriptionController.text = product.description;
    if (categories.contains(product.category)) {
      selectedCategory = product.category;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void showImagePickerMessage() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Image picker coming soon')));
  }

  void saveProduct() {
    if (!formKey.currentState!.validate()) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Product saved successfully')));
  }

  @override
  Widget build(BuildContext context) {
    // One dropdown entry for every category.
    List<DropdownMenuItem<String>> categoryItems = [];
    for (int i = 0; i < categories.length; i++) {
      String category = categories[i];
      categoryItems.add(
        DropdownMenuItem(value: category, child: Text(category)),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.adminBackground,
      appBar: AppBar(
        title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.adminPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: showImagePickerMessage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.adminPrimary.withValues(alpha: 0.3),
                      width: 1.5,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        color: AppColors.adminPrimary,
                        size: 36,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Product Image',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              CustomTextField(
                controller: nameController,
                label: 'Product Name',
                hint: 'e.g. 20L Mineral Water',
                prefixIcon: Icons.label_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Product name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: priceController,
                      label: 'Price',
                      hint: '30',
                      prefixIcon: Icons.currency_rupee,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Price is required';
                        }
                        if (double.tryParse(value.trim()) == null) {
                          return 'Enter a valid price';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: CustomTextField(
                      controller: stockController,
                      label: 'Stock',
                      hint: '100',
                      prefixIcon: Icons.inventory_2_outlined,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Stock is required';
                        }
                        if (int.tryParse(value.trim()) == null) {
                          return 'Enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                initialValue: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  prefixIcon: Icon(Icons.category_outlined),
                  border: OutlineInputBorder(),
                ),
                items: categoryItems,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: descriptionController,
                label: 'Description',
                hint: 'Short description of the product',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 26),
              CustomButton(
                label: widget.product == null
                    ? 'SAVE PRODUCT'
                    : 'UPDATE PRODUCT',
                color: AppColors.adminPrimary,
                onPressed: saveProduct,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
