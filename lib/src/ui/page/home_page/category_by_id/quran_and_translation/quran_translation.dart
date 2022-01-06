import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/category_cubit.dart';
import 'package:zong_islamic_web_app/src/cubit/cate_cubit/sub_category/quran_translation_cubit/quran_cubit.dart';
import 'package:zong_islamic_web_app/src/model/content_by_category_id.dart';
import 'package:zong_islamic_web_app/src/resource/repository/cate_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/quran_and_translation/para_wise_page.dart';
import 'package:zong_islamic_web_app/src/ui/page/home_page/category_by_id/quran_and_translation/surah_wise_page.dart';
import 'package:zong_islamic_web_app/src/ui/widget/error_text.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_appbar.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

enum TapOption { paraWise, surahWise }

class QuranAndTranslation extends StatefulWidget {
  final String contendId;
  final String number;

  const QuranAndTranslation(this.contendId, this.number, {Key? key})
      : super(key: key);

  @override
  State<QuranAndTranslation> createState() => _QuranAndTranslationState();
}

class _QuranAndTranslationState extends State<QuranAndTranslation> {
  @override
  void initState() {
    BlocProvider.of<CategoryCubit>(context)
        .getCategoryById(widget.contendId, widget.number);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('QuranAndTranslation');
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
              if (state is QuranInitial) {
                return const EmptySizedBox();
              } else if (state is CategoryLoadingState) {
                return const WidgetLoading();
              } else if (state is CategorySuccessState) {
                return _QuranTranslationByCategory(
                    state.category!, widget.number,
                    title: state.category!.title!);
              } else if (state is CategoryErrorState) {
                return const ErrorText();
              } else {
                return const ErrorText();
              }
            }),
          ),
        ],
      ),
    );
  }
}

class _QuranTranslationByCategory extends StatefulWidget {
  final ContentByCateId cateId;
  final String number;
  final String title;

  const _QuranTranslationByCategory(this.cateId, this.number,
      {Key? key, this.title = 'Islam'})
      : super(key: key);

  @override
  State<_QuranTranslationByCategory> createState() =>
      _QuranTranslationByCategoryState();
}

class _QuranTranslationByCategoryState
    extends State<_QuranTranslationByCategory>
    with SingleTickerProviderStateMixin {
  final _sizedBox = const SizedBox(height: 10);
  final quranCubit = QuranCubit(CategoryRepository.getInstance()!);
  late TabController tabController;
  bool absorb = false;

  @override
  void initState() {
    quranCubit.getQuranTranslationById(
        widget.cateId.subMenu![0].catId!, widget.number);
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    quranCubit.close();
    tabController.dispose();
    super.dispose();
  }

  void setAbsorb(bool value) {
    setState(() {
      absorb = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.cateId.subMenu!.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: WidgetAppBar(title: widget.title),
        body: BlocProvider.value(
          value: quranCubit,
          child: Column(
            children: [
              AbsorbPointer(
                absorbing: absorb,
                child: SizedBox(
                  height: 70,
                  child: TabBar(
                    controller: tabController,
                    tabs: [
                      Tab(
                        child: Text(widget.cateId.subMenu![0].title!,
                            style: TextStyle(
                                color: tabController.index == 0
                                    ? AppColor.whiteTextColor
                                    : AppColor.blackTextColor,
                                fontWeight: tabController.index == 0
                                    ? FontWeight.w800
                                    : FontWeight.w300)),
                      ),
                      Tab(
                          child: Text(widget.cateId.subMenu![1].title!,
                              style: TextStyle(
                                  color: tabController.index == 1
                                      ? AppColor.whiteTextColor
                                      : AppColor.blackTextColor,
                                  fontWeight: tabController.index == 1
                                      ? FontWeight.w800
                                      : FontWeight.w300))),
                    ],
                    indicator: const BoxDecoration(
                      gradient: RadialGradient(radius: 2.5, colors: [
                        AppColor.pinkTextColor,
                        AppColor.whiteTextColor
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                      // Creates border
                    ),
                    labelColor: Colors.black,
                    onTap: (index) {
                      quranCubit.getQuranTranslationById(
                          widget.cateId.subMenu![index].catId!, widget.number);
                    },
                  ),
                ),
              ),
              _sizedBox,
              Expanded(
                child: BlocBuilder<QuranCubit, QuranState>(
                    builder: (context, state) {
                  if (state is QuranInitial) {
                    return const EmptySizedBox();
                  } else if (state is QuranLoadingState) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      setAbsorb(true);
                    });
                    return const WidgetLoading();
                  } else if (state is QuranSuccessState) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      setAbsorb(false);
                    });
                    if (state.category!.vod! is List) {
                      return SurahWisePage(state.category!.vod!);
                    }
                    return ParaWisePage(state.category!.vod!.data);
                  } else if (state is QuranErrorState) {
                    return const ErrorText();
                  } else {
                    return const ErrorText();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
