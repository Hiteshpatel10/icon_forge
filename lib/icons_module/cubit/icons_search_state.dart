part of 'icons_search_cubit.dart';

@immutable
sealed class IconsSearchState {}

final class IconsSearchInitial extends IconsSearchState {}

final class IconsSearchLoading extends IconsSearchState {}

final class IconsSearchSuccess extends IconsSearchState {
  IconsSearchSuccess({required this.icons});
  final IconsModel icons;
}

final class IconsSearchError extends IconsSearchState {}
