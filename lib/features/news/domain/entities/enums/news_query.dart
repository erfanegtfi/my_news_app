enum NewsQuery {
  apple("Apple"),
  microsoft("Microsoft"),
  google("Google"),
  tesla("Tesla");

  final String apiQuery;
  const NewsQuery(this.apiQuery);

  factory NewsQuery.fromString(String? item) {
    return NewsQuery.values.firstWhere(
      (element) => (item ?? '').toUpperCase() == element.apiQuery.toUpperCase(),
      orElse: () => apple,
    );
  }
}
