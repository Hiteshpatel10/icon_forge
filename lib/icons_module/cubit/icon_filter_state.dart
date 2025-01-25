part of 'icon_filter_cubit.dart';

@immutable
sealed class IconFilterState {}

final class IconFilterInitial extends IconFilterState {}

final class IconFilterLoading extends IconFilterState {}

final class IconFilterSuccess extends IconFilterState {
  IconFilterSuccess({required this.iconFilter});

  final IconFilterModel iconFilter;
}

final class IconFilterError extends IconFilterState {}
