import 'package:cooka/widgets/breadcrumb/breadcrumb_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/breadcrum_provider.dart';
import 'package:cooka/widgets/breadcrumb/breadcrumb_navigator.dart';

class BreadcrumbRouter extends ConsumerStatefulWidget {
  final List<String> allItems; // All breadcrumb items
  final Map<String, BreadCrumbPage Function(BuildContext)> routes; // Routes map

  const BreadcrumbRouter(
      {super.key, required this.allItems, required this.routes});

  @override
  ConsumerState<BreadcrumbRouter> createState() => _BreadcrumbRouterState();
}

class _BreadcrumbRouterState extends ConsumerState<BreadcrumbRouter> {
  late String currentRoute; // Track the current route
  late final Map<String, BreadCrumbPage> builtPages;

  @override
  void initState() {
    super.initState();
    currentRoute = widget.allItems.first;

    builtPages = {
      for (final entry in widget.routes.entries)
        entry.key: entry.value(context),
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(breadcrumbProvider.notifier).setActiveBreadcrumb(currentRoute);
    });
  }

  void navigateTo(String route, {required bool goFarward}) async {
    if (!widget.allItems.contains(route)) return;

    final currentPage = builtPages[currentRoute]!;
    final state = currentPage.key is GlobalKey<BreadCrumbPageState>
        ? (currentPage.key as GlobalKey<BreadCrumbPageState>).currentState
        : null;

    if (state != null) {
      if (goFarward) {
        final isValid = await state.validate(ref);
        if (!isValid) return;
      }

      final isLast = currentRoute == widget.allItems.last;
      await state.update(ref);
      if (isLast) {
        await state.save(ref);
        // Pop the screen after saving
        if (mounted) Navigator.pop(context);
        return; // Don't change route after finishing
      }
    }

    setState(() {
      currentRoute = route;
      ref.read(breadcrumbProvider.notifier).setActiveBreadcrumb(route);
    });
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
      padding: const EdgeInsets.only(
          top: 8.0, bottom: 40.0, left: 12.0, right: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Breadcrumb Navigator
          Expanded(
            child: BreadcrumbNavigator(
              allItems: widget.allItems,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: builtPages[currentRoute]!,
              ),
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
                    ? () => navigateTo(widget.allItems[currentIndex - 1],
                        goFarward: false)
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
                    ? () => navigateTo(widget.allItems[currentIndex + 1],
                        goFarward: true)
                    : () => navigateTo(currentRoute, goFarward: true),
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
