enum SortBy {
  newest("newest"),
  oldest("oldest");

  final String apiQuery;
  const SortBy(this.apiQuery);
}
