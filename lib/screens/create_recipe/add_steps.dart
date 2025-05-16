import 'dart:io';

import 'package:cooka/models/recipe.dart';
import 'package:cooka/utils/backend.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cooka/data/difficulty.dart';
import 'package:cooka/models/prep_step.dart';

import 'package:cooka/providers/breadcrum_provider.dart';
import 'package:cooka/providers/create_recipe_provider.dart';
import 'package:cooka/providers/recipe_provider.dart';

class AddStepsPage extends BreadCrumbPage<CreateRecipeNotifier, Recipe> {
  const AddStepsPage({super.key, required super.objectProvider});

  @override
  ConsumerState<AddStepsPage> createState() => _AddStepsPageState();
}

class _AddStepsPageState
    extends BreadCrumbPageState<AddStepsPage, CreateRecipeNotifier, Recipe> {
  final List<PrepStep> steps = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Set the active breadcrumb in initState
    final breadcrumbNotifier = ref.read(breadcrumbProvider.notifier);
    breadcrumbNotifier.setActiveBreadcrumb("Steps");
  }

  void _addStep() async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    Difficulty difficulty = Difficulty.easy;
    String? imageUrl; // Store the uploaded image URL

    final newStep = await showDialog<PrepStep>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Step Counter
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Step ${steps.length + 1}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Icon(
                                Icons.restaurant,
                                color: Colors.blue,
                                size: 28,
                              ),
                            ],
                          ),
                          const Divider(thickness: 1.0, height: 24.0),
                          // Title Field
                          TextField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: "Title",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.title),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Description Field
                          TextField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: "Description",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.description),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          // Time Field
                          TextField(
                            controller: timeController,
                            decoration: const InputDecoration(
                              labelText: "Time (minutes)",
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.timer),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(height: 16),
                          // Difficulty Dropdown
                          DropdownButtonFormField<Difficulty>(
                            value: difficulty,
                            decoration: const InputDecoration(
                              labelText: "Difficulty",
                              border: OutlineInputBorder(),
                            ),
                            items: Difficulty.values
                                .map(
                                  (level) => DropdownMenuItem(
                                    value: level,
                                    child: Text(level.getText),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                difficulty = value!;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Image Picker
                          if (imageUrl != null)
                            Center(
                              child: Image.network(
                                imageUrl!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            const Center(
                              child: Text(
                                "No image selected",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          const SizedBox(height: 8),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                final pickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (pickedFile != null) {
                                  // Instantly upload and get the network URL
                                  final uploadedUrl =
                                      await uploadImageToBackend(
                                    File(pickedFile.path),
                                    'https://your-backend.com/upload',
                                  );
                                  if (uploadedUrl.isNotEmpty) {
                                    setState(() {
                                      imageUrl = uploadedUrl;
                                    });
                                  }
                                }
                              },
                              icon: const Icon(Icons.image),
                              label: const Text("Pick Image"),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (titleController.text.trim().isEmpty ||
                                    descriptionController.text.trim().isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Title and description are required.")),
                                  );
                                  return;
                                }

                                // Create the new step with the network image URL
                                final newStep = PrepStep(
                                  id: steps.length + 1,
                                  title: titleController.text.trim(),
                                  description:
                                      descriptionController.text.trim(),
                                  time:
                                      int.tryParse(timeController.text.trim()),
                                  difficulty: difficulty,
                                  image: imageUrl, // Store the network URL
                                );

                                Navigator.of(context).pop(newStep);
                              },
                              icon: const Icon(Icons.save),
                              label: const Text("Save Step"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );

    // Add the new step to the list and rebuild the parent widget
    if (newStep != null) {
      setState(() {
        steps.add(newStep);
      });
    }
  }

  @override
  Future<void> update(WidgetRef ref) async {
    print("Saving steps...");
    final notifier = ref.read(widget.objectProvider.notifier);
    // Save the updated steps with image URLs to the provider
    notifier.updateSteps(steps);
  }

  @override
  Future<bool> validate(WidgetRef ref) async {
    if (steps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one step')),
      );
      return false;
    }
    return true;
  }

  @override
  Future<void> save(WidgetRef ref) async {
    print("Saving and adding recipe to dummy list...");

    // Add the recipe to the dummy list
    final recipe =
        ref.read(widget.objectProvider); // Retrieve the recipe object
    ref.read(recipesProvider.notifier).addRecipe(recipe);
    ref.read(createRecipesProvider.notifier).resetRecipe();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recipe stored successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // Consistent padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Steps",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Add Step Button at the top
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: _addStep,
              icon: const Icon(Icons.add),
              label: const Text("Add Step"),
            ),
          ),
          const SizedBox(height: 16),
          // List of Steps
          Expanded(
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                final step = steps[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${index + 1}'),
                  ),
                  title: Text(step.title),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Step ${index + 1}: ${step.title}'),
                          content: Text(step.description),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Close"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  subtitle: Text(
                    "Time: ${step.time ?? 0} min | Difficulty: ${step.difficulty?.name ?? 'N/A'}",
                  ),
                  trailing: step.image != null
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      step.image!.startsWith('http')
                                          ? Image.network(
                                              step.image!,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(step.image!),
                                              fit: BoxFit.cover,
                                            ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Close"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            height: 50,
                            width: 50,
                            child: step.image!.startsWith('http')
                                ? Image.network(
                                    step.image!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(step.image!),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        )
                      : const Icon(Icons.image),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
