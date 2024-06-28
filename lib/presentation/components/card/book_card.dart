import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:next_starter/common/extensions/context_extension.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/presentation/pages/book/detail/book_detail_page.dart';
import 'package:next_starter/presentation/theme/theme.dart';

class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.model});

  final BookModel model;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.route.pushNamed(BookDetailPage.path, extra: model);
      },
      leading: const Icon(CupertinoIcons.book, color: Colors.blue),
      title: Text(
        model.title ?? '-',
        style: CustomTextTheme.paragraph1.copyWith(fontWeight: FontWeight.w600),
        maxLines: 1,
        softWrap: true,
        overflow: TextOverflow.clip,
      ),
      subtitle: (model.authors ?? []).isNotEmpty ? Text((model.authors ?? []).first.name ?? '-') : const Text('-'),
    );
  }
}
