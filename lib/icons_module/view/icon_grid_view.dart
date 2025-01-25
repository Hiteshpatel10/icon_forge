import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:forge_icons/icons_module/cubit/icons_search_cubit.dart';

class IconGridView extends StatelessWidget {
  const IconGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IconsSearchCubit, IconsSearchState>(
      builder: (context, state) {
        if (state is IconsSearchSuccess) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: state.icons.result?.length ?? 0,
              (context, index) {
                final icon = state.icons.result?[index];


                return SvgPicture.network(
                  icon?.path ?? '',
                  width: 44,
                  height: 44,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.cancel);
                  },
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: getChildCountBasedOnSize(context),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
          );
        }
        if (state is IconsSearchError) {
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("Error"),
            ),
          );
        }
        if (state is IconsSearchLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  int getChildCountBasedOnSize(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    const double childSize = 44; // Width of each child
    const double spacing = 12; // Add some spacing (optional)
    return width ~/ (childSize + spacing); // Calculate the number of children
  }
}
