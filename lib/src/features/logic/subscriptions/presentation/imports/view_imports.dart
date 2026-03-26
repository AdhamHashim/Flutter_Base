import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/extensions/widgets/padding_extension.dart';
import '../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_messages.dart';
import '../../../../../core/widgets/fields/text_fields/default_text_field.dart';
import '../../../../../core/widgets/icon_widget.dart';
import '../../../../../core/widgets/pickers/default_bottom_sheet.dart';
import '../../../../../core/widgets/riyal_price_text.dart';
import '../../../../../core/widgets/scaffolds/default_scaffold.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../entity/subscription_ui_constants.dart';
import '../view_controller/subscriptions_view_controller.dart';

part '../view/subscriptions_screen.dart';
part '../widgets/subscriptions_body.dart';
part '../widgets/subscriptions_trial_banner.dart';
part '../widgets/subscriptions_plan_toggle.dart';
part '../widgets/subscriptions_plan_price_section.dart';
part '../widgets/subscriptions_feature_row.dart';
part '../widgets/subscriptions_discount_row.dart';
part '../widgets/subscriptions_important_note.dart';
part '../widgets/subscriptions_plan_card.dart';
part '../widgets/subscriptions_payment_sheet.dart';
part '../widgets/subscriptions_success_sheet.dart';
