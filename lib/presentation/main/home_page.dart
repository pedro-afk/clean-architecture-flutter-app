import 'package:carousel_slider/carousel_slider.dart';
import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:complete_advanced_flutter/presentation/main/home/home_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

// TODO: refactor this widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = instance<HomeViewModel>();

  void _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
              context,
              _homeBody(),
              () => _viewModel.start(),
            ) ??
            Container();
      },
    );
  }

  Widget _homeBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: snapshot.data?.banners
                        .map(
                          (banner) => SizedBox(
                            width: double.infinity,
                            child: Card(
                              child: Image.network(
                                banner.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList() ??
                    [],
                options: CarouselOptions(
                  height: AppSize.s190,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: AppSize.si3),
                  autoPlayAnimationDuration:
                      const Duration(milliseconds: AppSize.si800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Text(
                "Services",
                style: getBoldStyle(color: ColorManager.primary),
              ),
              SizedBox(
                height: AppSize.s200,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data?.services
                          .map(
                            (service) => SizedBox(
                              width: AppSize.s190,
                              child: Card(
                                child: Column(
                                  children: [
                                    Image.network(
                                      service.image,
                                      fit: BoxFit.cover,
                                      height: AppSize.s160,
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          service.title,
                                          textAlign: TextAlign.center,
                                          style: getMediumStyle(
                                            color: ColorManager.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Text(
                "Stores",
                style: getBoldStyle(color: ColorManager.primary),
              ),
              Flex(
                direction: Axis.vertical,
                children: [
                  GridView.count(
                    crossAxisSpacing: AppSize.s8,
                    mainAxisSpacing: AppSize.s8,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: AppSize.si2,
                    children: List.generate(
                      (snapshot.data?.stores ?? []).length,
                      (index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.storeDetailsRoute);
                          },
                          child: Card(
                            child: Image.network(
                              snapshot.data?.stores[index].image ?? empty,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
