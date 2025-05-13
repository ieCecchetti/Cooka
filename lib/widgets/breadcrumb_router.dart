import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/breadcrum_provider.dart';
import 'package:cooka/widgets/breadcrumb_navigator.dart';

class BreadcrumbRouter extends ConsumerStatefulWidget {
  final List<String> allItems; // All breadcrumb items
  final Map<String, Widget Function(BuildContext)> routes; // Routes map

  const BreadcrumbRouter({
    Key? key,
    required this.allItems,
    required this.routes,
  }) : super(key: key);

  @override
  ConsumerState<BreadcrumbRouter> createState() => _BreadcrumbRouterState();
}

class _BreadcrumbRouterState extends ConsumerState<BreadcrumbRouter> {
  late String currentRoute; // Track the current route

  @override
  void initState() {
    super.initState();
    currentRoute = widget.allItems.first; // Start with the first breadcrumb
    ref.read(breadcrumbProvider.notifier).setActiveBreadcrumb(currentRoute);
  }

  void navigateTo(String route) {
    if (widget.allItems.contains(route)) {
      setState(() {
        currentRoute = route;
        ref.read(breadcrumbProvider.notifier).setActiveBreadcrumb(route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.allItems.indexOf(currentRoute);

    // Ensure currentIndex is valid
    if (currentIndex == -1) {
      return const Center(
        child: Text("Invalid route"),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 40.0, left: 12.0, right: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Breadcrumb Navigator
          Expanded(
            child: BreadcrumbNavigator(
              allItems: widget.allItems,
              child: widget.routes[currentRoute]!(context),
            ),
          ),
          const SizedBox(height: 16),
          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous Button
              ElevatedButton(
                onPressed: currentIndex > 0
                    ? () => navigateTo(widget.allItems[currentIndex - 1])
                    : null, // Disable if on the first page
                child: Text(
                  currentIndex > 0
                      ? "Previous: ${widget.allItems[currentIndex - 1]}"
                      : "Previous",
                ),
              ),
              // Next or Finish Button
              ElevatedButton(
                onPressed: currentIndex < widget.allItems.length - 1
                    ? () => navigateTo(widget.allItems[currentIndex + 1])
                    : () {
                        // Handle Finish action
                        Navigator.pop(context); // Example: Go back to the previous screen
                      },
                child: Text(
                  currentIndex < widget.allItems.length - 1
                      ? "Next: ${widget.allItems[currentIndex + 1]}"
                      : "Finish",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
