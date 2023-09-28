part of 'home_page_bloc.dart';

class HomePageEvents {}

class SearchHomePageDataEvent extends HomePageEvents {
  final String query;
  SearchHomePageDataEvent({required this.query});
}
