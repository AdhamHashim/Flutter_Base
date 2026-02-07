class ApiConstants {
  // ---------------------- Settings -----------------------------------
  static const String intro = 'get-intros';
  static const String countries = 'countries';
  static const String uploadFiles = 'upload-files';
  // ---------------------- Auth -----------------------------------
  static const String login = 'user/auth/login';
  static const String register = 'user/auth/register';
  static const String cities = 'cities-by-country/';
  static const String registerContent = 'user/get-register-data';
  static const String verifyAccount = 'user/auth/verify-account';
  static const String verifyAccountResendCode =
      'user/auth/verify-account-resend-code';
  static const String forgetSendCode = 'user/auth/forget-password/send-code';
  static const String forgetReSendCode =
      'user/auth/forget-password/resend-code';
  static const String forgetCheckCode = 'user/auth/forget-password/verify-code';
  static const String resetPassword =
      'user/auth/forget-password/reset-password';

  // ---------------------- Home -----------------------------------
  static const String departments = 'user/home/departments';
  static const String slides = 'user/home/slides';
  static const String homeVideos = 'user/home/videos';
  static const String homeArticles = 'user/home/articles';
  static const String products = 'user/products';
  static const String videos = 'user/videos';
  static const String articles = 'user/articles';
  static const String articleDetails = 'user/articles/';

  // ---------------------- Notifications -----------------------------------
  static const String notifications = 'user/notifications';
  static const String unReadNotifications = 'user/notifications/count-unread';
  static const String deleteNotification = 'user/notifications/delete/';
  static const String deleteAllNotifications = 'user/notifications/delete-all';

  // ---------------------- MyBallon -----------------------------------
  static const String scanQrCode = 'user/balloon/scan-qr-code/';
  static const String registerBallon = 'user/balloon/register';
  static const String replaceBallon = 'user/balloon/replace';
  static const String updateBallon = 'user/balloon/update';

  // ---------------------- Products(Ballon) -----------------------------------
  static const String productDetails = 'user/products/';
  static const String productReview = 'user/products/';
  static const String reviews = '/reviews';
  static const String productDoctors = 'user/products/doctors';
  static const String productDistributors = 'user/products/distributors';
  static const String distributorsSendConstactRequest =
      'user/products/distributors/send-contact-request';

  // ---------------------- Orders -----------------------------------
  static const String myOrders = 'user/my-orders/';
  static const String orderDetails = 'user/my-orders/details/';
  static const String cancelOrder = 'user/my-orders/cancel/';
  static const String orderCopoun = 'user/my-orders/coupon-inquiry/';
  static const String payOrder = 'user/my-orders/pay/';
  static const String orderAddNote = 'user/my-orders/create-note';
  static const String rateOrder = 'user/my-orders/give-rate/';
  // ---------------------- Appointment -----------------------------------
  static const String appointmentsCoupon = 'user/appointments/coupon-inquery';
  static const String appointmentsPackage =
      'user/appointments/available-subscriptions';
  static const String appointmentsCreation = 'user/appointments/create';

  // ---------------------- Providers -----------------------------------
  static const String providers = 'user/providers';
  static const String providerDetails = 'user/providers/';
  static const String allVideo = '/videos';
  static const String allArticle = '/articles';
  static const String allReviews = '/reviews';
  static const String allSessions = '/sessions';
  static const String availableTimes = '/sessions/';

  // ---------------------- Packages && Subscriptions -----------------------------------
  static const String packages = 'user/packages';
  static const String subscribePackages = 'user/packages/subscribe/';
  static const String mySubscriptions = 'user/my-subscriptions';
  static const String subscriptionsDoctors = 'user/my-subscriptions/doctors/';
  static const String mypackages = 'user/my-packages';
  static const String packaegDoctors =
      'user/my-packages/subscribed-category-doctor-packages/';
  static const String getAdditionalSessionFormPackage =
      'user/my-packages/getAdditionalSessionFormData/';
  static const String packagesCoupon = 'user/my-packages/coupon-inquiry/';
  static const String payAdditionalSession =
      'user/my-packages/pay-additional-session/';

  // ---------------------- Challenges -----------------------------------
  static const String challeneges = 'user/challeneges';
  static const String joinedChalleneges = 'user/challeneges/joined';
  static const String joinChallenge = 'user/challeneges/join-challenege/';
  static const String challenegeDetails = 'user/challeneges/';

  // ---------------------- Notes -----------------------------------
  static const String notes = 'user/notes';
  static const String noteDetails = 'user/notes/';
  static const String addNote = 'user/notes';
  static const String updateNote = 'user/notes/';
  static const String deleteNote = 'user/notes/';

  // ---------------------- Weight Loss -----------------------------------
  static const String weightLoss = 'user/weight-logs';
  static const String weightLossDeatils = 'user/weight-logs/';
  static const String show = '/show';
  static const String addWeight = 'user/weight-logs/add';

  // ---------------------- Additional Info -----------------------------------
  static const String reports = 'user/reports';
  static const String reportDetails = 'user/reports/';
  static const String personalInformationIntro =
      'user/personal-information/get-intros-data';
  static const String personalInformationFormData =
      'user/personal-information/get-form-data';
  static const String createPersonalInfo = 'user/personal-information/store';
  static const String fetchPersonalInfo = 'user/personal-information';
  static const String updatePersonalInfo = 'user/personal-information/update';
  // ---> Validate Addition Info
  static const String validateFirstStep =
      'user/personal-information/validate-first-step';
  static const String validateSecondStep =
      'user/personal-information/validate-second-step';
  static const String validateThirdStep =
      'user/personal-information/validate-third-step';
  static const String validateForthStep =
      'user/personal-information/validate-fourth-step';
  static const String validateFifthStep =
      'user/personal-information/validate-fifth-step';
  static const String validateSexthStep =
      'user/personal-information/validate-sixth-step';
  static const String validateSeventhStep =
      'user/personal-information/validate-seventh-step';

  // ---------------------- Settings -----------------------------------
  static const String switchNotification = 'user/notifications/change-status';
  static const String updateProfile = 'user/profile/update';
  static const String changePassword = 'user/profile/update-password';
  static const String changeLang = 'user/change-lang';
  static const String deleteAccount = 'user/delete-account';
  static const String updateCountry = 'user/profile/change-currency-country';
  // ---------------------- Change_Email -----------------------------------
  static const String changeEmailCheckPassword =
      'user/profile/change-email-check-password';
  static const String changeEmailSendCode =
      'user/profile/change-email-send-code';
  static const String changeEmailReSendCode =
      'user/profile/change-email-resend-code';
  static const String changeEmailVerifyCode =
      'user/profile/change-email-verify-code';

  // ---------------------- More -----------------------------------
  static const String faqs = 'get-faqs';
  static const String about = 'about';
  static const String terms = 'terms';
  static const String privacy = 'privacy';
  static const String contactUs = 'send-help-message';
  static const String complain = 'user/complaints/get-complaint-data';
  static const String addComplain = 'user/complaints/send';
  static const String complainDetails = 'user/complaints/';
  static const String facilities = 'user/facilities';
  static const String privilages = 'user/privilages';
  static const String coupons = 'user/my-coupons';
  static const String logOut = 'user/sign-out';
  static const String wallet = 'user/wallet';
  static const String chargeWallet = 'user/wallet/charge';
  static const String myPoints = 'user/rewards';
  static const String convertPoints = 'user/rewards/convert-points-to-wallet';

  // ---------------------- Chats -----------------------------------
  static const String createTechnicalSupportChat =
      'chat/technical-support-room';

  static const String getMessages = 'chat/get-room-messages/';
  static const String getCompletRooms = 'user/chat/get-rooms/completed';
  static const String getCurrentRooms = 'user/chat/get-rooms/current';
  static const String uploadRoomFile = 'chat/upload-room-file/';
  static const String unreadMessagesCount = 'chat/get-room-unseen-messages/';
}
