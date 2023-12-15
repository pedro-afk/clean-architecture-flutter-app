import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/data/request/request.dart';
import 'package:complete_advanced_flutter/domain/model/model.dart';
import 'package:complete_advanced_flutter/domain/repository/repository.dart';
import 'package:complete_advanced_flutter/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput registerUseCaseInput) async {
    return await _repository.register(
      RegisterRequest(
        registerUseCaseInput.countryMobileCode,
        registerUseCaseInput.name,
        registerUseCaseInput.email,
        registerUseCaseInput.password,
        registerUseCaseInput.mobileNumber,
        registerUseCaseInput.profilePicture,
      ),
    );
  }
}

class RegisterUseCaseInput {
  String countryMobileCode;
  String name;
  String email;
  String password;
  String mobileNumber;
  String profilePicture;

  RegisterUseCaseInput(
    this.countryMobileCode,
    this.name,
    this.email,
    this.password,
    this.mobileNumber,
    this.profilePicture,
  );
}
