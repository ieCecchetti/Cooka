import 'package:flutter_riverpod/flutter_riverpod.dart';

final breadcrumbProvider = StateNotifierProvider<BreadcrumbNotifier, String>((ref) {
  return BreadcrumbNotifier();
});

class BreadcrumbNotifier extends StateNotifier<String> {
  BreadcrumbNotifier() : super('Information'); // Default to the first page

  void setActiveBreadcrumb(String name) {
    state = name; // Update the active breadcrumb
  }
}