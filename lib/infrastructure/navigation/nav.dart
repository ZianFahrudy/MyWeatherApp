// ignore_for_file: strict_raw_type

import 'package:get/get.dart';
import 'package:my_wheater_app/features/wheater/presentation/pages/search_page.dart';
import 'package:my_wheater_app/infrastructure/navigation/routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.search,
      page: () => const SearchPage(),
      transition: Transition.cupertino,
    ),
  ];
}
