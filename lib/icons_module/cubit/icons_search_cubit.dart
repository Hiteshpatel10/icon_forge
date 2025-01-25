import 'package:bloc/bloc.dart';
import 'package:core_utility/core_network.dart';
import 'package:forge_icons/icons_module/model/icons_model.dart';
import 'package:forge_icons/util/api_endpoints.dart';
import 'package:meta/meta.dart';

part 'icons_search_state.dart';

class IconsSearchCubit extends Cubit<IconsSearchState> {
  IconsSearchCubit() : super(IconsSearchInitial());

  getIcons({String? search, Map<String, List<String>>? filter}) async {
    try {
      emit(IconsSearchLoading());

      final response = await postRequest(
        apiEndPoint: ApiEndpoints.icons,
        postData: {
          if (search != null && search.isNotEmpty) "search": search,
          ...?filter,
          "limit": 1000,
        },
        requestFrom: RequestFrom.branchLocator,
      );

      final iconsModel = IconsModel.fromJson(response);
      emit(IconsSearchSuccess(icons: iconsModel));
    } catch (e) {
      print(e);
      emit(IconsSearchError());
    }
  }
}
