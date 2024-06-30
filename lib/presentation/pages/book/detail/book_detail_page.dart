import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_bloc.dart';
import 'package:next_starter/presentation/pages/book/detail/bloc/book_detail_state.dart';
import 'package:next_starter/presentation/theme/theme.dart';
import 'package:velocity_x/velocity_x.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.model});

  final BookModel model;

  static const String path = "/book-detail";

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  final bloc = locator<BookDetailBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
      ],
      child: BlocListener<BookDetailBloc, BookDetailState>(
        listener: (context, state) {
          if (state is BookDetailLoadingState) {
            context.showLoading(msg: "Loading...");
          } else if (state is BookDetailFailureState) {
            context.pop();
            context.showToast(msg: state.message);
          } else {
            context.pop();
            context.pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text('Detail Books'),
            actions: [
              IconButton(
                onPressed: () {
                  bloc.add(widget.model);
                },
                icon: const Icon(CupertinoIcons.heart_fill, color: Colors.red),
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.model.formats?.imageJpeg ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      8.verticalSpace,
                      Text(
                        widget.model.title ?? '-',
                        style: CustomTextTheme.paragraph2.copyWith(fontWeight: FontWeight.w600),
                      ),
                      8.verticalSpace,
                      Text(
                        'Author',
                        style: CustomTextTheme.paragraph1.copyWith(fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      ...(widget.model.authors ?? []).map(
                        (e) => Text(e.name ?? '-').pOnly(bottom: 2),
                      )
                    ],
                  ).expand()
                ],
              ),
            ],
          ).p16(),
        ),
      ),
    );
  }
}
