import 'package:app_utils/constants.dart';

class NewsParam {
  String query;
  String fromDate;
  String toDate;
  String sortBy;
  int page;
  int pageSize;

  NewsParam(
      {required this.query,
      required this.fromDate,
      required this.toDate,
      required this.sortBy,
      this.page = 0,
      this.pageSize = Constants.LIST_PAGE_SIZE});
}
