import 'package:city_flower/core/network/error/failure.dart';
import 'package:city_flower/core/usecase.dart';
import 'package:city_flower/features/home/domain/repository/banner_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class GetHomeBannerUsecase extends UseCase<List<String>, NoParams> {
  final BannerRepository bannerRepository;

  GetHomeBannerUsecase({@required this.bannerRepository});

  @override
  Future<Either<Failure, List<String>>> call(NoParams params) async {
    return await bannerRepository.getBanners();
  }
}
