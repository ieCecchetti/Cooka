import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddInformationPage extends ConsumerStatefulWidget {
  const AddInformationPage({super.key});

  @override
  ConsumerState<AddInformationPage> createState() => _AddInformationPageState();
}

class _AddInformationPageState extends ConsumerState<AddInformationPage> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController shortDescriptionController =
      TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final List<File> selectedImages = []; // Store multiple picked images
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recipe Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Recipe Name Field
          TextField(
            controller: recipeNameController,
            decoration: const InputDecoration(
              labelText: "Recipe Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Short Description Field
          TextField(
            controller: shortDescriptionController,
            decoration: const InputDecoration(
              labelText: "Short Description",
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 16),
          // Prep Time Field
          TextFormField(
            controller: prepTimeController,
            decoration: const InputDecoration(
              labelText: 'Prep Time (min)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the preparation time';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Servings Field
          TextFormField(
            controller: servingsController,
            decoration: const InputDecoration(
              labelText: 'Servings',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the number of servings';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          // Image Picker and Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Images (${selectedImages.length})", // Add image counter
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (pickedFile != null) {
                    setState(() {
                      selectedImages.add(File(pickedFile.path));
                    });
                  }
                },
                icon: const Icon(Icons.add_a_photo, color: Colors.white),
                label: const Text(
                  "Add",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Display Selected Images
          Expanded(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: selectedImages.map((image) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(
                          image,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              selectedImages.remove(image);
                            });
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
