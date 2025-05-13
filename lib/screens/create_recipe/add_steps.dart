import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/breadcrum_provider.dart';

class AddStepsPage extends ConsumerStatefulWidget {
  const AddStepsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AddStepsPage> createState() => _AddStepsPageState();
}

class _AddStepsPageState extends ConsumerState<AddStepsPage> {
  final List<Map<String, dynamic>> steps = [];

  @override
  void initState() {
    super.initState();
    // Set the active breadcrumb in initState
    final breadcrumbNotifier = ref.read(breadcrumbProvider.notifier);
    breadcrumbNotifier.setActiveBreadcrumb("Steps");
  }

  void _addStep() {
    showDialog(
      context: context,
      builder: (context) {
        final TextEditingController descriptionController =
            TextEditingController();
        final TextEditingController timeController = TextEditingController();
        String difficulty = "Easy";

        return AlertDialog(
          title: const Text("Add Step"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: timeController,
                decoration: const InputDecoration(labelText: "Time (minutes)"),
                keyboardType: TextInputType.number,
              ),
              DropdownButtonFormField<String>(
                value: difficulty,
                items: ["Easy", "Medium", "Hard"]
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level),
                        ))
                    .toList(),
                onChanged: (value) {
                  difficulty = value!;
                },
                decoration: const InputDecoration(labelText: "Difficulty"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  steps.add({
                    "description": descriptionController.text,
                    "time": int.tryParse(timeController.text) ?? 0,
                    "difficulty": difficulty,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Steps",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...steps.map((step) => ListTile(
              title: Text(step["description"]),
              subtitle: Text(
                  "Time: ${step["time"]} min | Difficulty: ${step["difficulty"]}"),
            )),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _addStep,
          child: const Text("Add Step"),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                ref
                    .read(breadcrumbProvider.notifier)
                    .setActiveBreadcrumb("Ingredients");
                Navigator.pop(context);
              },
              child: const Text("Go Back"),
            ),
            ElevatedButton(
              onPressed: () {
                // Clear breadcrumbs and navigate back to the main screen
                print('saving steps');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Steps saved successfully!")),
                );
                Navigator.pop(context);
              },
              child: const Text("Next: Finish"),
            ),
          ],
        ),
      ],
    );
  }
}
