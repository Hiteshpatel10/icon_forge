import 'package:core_utility/core_theme.dart';
import 'package:core_utility/core_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forge_icons/icons_module/cubit/icon_filter_cubit.dart';
import 'package:forge_icons/icons_module/cubit/icons_search_cubit.dart';
import 'package:forge_icons/icons_module/view/icon_filter_view.dart';
import 'package:forge_icons/icons_module/view/icon_grid_view.dart';

class IconsView extends StatefulWidget {
  const IconsView({super.key});

  @override
  State<IconsView> createState() => _IconsViewState();
}

class _IconsViewState extends State<IconsView> {
  late final TextEditingController _searchEditingController;
  late final CoreDebouncer _coreDebouncer;
  late final IconsSearchCubit _iconSearchCubit;
  late final IconFilterCubit _iconFilterCubit;
  @override
  void initState() {
    _searchEditingController = TextEditingController();
    _coreDebouncer = CoreDebouncer(milliseconds: 400);
    _iconSearchCubit = BlocProvider.of<IconsSearchCubit>(context)..getIcons();
    _iconFilterCubit = BlocProvider.of<IconFilterCubit>(context)..getFilter();
    _iconFilterCubit.filter.listen((event) {
      _iconSearchCubit.getIcons(search: _searchEditingController.text, filter: event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              width: constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth,
              child: Row(
                children: [
                  const SizedBox(
                    width: 200,
                    child: CustomScrollView(
                      slivers: [
                        IconFilterView(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: CustomScrollView(
                      slivers: [
                        PinnedHeaderSliver(
                          child: TextFormField(
                            controller: _searchEditingController,
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            onChanged: (value) {
                              _coreDebouncer.run(() {
                                _iconSearchCubit.getIcons(search: value);
                              });
                            },
                          ),
                        ),
                        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                        const IconGridView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
