import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cooka/providers/breadcrum_provider.dart';

class BreadcrumbNavigator extends ConsumerWidget {
  final Widget child;
  final List<String> allItems; // All breadcrumb items

  const BreadcrumbNavigator({
    Key? key,
    required this.child,
    required this.allItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeBreadcrumb =
        ref.watch(breadcrumbProvider); // Watch the active breadcrumb

    return Column(
      children: [
        BreadCrumb.builder(
          itemCount: allItems.length,
          builder: (index) {
            final isActive = allItems[index] == activeBreadcrumb;
            return BreadCrumbItem(
              content: GestureDetector(
                onTap: () {
                  // Update the active breadcrumb and navigate
                  // final route = allItems[index];
                  // breadcrumbNotifier.setActiveBreadcrumb(route);
                  // Navigator.pushNamed(context, route);
                  // do nothing
                },
                child: Text(
                  allItems[index],
                  style: TextStyle(
                    color: isActive ? Colors.blue : Colors.grey,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
          divider: const Icon(Icons.chevron_right),
        ),
        Expanded(child: child),
      ],
    );
  }
}
