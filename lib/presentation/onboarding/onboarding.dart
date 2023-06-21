import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  OnBoardingViewModel viewmodel = OnBoardingViewModel();

  void _bind() {
    viewmodel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    viewmodel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: viewmodel.outputSliderViewObject,
      builder: (context, snapshot) {
        if (snapshot.data == null) return Container();

        return Scaffold(
          backgroundColor: ColorManager.white,
          appBar: AppBar(
            backgroundColor: ColorManager.white,
            elevation: AppSize.s0,
            /*systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
            ),*/
          ),
          body: PageView.builder(
            controller: _pageController,
            itemCount: snapshot.data!.numOfSlides,
            onPageChanged: (index) => viewmodel.onPageChanged(index),
            itemBuilder: (context, index) => OnBoardingPage(
              sliderObject: snapshot.data!.sliderObject,
            ),
          ),
          bottomSheet: Container(
            height: AppSize.s96,
            color: ColorManager.white,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.skip,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                _getBottomSheetWidget(snapshot.data!),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () => _pageController.animateToPage(
                viewmodel.goPrevius(),
                duration: const Duration(milliseconds: DurationConstant.d300),
                curve: Curves.bounceInOut,
              ),
              child: SizedBox(
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIc),
              ),
            ),
          ),
          Row(
            children: List.generate(
              sliderViewObject.numOfSlides,
              (index) => Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: ProperCircle(
                    index: index,
                    currentIndex: sliderViewObject.currentIndex,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () => _pageController.animateToPage(
                viewmodel.goNext(),
                duration: const Duration(milliseconds: DurationConstant.d300),
                curve: Curves.bounceInOut,
              ),
              child: SizedBox(
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIc),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProperCircle extends StatelessWidget {
  final int index;
  final int currentIndex;
  const ProperCircle({
    Key? key,
    required this.index,
    required this.currentIndex
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIc);
    }
    return SvgPicture.asset(ImageAssets.solidCircleIc);
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject sliderObject;

  const OnBoardingPage({Key? key, required this.sliderObject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s40),
        Text(
          sliderObject.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          sliderObject.subTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSize.s60),
        SvgPicture.asset(sliderObject.image),
      ],
    );
  }
}