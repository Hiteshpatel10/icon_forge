import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core_utility/core_network.dart';
import 'package:forge_icons/icons_module/model/icon_filter_model.dart';
import 'package:forge_icons/util/api_endpoints.dart';
import 'package:meta/meta.dart';

part 'icon_filter_state.dart';

class IconFilterCubit extends Cubit<IconFilterState> {
  IconFilterCubit() : super(IconFilterInitial()) {
    _filterController = StreamController<Map<String, List<String>>>.broadcast();
    filter = _filterController.stream;
  }

  late final StreamController<Map<String, List<String>>> _filterController;
  late final Stream<Map<String, List<String>>> filter;

  final Map<String, List<String>> _currentFilter = {};

  getFilter({String? search}) async {
    _filterController.add(Map.from(_currentFilter));

    try {
      emit(IconFilterLoading());

      final response = await getRequest(
        apiEndPoint: ApiEndpoints.iconsFilter,
        requestFrom: RequestFrom.branchLocator,
      );

      final iconsModel = IconFilterModel.fromJson(response);

      emit(IconFilterSuccess(iconFilter: iconsModel));
    } catch (e) {
      print(e);
      emit(IconFilterError());
    }
  }

  void updateFilter(String key, String value) {
    // Update the current filter map
    if (!_currentFilter.containsKey(key)) {
      _currentFilter[key] = [value];
    } else {
      if (_currentFilter[key]!.contains(value)) {
        _currentFilter[key]!.remove(value);
        if (_currentFilter[key]!.isEmpty) {
          _currentFilter.remove(key);
        }
      } else {
        _currentFilter[key]!.add(value);
      }
    }

    _filterController.add(Map.from(_currentFilter));
  }

  bool isValuePresent(String key, String value) {
    return _currentFilter.containsKey(key) && _currentFilter[key]!.contains(value);
  }

  @override
  Future<void> close() {
    _filterController.close();
    return super.close();
  }
}
