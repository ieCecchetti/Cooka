import 'dart:io';
import 'package:cooka/models/recipe.dart';
import 'package:cooka/providers/create_recipe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:cooka/utils/backend.dart'; // Make sure this import is present

class AddInformationPage extends BreadCrumbPage<CreateRecipeNotifier, Recipe> {
  const AddInformationPage({super.key, required super.objectProvider});

  @override
  ConsumerState<AddInformationPage> createState() => _AddInformationPageState();
}

class _AddInformationPageState
    extends BreadCrumbPageState<AddInformationPage,
    CreateRecipeNotifier, Recipe> {
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController shortDescriptionController =
      TextEditingController();
  final TextEditingController prepTimeController = TextEditingController();
  final TextEditingController servingsController = TextEditingController();
  final List<File> selectedImages = []; // Store multiple picked images
  final ImagePicker _picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> imageUrls = []; // Store uploaded image URLs

  @override
  void initState() {
    super.initState();
    final recipe = ref.read(widget.objectProvider);

    recipeNameController.text = recipe.name;
    shortDescriptionController.text = recipe.description;
    prepTimeController.text =
        recipe.prepTime > 0 ? recipe.prepTime.toString() : '';
    servingsController.text =
        recipe.servings > 0 ? recipe.servings.toString() : '';

    // Load existing network images
    imageUrls.clear();
    imageUrls.addAll(recipe.imagesUrl.where((url) => url.isNotEmpty));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
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
            TextFormField(
              controller: recipeNameController,
              decoration: const InputDecoration(
                labelText: "Recipe Name",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the recipe name';
                }
                return null;
              },
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
                  "Images (${imageUrls.length})",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final pickedFile = await _picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      // Instantly upload and store the URL
                      final url = await uploadImageToBackend(
                        File(pickedFile.path),
                        'https://your-backend.com/upload',
                      );
                      if (url.isNotEmpty) {
                        setState(() {
                          imageUrls.add(url);
                        });
                      }
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
            // Display only network images
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: imageUrls.map((url) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(
                            url,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                imageUrls.remove(url);
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
      ),
    );
  }

  @override
  Future<void> update(WidgetRef ref) async {
    print("Saving informations...");
    final notifier = ref.read(widget.objectProvider.notifier);

    notifier.updateName(recipeNameController.text);
    notifier.updateDescription(shortDescriptionController.text);
    notifier.updatePrepTime(int.tryParse(prepTimeController.text) ?? 0);
    notifier.updateServings(int.tryParse(servingsController.text) ?? 0);

    // Save all uploaded image URLs to the provider/model
    notifier.updateImageUrl(imageUrls);
  }

  @override
  Future<bool> validate(WidgetRef ref) {
    bool is_valid = _formKey.currentState?.validate() ?? false;
    print("Validating informations... status: $is_valid");
    return Future.value(is_valid);
  }
}
