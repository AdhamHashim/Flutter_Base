part of '../imports/view_imports.dart';

/// Set to `false` when wiring real notification APIs again.
const bool kNotificationsUiOnly = true;

@injectable
class NotificationsCubit extends PaginatedCubit<NotificationEntity> {
  static List<NotificationEntity> _mockItems() => [
    NotificationEntity(
      id: 'mock_1',
      type: 'achievement',
      title: LocaleKeys.notificationsSampleHeroTitle,
      body: LocaleKeys.notificationsSampleHeroBody,
      createdAt: LocaleKeys.notificationsRelativeHour,
      read: 0,
      data: const {},
      accent: NotificationAccent.success,
    ),
    NotificationEntity(
      id: 'mock_2',
      type: 'expense_warning',
      title: LocaleKeys.notificationsSampleExpenseTitle,
      body: LocaleKeys.notificationsSampleExpenseBody,
      createdAt: LocaleKeys.notificationsRelativeHour,
      read: 0,
      data: const {},
      accent: NotificationAccent.warning,
    ),
    NotificationEntity(
      id: 'mock_3',
      type: 'savings_goal',
      title: LocaleKeys.notificationsSampleSavingsTitle,
      body: LocaleKeys.notificationsSampleSavingsBody,
      createdAt: LocaleKeys.notificationsRelativeTwoDays,
      read: 1,
      data: const {},
      accent: NotificationAccent.info,
    ),
    NotificationEntity(
      id: 'mock_4',
      type: 'savings_goal',
      title: LocaleKeys.notificationsSampleSavingsTitle,
      body: LocaleKeys.notificationsSampleSavingsBody,
      createdAt: LocaleKeys.notificationsRelativeTwoDays,
      read: 1,
      data: const {},
      accent: NotificationAccent.info,
    ),
  ];

  static PaginatedData<NotificationEntity> _mockPaginated() {
    final items = _mockItems();
    return PaginatedData<NotificationEntity>(
      items: items,
      meta: PaginationMeta(
        totalItems: items.length,
        countItems: items.length,
        perPage: items.length,
        totalPages: 1,
        currentPage: 1,
      ),
    );
  }

  @override
  Future<void> fetchInitialData({String? key}) async {
    if (kNotificationsUiOnly) {
      setLoading();
      await Future<void>.delayed(Duration.zero);
      setSuccess(data: _mockPaginated());
      return;
    }
    await super.fetchInitialData(key: key);
  }

  @override
  Future<void> loadMore() async {
    if (kNotificationsUiOnly) return;
    await super.loadMore();
  }

  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(
    int page, {
    String? key,
  }) async {
    return baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.notifications,
        httpRequestType: HttpRequestType.get,
        queryParameters: ConstantManager.paginateJson(page),
        mapper: (json) => json,
      ),
    );
  }

  @override
  List<NotificationEntity> parseItems(json) =>
      ((json['data'] as List?) ?? [])
          .map((e) => e is Map<String, dynamic>
              ? NotificationEntity.fromJson(e)
              : NotificationEntity.initial())
          .toList();

  @override
  PaginationMeta parsePagination(json) =>
      PaginationMeta.fromJson(json['pagination'] ?? {});

  void clearData() {
    setSuccess(data: PaginatedData.initial());
  }

  void deleteOneNotification(NotificationEntity notification) {
    final updatedItems = List<NotificationEntity>.from(state.data.items)
      ..removeWhere((element) => element.id == notification.id);
    setSuccess(data: state.data.copyWith(items: updatedItems));
  }
}
