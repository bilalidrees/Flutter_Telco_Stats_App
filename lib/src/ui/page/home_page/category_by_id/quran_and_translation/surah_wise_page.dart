import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:zong_islamic_web_app/src/cubit/surah_cubit/surah_cubit.dart';
import 'package:zong_islamic_web_app/src/model/surah_wise.dart';
import 'package:zong_islamic_web_app/src/model/trending.dart';
import 'package:zong_islamic_web_app/src/resource/repository/surah_repository.dart';
import 'package:zong_islamic_web_app/src/resource/utility/app_colors.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_empty_box.dart';
import 'package:zong_islamic_web_app/src/ui/widget/widget_loading.dart';

import 'audio_config.dart';

class SurahWisePage extends StatefulWidget {
  final List<Trending> surah;

  const SurahWisePage(this.surah, {Key? key}) : super(key: key);

  @override
  State<SurahWisePage> createState() => _SurahWisePageState();
}

class _SurahWisePageState extends State<SurahWisePage> with SingleTickerProviderStateMixin {
  String? dropdownValue;
  final surahCubit = SurahCubit(SurahRepository.getInstance()!);
  final AudioPlayer player = AudioPlayer();
  int surahNumber = 1;
  late final AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: const Duration(milliseconds: 500));
    dropdownValue = widget.surah.first.itemName!;
    surahCubit.getSurahByIdAndLang(int.parse(widget.surah.first.id!));
    super.initState();
  }

  @override
  void dispose() {
    surahCubit.close();
    player.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PhysicalModel(
          color: Colors.white,
          elevation: 4.0,
          shadowColor: Colors.grey,
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                          items: widget.surah
                              .map<DropdownMenuItem<String>>((Trending value) {
                            return DropdownMenuItem<String>(
                              onTap: ()async {
                                if (widget.surah.contains(value)) {
                                  await surahCubit.getSurahByIdAndLang(int.parse(value.id!));surahNumber = int.parse(value.id!);
                                  animationController.forward();
                                }
                              },
                              value: value.itemName,
                              child: Text(value.itemName!),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                _PlayPause(
                    animationController: animationController,
                    onPressed: () {
                      if (player.playing) {
                        animationController.reverse();
                        player.pause();
                      } else {
                        animationController.forward();
                        player.play();
                      }
                    }),
                const Spacer(),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
        BlocBuilder<SurahCubit, SurahState>(
            bloc: surahCubit,
            builder: (context, state) {
              if (state is SurahInitial) {
                return const EmptySizedBox();
              } else if (state is SurahLoadingState) {
                return const WidgetLoading();
              } else if (state is SurahSuccessState) {
                return _SurahListUi(animationController,
                    state.arbiSurah, state.urduSurah, surahNumber, player);
              } else if (state is SurahErrorState) {
                return Text(state.message);
              } else {
                return const Text('failed');
              }
            }),
      ],
    );
  }
}

class _SurahListUi extends StatefulWidget {
  final List<SurahWise> arabicList;
  final List<SurahWise> urduList;
  final int surahNumber;
  final AudioPlayer player;
  final AnimationController animationController;
  const _SurahListUi(this.animationController,
      this.arabicList, this.urduList, this.surahNumber, this.player,
      {Key? key})
      : super(key: key);

  @override
  State<_SurahListUi> createState() => _SurahListUiState();
}

class _SurahListUiState extends State<_SurahListUi> {
  late final AudioConfiguration audioConfiguration;
  int currentIndex = 0;
  late AutoScrollController controller;

  @override
  void initState() {
    controller = AutoScrollController(axis: Axis.vertical);
    audioConfiguration = AudioConfiguration(widget.player);
    widget.animationController.forward();
    playAudio();
    widget.player.playerStateStream.listen((snapshot) async {
      final playerState = snapshot;
      final processingState = playerState.processingState;
      final playing = playerState.playing;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        print(playing);
      } else if (processingState == ProcessingState.completed) {
        currentIndex++;
        setState(() {});
        _scrollToIndex();
        await playAudio();

      }
    });
    super.initState();
  }

  playAudio() async {
    int updatedCurrentIndex = currentIndex + 1;

    String ayat = (updatedCurrentIndex < 10)
        ? "00$updatedCurrentIndex"
        : (updatedCurrentIndex < 100)
            ? "0$updatedCurrentIndex"
            : updatedCurrentIndex.toString();
    String surah = (widget.surahNumber < 10)
        ? "00${widget.surahNumber}"
        : (widget.surahNumber < 100)
            ? "0${widget.surahNumber}"
            : "${widget.surahNumber}";

    print('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await audioConfiguration
        .init('https://vp.vxt.net:31786/quran/audio/ar/ghamdi/$surah$ayat.mp3');
    await widget.player.play();
  }
  Widget _wrapScrollTag({required int index, required Widget child}) =>
      AutoScrollTag(
        key: ValueKey(index),
        controller: controller,
        index: index,
        child: child,
        highlightColor: Colors.black.withOpacity(0.1),
      );
  Future _scrollToIndex() async {
    print(currentIndex);
    await controller.scrollToIndex(currentIndex, preferPosition: AutoScrollPosition.begin);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.arabicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                setState(() {
                  currentIndex = index;
                });
                playAudio();
                widget.animationController.forward();
                _scrollToIndex();
              },
              child: _wrapScrollTag(
                index: index,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: AppColor.whiteTextColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[400]!, width: 0.5),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0.75),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.arabicList[index].ar,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: currentIndex == index
                                ? Colors.pink
                                : Colors.grey[600]!),
                        textAlign: TextAlign.center,
                      ),
                      Text(widget.urduList[index].ur,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(color: Colors.grey[600]!),
                          textAlign: TextAlign.center),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              'Surah:${widget.arabicList[index].surah}-Ayat:${widget.arabicList[index].ayat}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey[600]!),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class _PlayPause extends StatelessWidget {
  final AnimationController animationController;
  final void Function() onPressed;


  const _PlayPause(
      {Key? key, required this.onPressed, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 50,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Colors.lightGreen),
        child: AnimatedIcon(
          color: Colors.white,
          icon: AnimatedIcons.play_pause,
          progress: animationController,
        ),
      ),
    );
  }
}
