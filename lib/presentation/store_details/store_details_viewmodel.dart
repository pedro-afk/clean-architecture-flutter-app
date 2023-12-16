import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/usecase/store_detail_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StoreDetailUseCase _storeDetailUseCase;
  final _storeDetailsStreamController = BehaviorSubject<StoreDetail>();

  StoreDetailsViewModel(this._storeDetailUseCase);

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  @override
  void start() {
    _loadData();
  }

  Future<void> _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullscreenLoadingState));
    (await _storeDetailUseCase.execute()).fold(
      (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullscreenErrorState, failure.message));
      },
      (data) {
        inputState.add(ContentState());
        inputStoreDetail.add(data);
      },
    );
  }

  @override
  Sink get inputStoreDetail => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetail> get outputStoreDetail => _storeDetailsStreamController.stream;
}

abstract class StoreDetailsViewModelInputs {
  Sink get inputStoreDetail;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetail> get outputStoreDetail;
}
