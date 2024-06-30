import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_starter/common/extensions/context_extension.dart';
import 'package:next_starter/data/models/book/book_model.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/button/primary_button.dart';
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
            context.showLoadingIndicator();
          }

          if (state is BookDetailFailureState) {
            context.hideLoading();
            context.showSnackbar(message: state.message);
          }

          if (state is BookDetailSuccessState) {
            context.hideLoading();
            context.route.pop();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text('Detail Books'),
            actions: [
              IconButton(
                onPressed: () {
                  bloc.add(widget.model);
                },
                icon: const Icon(CupertinoIcons.heart, color: Colors.red),
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
                      ),
                      8.verticalSpace,
                      Text(
                        'Download Count',
                        style: CustomTextTheme.paragraph1.copyWith(fontWeight: FontWeight.w600),
                      ),
                      4.verticalSpace,
                      Text('${widget.model.downloadCount}')
                    ],
                  ).expand()
                ],
              ),
              16.verticalSpace,
              Text(
                'Subject',
                style: CustomTextTheme.paragraph1.copyWith(fontWeight: FontWeight.w600),
              ),
              4.verticalSpace,
              ...(widget.model.subjects ?? []).map(
                (e) => Text(e).pOnly(bottom: 2),
              ),
            ],
          ).p16(),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              title: 'Read Now',
              onTap: () {},
            ),
          ),
        ),
      ),
    );
  }
}
