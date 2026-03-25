import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/auto_scrolll_validation_extention.dart';
import '../../../../../core/extensions/form_mixin.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/extensions/widgets/padding_extension.dart';
import '../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../core/extensions/widgets/widget_extension.dart';
import '../../../../../core/helpers/input_formatters.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../../core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';
import '../../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../../../../../core/widgets/icon_widget.dart';
import '../../../../../core/widgets/pickers/default_bottom_sheet.dart';
import '../../../../../core/widgets/scaffolds/default_scaffold.dart';
import '../../entity/profile_entity.dart';
import '../change_password_view_controller.dart';
import '../profile_edit_view_controller.dart';

part '../view/profile_account_screen.dart';
part '../view/profile_edit_screen.dart';
part '../widgets/profile_account_body.dart';
part '../widgets/profile_edit_body.dart';
part '../widgets/change_password_sheet_widget.dart';
