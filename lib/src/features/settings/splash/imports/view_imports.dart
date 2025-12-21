import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/notification/notification_service.dart';
import '../../../../core/shared/cubits/base_url/base_url_cubit.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';

part '../cubit/splash_state.dart';
part '../cubit/splash_cubit.dart';
part '../screens/splash_screen.dart';
