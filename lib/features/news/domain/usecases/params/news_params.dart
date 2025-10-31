class NewsParam {
  String query;
  String fromDate;
  String toDate;
  String sortBy;
  int? page;
  int? pageSize;

  NewsParam(this.query, this.fromDate, this.toDate, this.sortBy, this.page, this.pageSize);
}
