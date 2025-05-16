import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BreadCrumbPage<N extends StateNotifier<O>, O> extends ConsumerStatefulWidget {
  final StateNotifierProvider<N, O> objectProvider;

  const BreadCrumbPage({super.key, required this.objectProvider});
}

abstract class BreadCrumbPageState<T extends BreadCrumbPage<N, O>, N extends StateNotifier<O>, O>
    extends ConsumerState<T> {

  /// Every step/page should implement this to validate its form/data.
  /// Return true if valid, false otherwise.
  Future<bool> validate(WidgetRef ref);

  /// Every step/page must implement this to update its data to the provider.
  Future<void> update(WidgetRef ref);

  /// Only the last page should implement this to save the final data.
  Future<void> save(WidgetRef ref) async {}
}
