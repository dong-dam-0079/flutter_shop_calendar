import 'package:fluro/fluro.dart';

import 'routers/auth_router.dart';
import 'routers/home_router.dart';
import 'ui/page_not_found.dart';

final appRouter = FluroRouter();

Future<void> configureRouters() async {
  // Return to page not found if router navigation error
  appRouter.notFoundHandler = Handler(handlerFunc: (_, __) {
    return const PageNotFound();
  });

  HomeRouter().defineRoutes(appRouter);
  AuthRouter().defineRoutes(appRouter);
}
