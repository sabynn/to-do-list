import 'package:sm_to_do_list/common/utils.dart';
import 'package:sm_to_do_list/presentation/pages/about_me.dart';
import 'package:sm_to_do_list/presentation/pages/add_to_do.dart';
import 'package:sm_to_do_list/presentation/pages/bookmark_page.dart';
import 'package:sm_to_do_list/presentation/pages/finished_task.dart';
import 'package:sm_to_do_list/presentation/pages/main_page.dart';
import 'package:sm_to_do_list/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:sm_to_do_list/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List App',
      home: const SplashPage(),
      navigatorObservers: [routeObserver],
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => MainPage());
          case AboutMe.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => AboutMe());
          case BookMarkPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => BookMarkPage());
          case FinishedPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => FinishedPage());
          case AddToDoPage.ROUTE_NAME:
            return MaterialPageRoute(builder: (_) => AddToDoPage());
          default:
            return MaterialPageRoute(builder: (_) {
              return const Scaffold(
                body: Center(
                  child: Text('Page not found :('),
                ),
              );
            });
        }
      },
    );
  }
}
