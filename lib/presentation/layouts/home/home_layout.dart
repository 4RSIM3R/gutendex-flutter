import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:next_starter/common/extensions/extensions.dart';
import 'package:next_starter/common/utils/debouncer.dart';
import 'package:next_starter/injection.dart';
import 'package:next_starter/presentation/components/card/book_card.dart';
import 'package:next_starter/presentation/components/components.dart';
import 'package:next_starter/presentation/layouts/home/bloc/home_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final _form = fb.group({'search': []});
  final _controller = ScrollController();
  final bloc = locator<HomeBloc>();
  final debouncer = Debouncer(milliseconds: 300);

  bool get _isBottom {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _form.valueChanges.listen((event) {
      debouncer.run(() => bloc.add(HomeSearchEvent(search: event?['search'].toString())));
    });
    bloc.add(const HomeFetchEvent());
  }

  void _onScroll() {
    if (_isBottom) bloc.add(const HomeFetchEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: ReactiveFormBuilder(
            form: () => _form,
            builder: (context, form, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return const TextInput(
                        formControlName: 'search',
                        hint: 'Search Book...',
                      );
                    },
                  ),
                  8.verticalSpace,
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.status == HomeStatus.initial) {
                        return const Center(child: CircularProgressIndicator.adaptive());
                      } else if (state.status == HomeStatus.failure) {
                        return Center(child: Text(state.message ?? '-'));
                      } else {
                        return Column(
                          children: [
                            Expanded(
                              child: ListView(
                                controller: _controller,
                                children: [
                                  ...(state.books).map((e) => BookCard(model: e)),
                                  (state.hasReachedMax
                                      ? const SizedBox.shrink()
                                      : const Center(child: CircularProgressIndicator.adaptive()))
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    },
                  ).expand(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
