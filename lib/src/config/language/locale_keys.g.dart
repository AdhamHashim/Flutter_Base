import 'package:easy_localization/easy_localization.dart';

abstract class LocaleKeys {
  static const String _areYouSureYouWantToDeleteAccount = 'are_you_sure_you_want_to_delete_account';
  static String get areYouSureYouWantToDeleteAccount => _areYouSureYouWantToDeleteAccount.tr();

  static const String _badRequest = 'bad_request';
  static String get badRequest => _badRequest.tr();

  static const String _camera = 'camera';
  static String get camera => _camera.tr();

  static const String _selectFile = 'select_file';
  static String get selectFile => _selectFile.tr();

  static const String _selectImage = 'select_image';
  static String get selectImage => _selectImage.tr();

  static const String _cancel = 'cancel';
  static String get cancel => _cancel.tr();

  static const String _cannotSelectAttachmentsExceptPdf = 'cannot_select_attachments_except_pdf';
  static String get cannotSelectAttachmentsExceptPdf => _cannotSelectAttachmentsExceptPdf.tr();

  static const String _category = 'category';
  static String get category => _category.tr();

  static const String _changeEmail = 'change_email';
  static String get changeEmail => _changeEmail.tr();

  static const String _changePassword = 'change_password';
  static String get changePassword => _changePassword.tr();

  static const String _changePhone = 'change_phone';
  static String get changePhone => _changePhone.tr();

  static const String _changePhoneNewScreenTitle = 'change_phone_new_screen_title';
  static String get changePhoneNewScreenTitle => _changePhoneNewScreenTitle.tr();

  static const String _changePhoneNewScreenSubtitle = 'change_phone_new_screen_subtitle';
  static String get changePhoneNewScreenSubtitle => _changePhoneNewScreenSubtitle.tr();

  static const String _changePhoneCountryCodeLabel = 'change_phone_country_code_label';
  static String get changePhoneCountryCodeLabel => _changePhoneCountryCodeLabel.tr();

  static const String _changePhoneCountryCodeHint = 'change_phone_country_code_hint';
  static String get changePhoneCountryCodeHint => _changePhoneCountryCodeHint.tr();

  static const String _changePhoneOtpSubtitleMasked = 'change_phone_otp_subtitle_masked';
  static String changePhoneOtpSubtitleMasked({required String masked}) => _changePhoneOtpSubtitleMasked.tr(namedArgs: {'masked': masked});

  static const String _changePhoneResendCode = 'change_phone_resend_code';
  static String get changePhoneResendCode => _changePhoneResendCode.tr();

  static const String _changePhoneSuccessTitle = 'change_phone_success_title';
  static String get changePhoneSuccessTitle => _changePhoneSuccessTitle.tr();

  static const String _changePhoneSuccessSubtitle = 'change_phone_success_subtitle';
  static String get changePhoneSuccessSubtitle => _changePhoneSuccessSubtitle.tr();

  static const String _changePhoneBackToHome = 'change_phone_back_to_home';
  static String get changePhoneBackToHome => _changePhoneBackToHome.tr();

  static const String _retryAction = 'retry_action';
  static String get retryAction => _retryAction.tr();

  static const String _dataUpdatedSuccessfully = 'data_updated_successfully';
  static String get dataUpdatedSuccessfully => _dataUpdatedSuccessfully.tr();

  static const String _char = 'char';
  static String get char => _char.tr();

  static const String _checkInternet = 'check_internet';
  static String get checkInternet => _checkInternet.tr();

  static const String _contactUs = 'contact_us';
  static String get contactUs => _contactUs.tr();

  static const String _contactUsSupportTitle = 'contact_us_support_title';
  static String get contactUsSupportTitle => _contactUsSupportTitle.tr();

  static const String _contactUsNameHint = 'contact_us_name_hint';
  static String get contactUsNameHint => _contactUsNameHint.tr();

  static const String _contactUsPhoneHint = 'contact_us_phone_hint';
  static String get contactUsPhoneHint => _contactUsPhoneHint.tr();

  static const String _contactUsRequestTypeLabel = 'contact_us_request_type_label';
  static String get contactUsRequestTypeLabel => _contactUsRequestTypeLabel.tr();

  static const String _contactUsRequestTypeHint = 'contact_us_request_type_hint';
  static String get contactUsRequestTypeHint => _contactUsRequestTypeHint.tr();

  static const String _contactUsDetailsLabel = 'contact_us_details_label';
  static String get contactUsDetailsLabel => _contactUsDetailsLabel.tr();

  static const String _contactUsDetailsHint = 'contact_us_details_hint';
  static String get contactUsDetailsHint => _contactUsDetailsHint.tr();

  static const String _contactUsAttachmentTitle = 'contact_us_attachment_title';
  static String get contactUsAttachmentTitle => _contactUsAttachmentTitle.tr();

  static const String _contactUsAttachmentOptional = 'contact_us_attachment_optional';
  static String get contactUsAttachmentOptional => _contactUsAttachmentOptional.tr();

  static const String _contactUsTapAddImage = 'contact_us_tap_add_image';
  static String get contactUsTapAddImage => _contactUsTapAddImage.tr();

  static const String _contactUsAttachmentFormats = 'contact_us_attachment_formats';
  static String get contactUsAttachmentFormats => _contactUsAttachmentFormats.tr();

  static const String _contactUsOr = 'contact_us_or';
  static String get contactUsOr => _contactUsOr.tr();

  static const String _contactUsWhatsapp = 'contact_us_whatsapp';
  static String get contactUsWhatsapp => _contactUsWhatsapp.tr();

  static const String _contactUsConfirm = 'contact_us_confirm';
  static String get contactUsConfirm => _contactUsConfirm.tr();

  static const String _contactUsSuccessAdmin = 'contact_us_success_admin';
  static String get contactUsSuccessAdmin => _contactUsSuccessAdmin.tr();

  static const String _contactUsAttachmentTooLarge = 'contact_us_attachment_too_large';
  static String get contactUsAttachmentTooLarge => _contactUsAttachmentTooLarge.tr();

  static const String _copiedToClipboard = 'copied_to_clipboard';
  static String get copiedToClipboard => _copiedToClipboard.tr();

  static const String _unauthorized = 'unauthorized';
  static String get unauthorized => _unauthorized.tr();

  static const String _confirmNewPassword = 'confirm_new_password';
  static String get confirmNewPassword => _confirmNewPassword.tr();

  static const String _confirmPassword = 'confirm_password';
  static String get confirmPassword => _confirmPassword.tr();

  static const String _confirmValidation = 'confirm_validation';
  static String get confirmValidation => _confirmValidation.tr();

  static const String _continueAsA = 'continue_as_a';
  static String get continueAsA => _continueAsA.tr();

  static const String _createAccount = 'create_account';
  static String get createAccount => _createAccount.tr();

  static const String _verifyAccount = 'verify_account';
  static String get verifyAccount => _verifyAccount.tr();

  static const String _cropper = 'cropper';
  static String get cropper => _cropper.tr();

  static const String _currentPassword = 'current_password';
  static String get currentPassword => _currentPassword.tr();

  static const String _currentPhone = 'current_phone';
  static String get currentPhone => _currentPhone.tr();

  static const String _dateCannontBeAfter = 'date_cannont_be_after';
  static String get dateCannontBeAfter => _dateCannontBeAfter.tr();

  static const String _didNotGetVerifyNumber = 'did_not_get_verify_number';
  static String get didNotGetVerifyNumber => _didNotGetVerifyNumber.tr();

  static const String _doNotHaveAnAccount = 'do_not_have_an_account';
  static String get doNotHaveAnAccount => _doNotHaveAnAccount.tr();

  static const String _doYouHaveTaxNumber = 'do_you_have_tax_number';
  static String get doYouHaveTaxNumber => _doYouHaveTaxNumber.tr();

  static const String _edit = 'edit';
  static String get edit => _edit.tr();

  static const String _details = 'details';
  static String get details => _details.tr();

  static const String _welcome = 'welcome';
  static String get welcome => _welcome.tr();

  static const String _progressFaild = 'progress_faild';
  static String get progressFaild => _progressFaild.tr();

  static const String _serverError = 'server_error';
  static String get serverError => _serverError.tr();

  static const String _errorExeptionNoconnection = 'error_exeption_noconnection';
  static String get errorExeptionNoconnection => _errorExeptionNoconnection.tr();

  static const String _errorExeptionNointernetDesc = 'error_exeption_nointernet_desc';
  static String get errorExeptionNointernetDesc => _errorExeptionNointernetDesc.tr();

  static const String _errorExceptionNotContain = 'error_exception_not_contain';
  static String get errorExceptionNotContain => _errorExceptionNotContain.tr();

  static const String _errorExceptionNotContainDesc = 'error_exception_not_contain_desc';
  static String get errorExceptionNotContainDesc => _errorExceptionNotContainDesc.tr();

  static const String _visitorText = 'visitor_text';
  static String get visitorText => _visitorText.tr();

  static const String _email = 'email';
  static String get email => _email.tr();

  static const String _emptyOtpRequired = 'empty_otp_required';
  static String get emptyOtpRequired => _emptyOtpRequired.tr();

  static const String _errorExceptionNoconnection = 'error_exception_noconnection';
  static String get errorExceptionNoconnection => _errorExceptionNoconnection.tr();

  static const String _errorExeptionNoConnection = 'error_exeption_no_connection';
  static String get errorExeptionNoConnection => _errorExeptionNoConnection.tr();

  static const String _errorexceptionNointernetdesc = 'errorexception_nointernetdesc';
  static String get errorexceptionNointernetdesc => _errorexceptionNointernetdesc.tr();

  static const String _errorexceptionNotcontain = 'errorexception_notcontain';
  static String get errorexceptionNotcontain => _errorexceptionNotcontain.tr();

  static const String _errorexceptionNotcontaindesc = 'errorexception_notcontaindesc';
  static String get errorexceptionNotcontaindesc => _errorexceptionNotcontaindesc.tr();

  static const String _exceptionError = 'exception_error';
  static String get exceptionError => _exceptionError.tr();

  static const String _excpetionErrorDesc = 'excpetion_error_desc';
  static String get excpetionErrorDesc => _excpetionErrorDesc.tr();

  static const String _file = 'file';
  static String get file => _file.tr();

  static const String _fileSelectedSuccessfully = 'file_selected_successfully';
  static String get fileSelectedSuccessfully => _fileSelectedSuccessfully.tr();

  static const String _fillField = 'fill_field';
  static String get fillField => _fillField.tr();

  static const String _forgotPassword = 'forgot_password';
  static String get forgotPassword => _forgotPassword.tr();

  static const String _fullNameShouldBeThreeAtLeast = 'full_name_should_be_three_at_least';
  static String get fullNameShouldBeThreeAtLeast => _fullNameShouldBeThreeAtLeast.tr();

  static const String _home = 'home';
  static String get home => _home.tr();

  static const String _idNumber = 'id_number';
  static String get idNumber => _idNumber.tr();

  static const String _incorrectEmailOrPassword = 'incorrect_email_or_password';
  static String get incorrectEmailOrPassword => _incorrectEmailOrPassword.tr();

  static const String _intenetWeakness = 'intenet_weakness';
  static String get intenetWeakness => _intenetWeakness.tr();

  static const String _internetConnectionRestored = 'internet_connection_restored';
  static String get internetConnectionRestored => _internetConnectionRestored.tr();

  static const String _loading = 'loading';
  static String get loading => _loading.tr();

  static const String _mailValidation = 'mail_validation';
  static String get mailValidation => _mailValidation.tr();

  static const String _must = 'must';
  static String get must => _must.tr();

  static const String _name = 'name';
  static String get name => _name.tr();

  static const String _newEmail = 'new_email';
  static String get newEmail => _newEmail.tr();

  static const String _newPassword = 'new_password';
  static String get newPassword => _newPassword.tr();

  static const String _newPhone = 'new_phone';
  static String get newPhone => _newPhone.tr();

  static const String _noDataFound = 'no_data_found';
  static String get noDataFound => _noDataFound.tr();

  static const String _notFound = 'not_found';
  static String get notFound => _notFound.tr();

  static const String _operationFaild = 'operation_faild';
  static String get operationFaild => _operationFaild.tr();

  static const String _optional = 'optional';
  static String get optional => _optional.tr();

  static const String _passRequiredValidation = 'pass_required_validation';
  static String get passRequiredValidation => _passRequiredValidation.tr();

  static const String _passValidation = 'pass_validation';
  static String get passValidation => _passValidation.tr();

  static const String _password = 'password';
  static String get password => _password.tr();

  static const String _phoneNumber = 'phone_number';
  static String get phoneNumber => _phoneNumber.tr();

  static const String _phoneNumberVerification = 'phone_number_verification';
  static String get phoneNumberVerification => _phoneNumberVerification.tr();

  static const String _phoneValidation = 'phone_validation';
  static String get phoneValidation => _phoneValidation.tr();

  static const String _appPhoneValidation = 'app_phone_validation';
  static String get appPhoneValidation => _appPhoneValidation.tr();

  static const String _photoLibrary = 'photo_library';
  static String get photoLibrary => _photoLibrary.tr();

  static const String _pleaseAdd = 'please_add';
  static String get pleaseAdd => _pleaseAdd.tr();

  static const String _pleaseEnterTheCodeSentTo = 'please_enter_the_code_sent_to';
  static String get pleaseEnterTheCodeSentTo => _pleaseEnterTheCodeSentTo.tr();

  static const String _pleaseEnterTheVerificationCodeSentToYourEmail = 'please_enter_the_verification_code_sent_to_your_email';
  static String get pleaseEnterTheVerificationCodeSentToYourEmail => _pleaseEnterTheVerificationCodeSentToYourEmail.tr();

  static const String _pleaseEnterTheVerificationCodeSentToYourMobilePhone = 'please_enter_the_verification_code_sent_to_your_mobile_phone';
  static String get pleaseEnterTheVerificationCodeSentToYourMobilePhone => _pleaseEnterTheVerificationCodeSentToYourMobilePhone.tr();

  static const String _pleaseEnterYourConfirmPassword = 'please_enter_your_confirm_password';
  static String get pleaseEnterYourConfirmPassword => _pleaseEnterYourConfirmPassword.tr();

  static const String _pleaseEnterYourCurrentPassword = 'please_enter_your_current_password';
  static String get pleaseEnterYourCurrentPassword => _pleaseEnterYourCurrentPassword.tr();

  static const String _pleaseEnterYourNewEmail = 'please_enter_your_new_email';
  static String get pleaseEnterYourNewEmail => _pleaseEnterYourNewEmail.tr();

  static const String _pleaseEnterYourNewPassword = 'please_enter_your_new_password';
  static String get pleaseEnterYourNewPassword => _pleaseEnterYourNewPassword.tr();

  static const String _pleaseEnterYourPassword = 'please_enter_your_password';
  static String get pleaseEnterYourPassword => _pleaseEnterYourPassword.tr();

  static const String _pleaseEnterYourPhoneNumber = 'please_enter_your_phone_number';
  static String get pleaseEnterYourPhoneNumber => _pleaseEnterYourPhoneNumber.tr();

  static const String _scripInjectionValidate = 'scrip_injection_validate';
  static String get scripInjectionValidate => _scripInjectionValidate.tr();

  static const String _filedValidation = 'filed_validation';
  static String get filedValidation => _filedValidation.tr();

  static const String _please = 'please';
  static String get please => _please.tr();

  static const String _search = 'search';
  static String get search => _search.tr();

  static const String _confirm = 'confirm';
  static String get confirm => _confirm.tr();

  static const String _next = 'next';
  static String get next => _next.tr();

  static const String _others = 'others';
  static String get others => _others.tr();

  static const String _no = 'no';
  static String get no => _no.tr();

  static const String _yes = 'yes';
  static String get yes => _yes.tr();

  static const String _writeWhatYouWant = 'write_what_you_want';
  static String get writeWhatYouWant => _writeWhatYouWant.tr();

  static const String _viewAll = 'view_all';
  static String get viewAll => _viewAll.tr();

  static const String _location = 'location';
  static String get location => _location.tr();

  static const String _showDetails = 'show_details';
  static String get showDetails => _showDetails.tr();

  static const String _back = 'back';
  static String get back => _back.tr();

  static const String _submit = 'submit';
  static String get submit => _submit.tr();

  static const String _passSymbols = 'pass_symbols';
  static String get passSymbols => _passSymbols.tr();

  static const String _passExample = 'pass_example';
  static String get passExample => _passExample.tr();

  static const String _malee = 'malee';
  static String get malee => _malee.tr();

  static const String _femalee = 'femalee';
  static String get femalee => _femalee.tr();

  static const String _noItemsFound = 'no_items_found';
  static String get noItemsFound => _noItemsFound.tr();

  static const String _oFF = 'o_f_f';
  static String get oFF => _oFF.tr();

  static const String _userValidityExpired = 'user_validity_expired';
  static String get userValidityExpired => _userValidityExpired.tr();

  static const String _biometricNotAvailable = 'biometric_not_available';
  static String get biometricNotAvailable => _biometricNotAvailable.tr();

  static const String _enterToSignIn = 'enter_to_sign_in';
  static String get enterToSignIn => _enterToSignIn.tr();

  static const String _login = 'login';
  static String get login => _login.tr();

  static const String _register = 'register';
  static String get register => _register.tr();

  static const String _minLengthValidation = 'min_length_validation';
  static String get minLengthValidation => _minLengthValidation.tr();

  static const String _validationHeightRange = 'validation_height_range';
  static String get validationHeightRange => _validationHeightRange.tr();

  static const String _validationWeightRange = 'validation_weight_range';
  static String get validationWeightRange => _validationWeightRange.tr();

  static const String _validationInvalidDate = 'validation_invalid_date';
  static String get validationInvalidDate => _validationInvalidDate.tr();

  static const String _validationMaxLength = 'validation_max_length';
  static String get validationMaxLength => _validationMaxLength.tr();

  static const String _validationWorkingHoursRange = 'validation_working_hours_range';
  static String get validationWorkingHoursRange => _validationWorkingHoursRange.tr();

  static const String _validationSleepHoursRange = 'validation_sleep_hours_range';
  static String get validationSleepHoursRange => _validationSleepHoursRange.tr();

  static const String _validationMealsMin = 'validation_meals_min';
  static String get validationMealsMin => _validationMealsMin.tr();

  static const String _validationSnacksMin = 'validation_snacks_min';
  static String get validationSnacksMin => _validationSnacksMin.tr();

  static const String _validationWaterIntakeMin = 'validation_water_intake_min';
  static String get validationWaterIntakeMin => _validationWaterIntakeMin.tr();

  static const String _validationAttemptsMin = 'validation_attempts_min';
  static String get validationAttemptsMin => _validationAttemptsMin.tr();

  static const String _validationWeightLossMin = 'validation_weight_loss_min';
  static String get validationWeightLossMin => _validationWeightLossMin.tr();

  static const String _validationCommitmentRange = 'validation_commitment_range';
  static String get validationCommitmentRange => _validationCommitmentRange.tr();

  static const String _validationInvalidNumber = 'validation_invalid_number';
  static String get validationInvalidNumber => _validationInvalidNumber.tr();

  static const String _within = 'within';
  static String get within => _within.tr();

  static const String _reduceWeightBy = 'reduce_weight_by';
  static String get reduceWeightBy => _reduceWeightBy.tr();

  static const String _days = 'days';
  static String get days => _days.tr();

  static const String _showLess = 'show_less';
  static String get showLess => _showLess.tr();

  static const String _showMore = 'show_more';
  static String get showMore => _showMore.tr();

  static const String _permissionRequired = 'permission_required';
  static String get permissionRequired => _permissionRequired.tr();

  static const String _blocked = 'blocked';
  static String get blocked => _blocked.tr();

  static const String _appYourSessionIsExpired = 'app_your_session_is_expired';
  static String get appYourSessionIsExpired => _appYourSessionIsExpired.tr();

  static const String _logout = 'logout';
  static String get logout => _logout.tr();

  static const String _introSkip = 'intro_skip';
  static String get introSkip => _introSkip.tr();

  static const String _introWelcome = 'intro_welcome';
  static String get introWelcome => _introWelcome.tr();

  static const String _introPlatforminfo = 'intro_platforminfo';
  static String get introPlatforminfo => _introPlatforminfo.tr();

  static const String _introBudgetGoals = 'intro_budget_goals';
  static String get introBudgetGoals => _introBudgetGoals.tr();

  static const String _introBillsGuarantees = 'intro_bills_guarantees';
  static String get introBillsGuarantees => _introBillsGuarantees.tr();

  static const String _introStartnow = 'intro_startnow';
  static String get introStartnow => _introStartnow.tr();

  static const String _introNext = 'intro_next';
  static String get introNext => _introNext.tr();

  static const String _oops = 'oops';
  static String get oops => _oops.tr();

  static const String _complaints = 'complaints';
  static String get complaints => _complaints.tr();

  static const String _terms = 'terms';
  static String get terms => _terms.tr();

  static const String _policy = 'policy';
  static String get policy => _policy.tr();

  static const String _faqs = 'faqs';
  static String get faqs => _faqs.tr();

  static const String _whoUs = 'who_us';
  static String get whoUs => _whoUs.tr();

  static const String _contactRequestSendSuccessfully = 'contact_request_send_successfully';
  static String get contactRequestSendSuccessfully => _contactRequestSendSuccessfully.tr();

  static const String _messageLabel = 'message_label';
  static String get messageLabel => _messageLabel.tr();

  static const String _messageHint = 'message_hint';
  static String get messageHint => _messageHint.tr();

  static const String _sendBtn = 'send_btn';
  static String get sendBtn => _sendBtn.tr();

  static const String _successMsg = 'success_msg';
  static String get successMsg => _successMsg.tr();

  static const String _fullNameLabel = 'full_name_label';
  static String get fullNameLabel => _fullNameLabel.tr();

  static const String _complaintsTitle = 'complaints_title';
  static String get complaintsTitle => _complaintsTitle.tr();

  static const String _complaintsNew = 'complaints_new';
  static String get complaintsNew => _complaintsNew.tr();

  static const String _complaintsProgress = 'complaints_progress';
  static String get complaintsProgress => _complaintsProgress.tr();

  static const String _complaintsShowDetails = 'complaints_show_details';
  static String get complaintsShowDetails => _complaintsShowDetails.tr();

  static const String _complaintsResolved = 'complaints_resolved';
  static String get complaintsResolved => _complaintsResolved.tr();

  static const String _complaintsAddBtn = 'complaints_add_btn';
  static String get complaintsAddBtn => _complaintsAddBtn.tr();

  static const String _complaintsReasonLabel = 'complaints_reason_label';
  static String get complaintsReasonLabel => _complaintsReasonLabel.tr();

  static const String _complaintsReasonHint = 'complaints_reason_hint';
  static String get complaintsReasonHint => _complaintsReasonHint.tr();

  static const String _complaintsDetailsLabel = 'complaints_details_label';
  static String get complaintsDetailsLabel => _complaintsDetailsLabel.tr();

  static const String _complaintsDetailsHint = 'complaints_details_hint';
  static String get complaintsDetailsHint => _complaintsDetailsHint.tr();

  static const String _complaintsUploadPhotos = 'complaints_upload_photos';
  static String get complaintsUploadPhotos => _complaintsUploadPhotos.tr();

  static const String _complaintsSuccessMsg = 'complaints_success_msg';
  static String get complaintsSuccessMsg => _complaintsSuccessMsg.tr();

  static const String _complaintsReviewMsg = 'complaints_review_msg';
  static String get complaintsReviewMsg => _complaintsReviewMsg.tr();

  static const String _complaintsDetailsTitle = 'complaints_details_title';
  static String get complaintsDetailsTitle => _complaintsDetailsTitle.tr();

  static const String _complaintsReason = 'complaints_reason';
  static String get complaintsReason => _complaintsReason.tr();

  static const String _complaintsPhotos = 'complaints_photos';
  static String get complaintsPhotos => _complaintsPhotos.tr();

  static const String _complaintsAdminResponse = 'complaints_admin_response';
  static String get complaintsAdminResponse => _complaintsAdminResponse.tr();

  static const String _noComplaintsTitle = 'no_complaints_title';
  static String get noComplaintsTitle => _noComplaintsTitle.tr();

  static const String _noComplaintsDesc = 'no_complaints_desc';
  static String get noComplaintsDesc => _noComplaintsDesc.tr();

  static const String _noNotificationsTitle = 'no_notifications_title';
  static String get noNotificationsTitle => _noNotificationsTitle.tr();

  static const String _noNotificationsDesc = 'no_notifications_desc';
  static String get noNotificationsDesc => _noNotificationsDesc.tr();

  static const String _profile = 'profile';
  static String get profile => _profile.tr();

  static const String _warning = 'warning';
  static String get warning => _warning.tr();

  static const String _settingsTitle = 'settings_title';
  static String get settingsTitle => _settingsTitle.tr();

  static const String _settingsEditProfile = 'settings_edit_profile';
  static String get settingsEditProfile => _settingsEditProfile.tr();

  static const String _settingsChangeEmail = 'settings_change_email';
  static String get settingsChangeEmail => _settingsChangeEmail.tr();

  static const String _settingsChangePassword = 'settings_change_password';
  static String get settingsChangePassword => _settingsChangePassword.tr();

  static const String _settingsNotifications = 'settings_notifications';
  static String get settingsNotifications => _settingsNotifications.tr();

  static const String _settingsBackground = 'settings_background';
  static String get settingsBackground => _settingsBackground.tr();

  static const String _settingsLanguages = 'settings_languages';
  static String get settingsLanguages => _settingsLanguages.tr();

  static const String _settingsDeleteAccount = 'settings_delete_account';
  static String get settingsDeleteAccount => _settingsDeleteAccount.tr();

  static const String _settingsDeleteBlocked = 'settings_delete_blocked';
  static String get settingsDeleteBlocked => _settingsDeleteBlocked.tr();

  static const String _settingsOops = 'settings_oops';
  static String get settingsOops => _settingsOops.tr();

  static const String _profileCountryLabel = 'profile_country_label';
  static String get profileCountryLabel => _profileCountryLabel.tr();

  static const String _profileSaveChanges = 'profile_save_changes';
  static String get profileSaveChanges => _profileSaveChanges.tr();

  static const String _goodToSee = 'good_to_see';
  static String get goodToSee => _goodToSee.tr();

  static const String _guestChatBlocked = 'guest_chat_blocked';
  static String get guestChatBlocked => _guestChatBlocked.tr();

  static const String _guestNotifBlocked = 'guest_notif_blocked';
  static String get guestNotifBlocked => _guestNotifBlocked.tr();

  static const String _moreGeneralTitle = 'more_general_title';
  static String get moreGeneralTitle => _moreGeneralTitle.tr();

  static const String _moreOthersTitle = 'more_others_title';
  static String get moreOthersTitle => _moreOthersTitle.tr();

  static const String _moreSubscriptionTitle = 'more_subscription_title';
  static String get moreSubscriptionTitle => _moreSubscriptionTitle.tr();

  static const String _moreSubscriptionStatusLabel = 'more_subscription_status_label';
  static String get moreSubscriptionStatusLabel => _moreSubscriptionStatusLabel.tr();

  static const String _moreSubscriptionStatusActiveTrial = 'more_subscription_status_active_trial';
  static String get moreSubscriptionStatusActiveTrial => _moreSubscriptionStatusActiveTrial.tr();

  static const String _moreSubscriptionEndsAt = 'more_subscription_ends_at';
  static String moreSubscriptionEndsAt({required String date}) => _moreSubscriptionEndsAt.tr(namedArgs: {'date': date});

  static const String _moreManageSubscription = 'more_manage_subscription';
  static String get moreManageSubscription => _moreManageSubscription.tr();

  static const String _moreAccountSection = 'more_account_section';
  static String get moreAccountSection => _moreAccountSection.tr();

  static const String _moreAccountData = 'more_account_data';
  static String get moreAccountData => _moreAccountData.tr();

  static const String _moreGeneralSettings = 'more_general_settings';
  static String get moreGeneralSettings => _moreGeneralSettings.tr();

  static const String _moreAppSection = 'more_app_section';
  static String get moreAppSection => _moreAppSection.tr();

  static const String _moreBudgetGoalsSetup = 'more_budget_goals_setup';
  static String get moreBudgetGoalsSetup => _moreBudgetGoalsSetup.tr();

  static const String _moreSupportSection = 'more_support_section';
  static String get moreSupportSection => _moreSupportSection.tr();

  static const String _moreTechnicalSupport = 'more_technical_support';
  static String get moreTechnicalSupport => _moreTechnicalSupport.tr();

  static const String _settingsGeneralTitle = 'settings_general_title';
  static String get settingsGeneralTitle => _settingsGeneralTitle.tr();

  static const String _notificationsTitle = 'notifications_title';
  static String get notificationsTitle => _notificationsTitle.tr();

  static const String _notificationsNoNotifications = 'notifications_no_notifications';
  static String get notificationsNoNotifications => _notificationsNoNotifications.tr();

  static const String _notificationsMarkRead = 'notifications_mark_read';
  static String get notificationsMarkRead => _notificationsMarkRead.tr();

  static const String _notificationsClearAll = 'notifications_clear_all';
  static String get notificationsClearAll => _notificationsClearAll.tr();

  static const String _notificationsDeleteAllNotifications = 'notifications_delete_all_notifications';
  static String get notificationsDeleteAllNotifications => _notificationsDeleteAllNotifications.tr();

  static const String _deleteNotification = 'delete_notification';
  static String get deleteNotification => _deleteNotification.tr();

  static const String _notificationsDeleteAllText = 'notifications_delete_all_text';
  static String get notificationsDeleteAllText => _notificationsDeleteAllText.tr();

  static const String _notificationsDeleteSheetTitle = 'notifications_delete_sheet_title';
  static String get notificationsDeleteSheetTitle => _notificationsDeleteSheetTitle.tr();

  static const String _notificationsDeleteSheetDesc = 'notifications_delete_sheet_desc';
  static String get notificationsDeleteSheetDesc => _notificationsDeleteSheetDesc.tr();

  static const String _notificationsDeleteAction = 'notifications_delete_action';
  static String get notificationsDeleteAction => _notificationsDeleteAction.tr();

  static const String _notificationsSampleHeroTitle = 'notifications_sample_hero_title';
  static String get notificationsSampleHeroTitle => _notificationsSampleHeroTitle.tr();

  static const String _notificationsSampleHeroBody = 'notifications_sample_hero_body';
  static String get notificationsSampleHeroBody => _notificationsSampleHeroBody.tr();

  static const String _notificationsSampleExpenseTitle = 'notifications_sample_expense_title';
  static String get notificationsSampleExpenseTitle => _notificationsSampleExpenseTitle.tr();

  static const String _notificationsSampleExpenseBody = 'notifications_sample_expense_body';
  static String get notificationsSampleExpenseBody => _notificationsSampleExpenseBody.tr();

  static const String _notificationsSampleSavingsTitle = 'notifications_sample_savings_title';
  static String get notificationsSampleSavingsTitle => _notificationsSampleSavingsTitle.tr();

  static const String _notificationsSampleSavingsBody = 'notifications_sample_savings_body';
  static String get notificationsSampleSavingsBody => _notificationsSampleSavingsBody.tr();

  static const String _notificationsRelativeHour = 'notifications_relative_hour';
  static String get notificationsRelativeHour => _notificationsRelativeHour.tr();

  static const String _notificationsRelativeTwoDays = 'notifications_relative_two_days';
  static String get notificationsRelativeTwoDays => _notificationsRelativeTwoDays.tr();

  static const String _dataUpdatingNowComeLater = 'data_updating_now_come_later';
  static String get dataUpdatingNowComeLater => _dataUpdatingNowComeLater.tr();

  static const String _selectAnOption = 'select_an_option';
  static String get selectAnOption => _selectAnOption.tr();

  static const String _noResultFound = 'no_result_found';
  static String get noResultFound => _noResultFound.tr();

  static const String _noOptionsFound = 'no_options_found';
  static String get noOptionsFound => _noOptionsFound.tr();

  static const String _splashAppNameLatin = 'splash_app_name_latin';
  static String get splashAppNameLatin => _splashAppNameLatin.tr();

  static const String _splashAppNameAr = 'splash_app_name_ar';
  static String get splashAppNameAr => _splashAppNameAr.tr();

  static const String _registerCreateAccountTitle = 'register_create_account_title';
  static String get registerCreateAccountTitle => _registerCreateAccountTitle.tr();

  static const String _registerCreateAccountSubtitle = 'register_create_account_subtitle';
  static String get registerCreateAccountSubtitle => _registerCreateAccountSubtitle.tr();

  static const String _registerPhoneLabel = 'register_phone_label';
  static String get registerPhoneLabel => _registerPhoneLabel.tr();

  static const String _registerPhoneHint = 'register_phone_hint';
  static String get registerPhoneHint => _registerPhoneHint.tr();

  static const String _registerUsernameLabel = 'register_username_label';
  static String get registerUsernameLabel => _registerUsernameLabel.tr();

  static const String _registerUsernameHint = 'register_username_hint';
  static String get registerUsernameHint => _registerUsernameHint.tr();

  static const String _registerTypeLabel = 'register_type_label';
  static String get registerTypeLabel => _registerTypeLabel.tr();

  static const String _registerTypeHint = 'register_type_hint';
  static String get registerTypeHint => _registerTypeHint.tr();

  static const String _registerNicknameLabel = 'register_nickname_label';
  static String get registerNicknameLabel => _registerNicknameLabel.tr();

  static const String _registerNicknameHint = 'register_nickname_hint';
  static String get registerNicknameHint => _registerNicknameHint.tr();

  static const String _registerNicknameHelper = 'register_nickname_helper';
  static String get registerNicknameHelper => _registerNicknameHelper.tr();

  static const String _registerPasswordLabel = 'register_password_label';
  static String get registerPasswordLabel => _registerPasswordLabel.tr();

  static const String _registerConfirmPasswordLabel = 'register_confirm_password_label';
  static String get registerConfirmPasswordLabel => _registerConfirmPasswordLabel.tr();

  static const String _registerCreateAccountBtn = 'register_create_account_btn';
  static String get registerCreateAccountBtn => _registerCreateAccountBtn.tr();

  static const String _registerHaveAccountBtn = 'register_have_account_btn';
  static String get registerHaveAccountBtn => _registerHaveAccountBtn.tr();

  static const String _registerVerifyCodeTitle = 'register_verify_code_title';
  static String get registerVerifyCodeTitle => _registerVerifyCodeTitle.tr();

  static const String _registerVerifyCodeSubtitle = 'register_verify_code_subtitle';
  static String get registerVerifyCodeSubtitle => _registerVerifyCodeSubtitle.tr();

  static const String _registerResendAfter = 'register_resend_after';
  static String get registerResendAfter => _registerResendAfter.tr();

  static const String _registerSeconds = 'register_seconds';
  static String get registerSeconds => _registerSeconds.tr();

  static const String _registerDidntReceiveCode = 'register_didnt_receive_code';
  static String get registerDidntReceiveCode => _registerDidntReceiveCode.tr();

  static const String _registerVerifyPhone = 'register_verify_phone';
  static String get registerVerifyPhone => _registerVerifyPhone.tr();

  static const String _registerCreatePinTitle = 'register_create_pin_title';
  static String get registerCreatePinTitle => _registerCreatePinTitle.tr();

  static const String _registerCreatePinSubtitle = 'register_create_pin_subtitle';
  static String get registerCreatePinSubtitle => _registerCreatePinSubtitle.tr();

  static const String _registerConfirmPinTitle = 'register_confirm_pin_title';
  static String get registerConfirmPinTitle => _registerConfirmPinTitle.tr();

  static const String _registerConfirmPinSubtitle = 'register_confirm_pin_subtitle';
  static String get registerConfirmPinSubtitle => _registerConfirmPinSubtitle.tr();

  static const String _registerAutoLockTitle = 'register_auto_lock_title';
  static String get registerAutoLockTitle => _registerAutoLockTitle.tr();

  static const String _registerAutoLockDesc = 'register_auto_lock_desc';
  static String get registerAutoLockDesc => _registerAutoLockDesc.tr();

  static const String _registerFinancialDataTitle = 'register_financial_data_title';
  static String get registerFinancialDataTitle => _registerFinancialDataTitle.tr();

  static const String _registerFinancialDataSubtitle = 'register_financial_data_subtitle';
  static String get registerFinancialDataSubtitle => _registerFinancialDataSubtitle.tr();

  static const String _registerMonthlySalaryLabel = 'register_monthly_salary_label';
  static String get registerMonthlySalaryLabel => _registerMonthlySalaryLabel.tr();

  static const String _registerSalaryDateLabel = 'register_salary_date_label';
  static String get registerSalaryDateLabel => _registerSalaryDateLabel.tr();

  static const String _registerDailyExpenseLabel = 'register_daily_expense_label';
  static String get registerDailyExpenseLabel => _registerDailyExpenseLabel.tr();

  static const String _registerHolidayExpenseLabel = 'register_holiday_expense_label';
  static String get registerHolidayExpenseLabel => _registerHolidayExpenseLabel.tr();

  static const String _registerWeekdaysLabel = 'register_weekdays_label';
  static String get registerWeekdaysLabel => _registerWeekdaysLabel.tr();

  static const String _registerWeekdaysHelper = 'register_weekdays_helper';
  static String get registerWeekdaysHelper => _registerWeekdaysHelper.tr();

  static const String _registerNoticeTitle = 'register_notice_title';
  static String get registerNoticeTitle => _registerNoticeTitle.tr();

  static const String _registerNoticeDesc = 'register_notice_desc';
  static String get registerNoticeDesc => _registerNoticeDesc.tr();

  static const String _registerSaturday = 'register_saturday';
  static String get registerSaturday => _registerSaturday.tr();

  static const String _registerFriday = 'register_friday';
  static String get registerFriday => _registerFriday.tr();

  static const String _registerThursday = 'register_thursday';
  static String get registerThursday => _registerThursday.tr();

  static const String _registerWednesday = 'register_wednesday';
  static String get registerWednesday => _registerWednesday.tr();

  static const String _registerTuesday = 'register_tuesday';
  static String get registerTuesday => _registerTuesday.tr();

  static const String _registerMonday = 'register_monday';
  static String get registerMonday => _registerMonday.tr();

  static const String _registerSunday = 'register_sunday';
  static String get registerSunday => _registerSunday.tr();

  static const String _loginScreenTitle = 'login_screen_title';
  static String get loginScreenTitle => _loginScreenTitle.tr();

  static const String _loginNoAccountRegister = 'login_no_account_register';
  static String get loginNoAccountRegister => _loginNoAccountRegister.tr();

  static const String _loginForgotPasswordQuestion = 'login_forgot_password_question';
  static String get loginForgotPasswordQuestion => _loginForgotPasswordQuestion.tr();

  static const String _loginContactAdministration = 'login_contact_administration';
  static String get loginContactAdministration => _loginContactAdministration.tr();

  static const String _loginPasswordHint = 'login_password_hint';
  static String get loginPasswordHint => _loginPasswordHint.tr();

  static const String _homeTabWelcomeUser = 'home_tab_welcome_user';
  static String homeTabWelcomeUser({required String name}) => _homeTabWelcomeUser.tr(namedArgs: {'name': name});

  static const String _homeTabDemoUserName = 'home_tab_demo_user_name';
  static String get homeTabDemoUserName => _homeTabDemoUserName.tr();

  static const String _homeTabSmartExpenseTagline = 'home_tab_smart_expense_tagline';
  static String get homeTabSmartExpenseTagline => _homeTabSmartExpenseTagline.tr();

  static const String _homeTabMonthlySalaryLabel = 'home_tab_monthly_salary_label';
  static String get homeTabMonthlySalaryLabel => _homeTabMonthlySalaryLabel.tr();

  static const String _homeTabSaudiRiyalLabel = 'home_tab_saudi_riyal_label';
  static String get homeTabSaudiRiyalLabel => _homeTabSaudiRiyalLabel.tr();

  static const String _homeTabMonthlyExpenseLabel = 'home_tab_monthly_expense_label';
  static String get homeTabMonthlyExpenseLabel => _homeTabMonthlyExpenseLabel.tr();

  static const String _homeTabShortcutExpense = 'home_tab_shortcut_expense';
  static String get homeTabShortcutExpense => _homeTabShortcutExpense.tr();

  static const String _homeTabShortcutWarranty = 'home_tab_shortcut_warranty';
  static String get homeTabShortcutWarranty => _homeTabShortcutWarranty.tr();

  static const String _homeTabShortcutFuturePurchases = 'home_tab_shortcut_future_purchases';
  static String get homeTabShortcutFuturePurchases => _homeTabShortcutFuturePurchases.tr();

  static const String _homeTabTodayExpense = 'home_tab_today_expense';
  static String get homeTabTodayExpense => _homeTabTodayExpense.tr();

  static const String _homeTabPurchases = 'home_tab_purchases';
  static String get homeTabPurchases => _homeTabPurchases.tr();

  static const String _homeTabBillsObligations = 'home_tab_bills_obligations';
  static String get homeTabBillsObligations => _homeTabBillsObligations.tr();

  static const String _homeTabCurrencyRiyal = 'home_tab_currency_riyal';
  static String get homeTabCurrencyRiyal => _homeTabCurrencyRiyal.tr();

  static const String _homeTabCommitmentIndicators = 'home_tab_commitment_indicators';
  static String get homeTabCommitmentIndicators => _homeTabCommitmentIndicators.tr();

  static const String _homeTabCommitmentDaily = 'home_tab_commitment_daily';
  static String get homeTabCommitmentDaily => _homeTabCommitmentDaily.tr();

  static const String _homeTabCommitmentWeekly = 'home_tab_commitment_weekly';
  static String get homeTabCommitmentWeekly => _homeTabCommitmentWeekly.tr();

  static const String _homeTabCommitmentMonthly = 'home_tab_commitment_monthly';
  static String get homeTabCommitmentMonthly => _homeTabCommitmentMonthly.tr();

  static const String _homeTabSavingsTitle = 'home_tab_savings_title';
  static String get homeTabSavingsTitle => _homeTabSavingsTitle.tr();

  static const String _homeTabSavingsToday = 'home_tab_savings_today';
  static String get homeTabSavingsToday => _homeTabSavingsToday.tr();

  static const String _homeTabSavingsWeek = 'home_tab_savings_week';
  static String get homeTabSavingsWeek => _homeTabSavingsWeek.tr();

  static const String _homeTabSavingsMonth = 'home_tab_savings_month';
  static String get homeTabSavingsMonth => _homeTabSavingsMonth.tr();

  static const String _billsOperationsTitle = 'bills_operations_title';
  static String get billsOperationsTitle => _billsOperationsTitle.tr();

  static const String _billsNavOperations = 'bills_nav_operations';
  static String get billsNavOperations => _billsNavOperations.tr();

  static const String _billsNavReports = 'bills_nav_reports';
  static String get billsNavReports => _billsNavReports.tr();

  static const String _billsNavSettings = 'bills_nav_settings';
  static String get billsNavSettings => _billsNavSettings.tr();

  static const String _billsEmptyTitle = 'bills_empty_title';
  static String get billsEmptyTitle => _billsEmptyTitle.tr();

  static const String _billsEmptyDesc = 'bills_empty_desc';
  static String get billsEmptyDesc => _billsEmptyDesc.tr();

  static const String _billsAddBill = 'bills_add_bill';
  static String get billsAddBill => _billsAddBill.tr();

  static const String _billsAddNewBill = 'bills_add_new_bill';
  static String get billsAddNewBill => _billsAddNewBill.tr();

  static const String _billsSearchHint = 'bills_search_hint';
  static String get billsSearchHint => _billsSearchHint.tr();

  static const String _billsSheetAddTitle = 'bills_sheet_add_title';
  static String get billsSheetAddTitle => _billsSheetAddTitle.tr();

  static const String _billsSheetEditTitle = 'bills_sheet_edit_title';
  static String get billsSheetEditTitle => _billsSheetEditTitle.tr();

  static const String _billsFieldInvoice = 'bills_field_invoice';
  static String get billsFieldInvoice => _billsFieldInvoice.tr();

  static const String _billsTapToAddImage = 'bills_tap_to_add_image';
  static String get billsTapToAddImage => _billsTapToAddImage.tr();

  static const String _billsUploadFormats = 'bills_upload_formats';
  static String get billsUploadFormats => _billsUploadFormats.tr();

  static const String _billsFieldAmount = 'bills_field_amount';
  static String get billsFieldAmount => _billsFieldAmount.tr();

  static const String _billsHintAmount = 'bills_hint_amount';
  static String get billsHintAmount => _billsHintAmount.tr();

  static const String _billsFieldItemType = 'bills_field_item_type';
  static String get billsFieldItemType => _billsFieldItemType.tr();

  static const String _billsHintItemType = 'bills_hint_item_type';
  static String get billsHintItemType => _billsHintItemType.tr();

  static const String _billsFieldPurchaseDate = 'bills_field_purchase_date';
  static String get billsFieldPurchaseDate => _billsFieldPurchaseDate.tr();

  static const String _billsHintDate = 'bills_hint_date';
  static String get billsHintDate => _billsHintDate.tr();

  static const String _billsFieldWarrantyEnd = 'bills_field_warranty_end';
  static String get billsFieldWarrantyEnd => _billsFieldWarrantyEnd.tr();

  static const String _billsSaveBill = 'bills_save_bill';
  static String get billsSaveBill => _billsSaveBill.tr();

  static const String _billsSaveEdit = 'bills_save_edit';
  static String get billsSaveEdit => _billsSaveEdit.tr();

  static const String _billsSavedSuccess = 'bills_saved_success';
  static String get billsSavedSuccess => _billsSavedSuccess.tr();

  static const String _billsPurchaseDateLabel = 'bills_purchase_date_label';
  static String billsPurchaseDateLabel({required String date}) => _billsPurchaseDateLabel.tr(namedArgs: {'date': date});

  static const String _billsWarrantyEndLabel = 'bills_warranty_end_label';
  static String billsWarrantyEndLabel({required String date}) => _billsWarrantyEndLabel.tr(namedArgs: {'date': date});

  static const String _billsAttachmentLabel = 'bills_attachment_label';
  static String billsAttachmentLabel({required String name}) => _billsAttachmentLabel.tr(namedArgs: {'name': name});

  static const String _billsDeleteSemantics = 'bills_delete_semantics';
  static String get billsDeleteSemantics => _billsDeleteSemantics.tr();

  static const String _billsEditSemantics = 'bills_edit_semantics';
  static String get billsEditSemantics => _billsEditSemantics.tr();

  static const String _reportsTitle = 'reports_title';
  static String get reportsTitle => _reportsTitle.tr();

  static const String _reportsTimePeriod = 'reports_time_period';
  static String get reportsTimePeriod => _reportsTimePeriod.tr();

  static const String _reportsPeriodDaily = 'reports_period_daily';
  static String get reportsPeriodDaily => _reportsPeriodDaily.tr();

  static const String _reportsPeriodWeekly = 'reports_period_weekly';
  static String get reportsPeriodWeekly => _reportsPeriodWeekly.tr();

  static const String _reportsPeriodMonthly = 'reports_period_monthly';
  static String get reportsPeriodMonthly => _reportsPeriodMonthly.tr();

  static const String _reportsSummaryTitle = 'reports_summary_title';
  static String get reportsSummaryTitle => _reportsSummaryTitle.tr();

  static const String _reportsTotalSpending = 'reports_total_spending';
  static String get reportsTotalSpending => _reportsTotalSpending.tr();

  static const String _reportsGoalDefined = 'reports_goal_defined';
  static String get reportsGoalDefined => _reportsGoalDefined.tr();

  static const String _reportsBudgetAdherence = 'reports_budget_adherence';
  static String get reportsBudgetAdherence => _reportsBudgetAdherence.tr();

  static const String _reportsDailyAverageExpense = 'reports_daily_average_expense';
  static String get reportsDailyAverageExpense => _reportsDailyAverageExpense.tr();

  static const String _reportsSavingsTitle = 'reports_savings_title';
  static String get reportsSavingsTitle => _reportsSavingsTitle.tr();

  static const String _reportsSavingsDaily = 'reports_savings_daily';
  static String get reportsSavingsDaily => _reportsSavingsDaily.tr();

  static const String _reportsSavingsWeekly = 'reports_savings_weekly';
  static String get reportsSavingsWeekly => _reportsSavingsWeekly.tr();

  static const String _reportsSavingsMonthly = 'reports_savings_monthly';
  static String get reportsSavingsMonthly => _reportsSavingsMonthly.tr();

  static const String _reportsChartsTitle = 'reports_charts_title';
  static String get reportsChartsTitle => _reportsChartsTitle.tr();

  static const String _reportsChartByDays = 'reports_chart_by_days';
  static String get reportsChartByDays => _reportsChartByDays.tr();

  static const String _reportsChartByCategory = 'reports_chart_by_category';
  static String get reportsChartByCategory => _reportsChartByCategory.tr();

  static const String _reportsChartBarSemantics = 'reports_chart_bar_semantics';
  static String get reportsChartBarSemantics => _reportsChartBarSemantics.tr();

  static const String _reportsChartPieSemantics = 'reports_chart_pie_semantics';
  static String get reportsChartPieSemantics => _reportsChartPieSemantics.tr();

  static const String _reportsFixedExpensesTitle = 'reports_fixed_expenses_title';
  static String get reportsFixedExpensesTitle => _reportsFixedExpensesTitle.tr();

  static const String _reportsDateFrom = 'reports_date_from';
  static String get reportsDateFrom => _reportsDateFrom.tr();

  static const String _reportsDateTo = 'reports_date_to';
  static String get reportsDateTo => _reportsDateTo.tr();

  static const String _reportsDateHint = 'reports_date_hint';
  static String get reportsDateHint => _reportsDateHint.tr();

  static const String _reportsPeriodCompareTitle = 'reports_period_compare_title';
  static String get reportsPeriodCompareTitle => _reportsPeriodCompareTitle.tr();

  static const String _reportsThisMonth = 'reports_this_month';
  static String get reportsThisMonth => _reportsThisMonth.tr();

  static const String _reportsLastMonth = 'reports_last_month';
  static String get reportsLastMonth => _reportsLastMonth.tr();

  static const String _reportsDailyAvgLabel = 'reports_daily_avg_label';
  static String get reportsDailyAvgLabel => _reportsDailyAvgLabel.tr();

  static const String _reportsExportTitle = 'reports_export_title';
  static String get reportsExportTitle => _reportsExportTitle.tr();

  static const String _reportsExportPdf = 'reports_export_pdf';
  static String get reportsExportPdf => _reportsExportPdf.tr();

  static const String _reportsExportExcel = 'reports_export_excel';
  static String get reportsExportExcel => _reportsExportExcel.tr();

  static const String _reportsExportStarted = 'reports_export_started';
  static String get reportsExportStarted => _reportsExportStarted.tr();

  static const String _reportsMonthDetailTitle = 'reports_month_detail_title';
  static String reportsMonthDetailTitle({required String monthName}) => _reportsMonthDetailTitle.tr(namedArgs: {'monthName': monthName});

  static const String _reportsCategoryRent = 'reports_category_rent';
  static String get reportsCategoryRent => _reportsCategoryRent.tr();

  static const String _reportsPieFood = 'reports_pie_food';
  static String get reportsPieFood => _reportsPieFood.tr();

  static const String _reportsPieTransport = 'reports_pie_transport';
  static String get reportsPieTransport => _reportsPieTransport.tr();

  static const String _reportsPieUtilities = 'reports_pie_utilities';
  static String get reportsPieUtilities => _reportsPieUtilities.tr();

  static const String _reportsPieHealth = 'reports_pie_health';
  static String get reportsPieHealth => _reportsPieHealth.tr();

  static const String _reportsPieOther = 'reports_pie_other';
  static String get reportsPieOther => _reportsPieOther.tr();

  static const String _subscriptionsMenu = 'subscriptions_menu';
  static String get subscriptionsMenu => _subscriptionsMenu.tr();

  static const String _subscriptionsScreenTitle = 'subscriptions_screen_title';
  static String get subscriptionsScreenTitle => _subscriptionsScreenTitle.tr();

  static const String _subscriptionsTrialTitle = 'subscriptions_trial_title';
  static String get subscriptionsTrialTitle => _subscriptionsTrialTitle.tr();

  static const String _subscriptionsTrialRemaining = 'subscriptions_trial_remaining';
  static String subscriptionsTrialRemaining({required String days}) => _subscriptionsTrialRemaining.tr(namedArgs: {'days': days});

  static const String _subscriptionsTrialDescription = 'subscriptions_trial_description';
  static String get subscriptionsTrialDescription => _subscriptionsTrialDescription.tr();

  static const String _subscriptionsChoosePlan = 'subscriptions_choose_plan';
  static String get subscriptionsChoosePlan => _subscriptionsChoosePlan.tr();

  static const String _subscriptionsPlanMonthly = 'subscriptions_plan_monthly';
  static String get subscriptionsPlanMonthly => _subscriptionsPlanMonthly.tr();

  static const String _subscriptionsPlanYearly = 'subscriptions_plan_yearly';
  static String get subscriptionsPlanYearly => _subscriptionsPlanYearly.tr();

  static const String _subscriptionsPriceLabel = 'subscriptions_price_label';
  static String get subscriptionsPriceLabel => _subscriptionsPriceLabel.tr();

  static const String _subscriptionsPricePeriodMonthly = 'subscriptions_price_period_monthly';
  static String get subscriptionsPricePeriodMonthly => _subscriptionsPricePeriodMonthly.tr();

  static const String _subscriptionsPricePeriodYearly = 'subscriptions_price_period_yearly';
  static String get subscriptionsPricePeriodYearly => _subscriptionsPricePeriodYearly.tr();

  static const String _subscriptionsFeatureUnlimitedExpenses = 'subscriptions_feature_unlimited_expenses';
  static String get subscriptionsFeatureUnlimitedExpenses => _subscriptionsFeatureUnlimitedExpenses.tr();

  static const String _subscriptionsFeatureAdvancedReports = 'subscriptions_feature_advanced_reports';
  static String get subscriptionsFeatureAdvancedReports => _subscriptionsFeatureAdvancedReports.tr();

  static const String _subscriptionsFeatureInvoicesWarranties = 'subscriptions_feature_invoices_warranties';
  static String get subscriptionsFeatureInvoicesWarranties => _subscriptionsFeatureInvoicesWarranties.tr();

  static const String _subscriptionsFeatureSmartNotifications = 'subscriptions_feature_smart_notifications';
  static String get subscriptionsFeatureSmartNotifications => _subscriptionsFeatureSmartNotifications.tr();

  static const String _subscriptionsFeatureAutoBackup = 'subscriptions_feature_auto_backup';
  static String get subscriptionsFeatureAutoBackup => _subscriptionsFeatureAutoBackup.tr();

  static const String _subscriptionsFeatureSupport24 = 'subscriptions_feature_support_24';
  static String get subscriptionsFeatureSupport24 => _subscriptionsFeatureSupport24.tr();

  static const String _subscriptionsDiscountLabel = 'subscriptions_discount_label';
  static String get subscriptionsDiscountLabel => _subscriptionsDiscountLabel.tr();

  static const String _subscriptionsDiscountHint = 'subscriptions_discount_hint';
  static String get subscriptionsDiscountHint => _subscriptionsDiscountHint.tr();

  static const String _subscriptionsDiscountApply = 'subscriptions_discount_apply';
  static String get subscriptionsDiscountApply => _subscriptionsDiscountApply.tr();

  static const String _subscriptionsDiscountApplied = 'subscriptions_discount_applied';
  static String get subscriptionsDiscountApplied => _subscriptionsDiscountApplied.tr();

  static const String _subscriptionsPaySubscribe = 'subscriptions_pay_subscribe';
  static String get subscriptionsPaySubscribe => _subscriptionsPaySubscribe.tr();

  static const String _subscriptionsImportantNoteTitle = 'subscriptions_important_note_title';
  static String get subscriptionsImportantNoteTitle => _subscriptionsImportantNoteTitle.tr();

  static const String _subscriptionsImportantNoteBody = 'subscriptions_important_note_body';
  static String get subscriptionsImportantNoteBody => _subscriptionsImportantNoteBody.tr();

  static const String _subscriptionsPaymentMethodTitle = 'subscriptions_payment_method_title';
  static String get subscriptionsPaymentMethodTitle => _subscriptionsPaymentMethodTitle.tr();

  static const String _subscriptionsPaymentElectronic = 'subscriptions_payment_electronic';
  static String get subscriptionsPaymentElectronic => _subscriptionsPaymentElectronic.tr();

  static const String _subscriptionsConfirm = 'subscriptions_confirm';
  static String get subscriptionsConfirm => _subscriptionsConfirm.tr();

  static const String _subscriptionsPurchaseSuccess = 'subscriptions_purchase_success';
  static String get subscriptionsPurchaseSuccess => _subscriptionsPurchaseSuccess.tr();

}
