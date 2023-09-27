part of 'home_page_bloc.dart';

class HomePageEvents {}

class SearchHomePageDataEvent extends HomePageEvents {
  final String query;
  final int limit;
  final int offset;
  SearchHomePageDataEvent({required this.query, this.limit = 10, required this.offset});
}
