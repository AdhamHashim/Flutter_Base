import 'dart:async';

class DepouncedOpiration {
  final Duration duration;
  DepouncedOpiration({
    this.duration = const Duration(milliseconds: 400),
  });
  Timer? timer;
  Future<void> excuteOpiration({
    required Function() operation,
  }) async {
    if (timer?.isActive ?? false) return Future.value();
    timer = Timer(duration, operation);
  }
}
