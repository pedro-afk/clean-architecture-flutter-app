import 'package:complete_advanced_flutter/app/di.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/font_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/store_details/store_details_viewmodel.dart';
import 'package:flutter/material.dart';

// TODO: refactor this widget
class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetailsView> {
  final _viewModel = instance<StoreDetailsViewModel>();

  void _bind() => _viewModel.start();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.storeDetails),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _detailBody(),
                () => _viewModel.start(),
              ) ??
              Container();
        },
      ),
    );
  }

  Widget _detailBody() {
    return StreamBuilder<StoreDetail>(
      stream: _viewModel.outputStoreDetail,
      builder: (context, snapshot) {
        StoreDetail? detail = snapshot.data;
        if (detail != null) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  detail.image ?? empty,
                  fit: BoxFit.cover,
                  height: AppSize.s300,
                ),
                const SizedBox(height: AppSize.s28),
                Text(
                  AppStrings.details,
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(detail.details ?? empty),
                const SizedBox(height: AppSize.s16),
                Text(
                  AppStrings.services,
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(detail.services ?? empty),
                const SizedBox(height: AppSize.s16),
                Text(
                  AppStrings.about,
                  style: getBoldStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s18,
                  ),
                ),
                Text(detail.about ?? empty),
                const SizedBox(height: AppSize.s16),
              ],
            ),
          );
        }
        return const Center(
          child: Text(AppStrings.noDetails),
        );
      },
    );
  }
}
