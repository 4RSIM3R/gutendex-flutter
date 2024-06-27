import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:velocity_x/velocity_x.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.model});

  final BookModel model;

  static const String path = "/book-detail";

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Detail Books'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart_fill),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: CachedNetworkImageProvider(widget.model.formats?.imageJpeg ?? ''),
              ),
            ),
          ),
          8.verticalSpace,
          Text(widget.model.title ?? '-'),
          4.verticalSpace,
          ...(widget.model.authors ?? []).map(
            (e) => Text(e.name ?? '-').pOnly(bottom: 2),
          )
        ],
      ).p16(),
    );
  }
}
