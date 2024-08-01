import 'package:flutter_riverpod/flutter_riverpod.dart';

class BotttomNavIndexNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void changeIndex(int index) {
    state = index;
  }
}

final bottomNavIndexProvider = NotifierProvider<BotttomNavIndexNotifier, int>(
  () {
    return BotttomNavIndexNotifier();
  },
);

// final currentIndex = StateProvider((ref) => 0);
