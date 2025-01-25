import 'package:core_utility/core_theme.dart';
import 'package:core_utility/core_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge_icons/icons_module/cubit/icon_filter_cubit.dart';
import 'package:forge_icons/icons_module/cubit/icons_search_cubit.dart';
import 'package:forge_icons/icons_module/view/icons_view.dart';
import 'package:forge_icons/util/api_endpoints.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  await initGlobalKeys(navigatorKey, scaffoldMessengerKey, baseUrl: ApiEndpoints.base);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IconsSearchCubit>(create: (context) => IconsSearchCubit()),
        BlocProvider<IconFilterCubit>(create: (context) => IconFilterCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: CoreColors.desertStorm ,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        home: const IconsView(),
      ),
    );
  }
}



