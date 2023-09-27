part of 'home_page_bloc.dart';

class HomePageState {}

class InitialHomePageState extends HomePageState {}

class LoadingHomePageState extends HomePageState {}

class LoadingPaginatedHomePageState extends HomePageState {
  final List<WikiItemModel> pages;
  LoadingPaginatedHomePageState({required this.pages});
}

class LoadedHomePageState extends HomePageState {
  final List<WikiItemModel> pages;
  LoadedHomePageState({required this.pages});
}

class ErrorHomePageState extends HomePageState {
  final String message;
  ErrorHomePageState({required this.message});
}
