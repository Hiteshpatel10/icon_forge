import 'package:flutter/material.dart';
import 'package:core_utility/core_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_icons/icons_module/cubit/icon_filter_cubit.dart';

class IconFilterView extends StatefulWidget {
  const IconFilterView({super.key});

  @override
  State<IconFilterView> createState() => _IconFilterViewState();
}

class _IconFilterViewState extends State<IconFilterView> {
  late final IconFilterCubit _iconFilterCubit;

  @override
  void initState() {
    _iconFilterCubit = BlocProvider.of<IconFilterCubit>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IconFilterCubit, IconFilterState>(
      builder: (context, state) {
        if (state is IconFilterSuccess) {
          return StreamBuilder<Map<String, List<String>>>(
            stream: _iconFilterCubit.filter,
            builder: (context, snapshot) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.iconFilter.result?.length ?? 0,
                      (context, index) {
                    final filter = state.iconFilter.result?[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            filter?.key ?? '',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                            const Divider(),
                            ...List.generate(
                              filter?.value?.length ?? 0,
                                  (innerIndex) {
                                final value = filter?.value?[innerIndex];
                                return GestureDetector(
                                  onTap: () {
                                    _iconFilterCubit.updateFilter(filter?.key ?? '', value ?? '');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      value ?? '-',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: _iconFilterCubit.isValuePresent(
                                            filter?.key ?? '', value ?? '')
                                            ? CoreColors.shareGreen
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        }

        // Show loading indicator if state is not IconFilterSuccess
        return const SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
