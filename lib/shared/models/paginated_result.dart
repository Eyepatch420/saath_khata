class PaginatedMeta {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  const PaginatedMeta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginatedMeta.fromJson(Map<String, dynamic> json) => PaginatedMeta(
        page: json['page'] as int,
        limit: json['limit'] as int,
        total: json['total'] as int,
        totalPages: json['totalPages'] as int,
      );

  bool get hasNextPage => page < totalPages;
}

class PaginatedResult<T> {
  final List<T> items;
  final PaginatedMeta meta;

  const PaginatedResult({required this.items, required this.meta});
}
