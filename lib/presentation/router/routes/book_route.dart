import 'package:go_router/go_router.dart';
import 'package:next_starter/presentation/pages/book/detail/book_detail_page.dart';

class BookRoute {
  static final routes = [
    GoRoute(
      path: BookDetailPage.path,
      name: BookDetailPage.path,
      builder: (context, state) => const BookDetailPage(),
    ),
  ];
}