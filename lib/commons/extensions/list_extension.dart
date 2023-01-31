import 'package:collection/collection.dart';

extension NullableListExtension<T> on List<T>? {
  bool get isNullOrEmpty {
    return this == null || this!.isEmpty;
  }

  bool get isNotNullOrEmpty {
    return !isNullOrEmpty;
  }

  int countWhere(bool Function(T element) condition) {
    return this?.where(condition).length ?? 0;
  }
}

extension ListExtension<T> on List<T> {
  void addIfNotNull(T newValue) {
    if (newValue != null) {
      add(newValue);
    }
  }

  void addIfAbsent(T newValue) {
    if (!contains(newValue)) {
      add(newValue);
    }
  }

  T? firstOrNullWhere(bool Function(T element) test) {
    return firstWhereOrNull(test);
  }
}
