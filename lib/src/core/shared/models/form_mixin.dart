import 'package:flutter/cupertino.dart';

mixin FormMixin {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() => !formKey.currentState!.validate();
}
