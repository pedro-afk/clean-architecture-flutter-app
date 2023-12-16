import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class StoreDetailUseCase implements BaseUseCase<void, StoreDetail> {
  final Repository _repository;

  StoreDetailUseCase(this._repository);

  @override
  Future<Either<Failure, StoreDetail>> execute([void input]) async {
    return await _repository.getStoreDetail();
  }
}