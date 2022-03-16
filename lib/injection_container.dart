import 'package:city_flower/core/user/bloc/user_bloc.dart';
import 'package:city_flower/core/user/usecase/load_user_details_usecase.dart';
import 'package:city_flower/features/cf_card/presentation/bloc/cf_card_bloc.dart';
import 'package:city_flower/features/home/data/datasource/banner_datasource.dart';
import 'package:city_flower/features/home/data/datasource/banner_datasource_impl.dart';
import 'package:city_flower/features/home/data/repository/banner_repository_impl.dart';
import 'package:city_flower/features/home/domain/repository/banner_repository.dart';
import 'package:city_flower/features/home/domain/usecase/get_home_banners_usecase.dart';
import 'package:city_flower/features/home/presentation/bloc/home_bloc.dart';
import 'package:city_flower/features/intro/domain/usecase/set_first_launch_complete.dart';
import 'package:city_flower/features/intro/presentation/bloc/intro_bloc.dart';
import 'package:city_flower/features/login/presentation/bloc/login_bloc.dart';
import 'package:city_flower/features/otp/data/datasource/otp_datasource.dart';
import 'package:city_flower/features/otp/data/datasource/otp_datasource_impl.dart';
import 'package:city_flower/features/otp/data/repository/otp_repository_impl.dart';
import 'package:city_flower/features/otp/domain/repository/otp_repository.dart';
import 'package:city_flower/features/otp/presentation/bloc/otp_bloc.dart';
import 'package:city_flower/features/outlet_list/data/datasource/outlet_datasource.dart';
import 'package:city_flower/features/outlet_list/data/datasource/outlet_datasource_impl.dart';
import 'package:city_flower/features/outlet_list/data/respository/outlet_repository_impl.dart';
import 'package:city_flower/features/outlet_list/domain/repository/outlet_repository.dart';
import 'package:city_flower/features/outlet_list/domain/usecase/get_outlet_list_usecase.dart';
import 'package:city_flower/features/outlet_list/presentation/bloc/outlet_list_bloc.dart';
import 'package:city_flower/features/points_history/data/datasource/points_history_datasource.dart';
import 'package:city_flower/features/points_history/data/datasource/points_history_datasource_impl.dart';
import 'package:city_flower/features/points_history/data/respository/points_history_repository_impl.dart';
import 'package:city_flower/features/points_history/domain/respository/points_history_repository.dart';
import 'package:city_flower/features/points_history/domain/usecase/get_points_history_usecase.dart';
import 'package:city_flower/features/points_history/presentation/bloc/points_history_bloc.dart';
import 'package:city_flower/features/promotion/data/datasource/promotion_data_source.dart';
import 'package:city_flower/features/promotion/data/datasource/promotion_data_source_impl.dart';
import 'package:city_flower/features/promotion/data/repository/promotions_repository_impl.dart';
import 'package:city_flower/features/promotion/domain/repository/promotions_repository.dart';
import 'package:city_flower/features/promotion/domain/usecase/get_promotions.dart';
import 'package:city_flower/features/promotion/presentation/bloc/promotion_bloc.dart';
import 'package:city_flower/features/register/domain/usecase/register_usecase.dart';
import 'package:city_flower/features/register/presentation/bloc/register_bloc.dart';
import 'package:city_flower/features/set_password/domain/entity/set_password_usecase.dart';
import 'package:city_flower/features/set_password/presentation/bloc/set_password_bloc.dart';
import 'package:city_flower/features/splash/data/datasource/splash_data_source.dart';
import 'package:city_flower/features/splash/data/datasource/splash_datasource_impl.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource.dart';
import 'package:city_flower/features/user/data/datasource/user_datasource_impl.dart';
import 'package:city_flower/features/user/domain/repository/user_repository.dart';
import 'package:city_flower/features/user/domain/usecase/check_user_logged_in.dart';
import 'package:city_flower/features/user/domain/usecase/get_mycf_card_details.dart';
import 'package:city_flower/features/user/domain/usecase/get_user_token.dart';
import 'package:city_flower/features/user/domain/usecase/login_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/logout_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_data_usecase.dart';
import 'package:city_flower/features/user/domain/usecase/save_user_token.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/splash/data/repository/splash_repository_impl.dart';
import 'features/splash/domain/repository/splash_repository.dart';
import 'features/splash/domain/usecase/check_first_launch.dart';
import 'features/splash/presentation/bloc/splash_bloc.dart';
import 'features/user/data/repository/user_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //Bloc
  serviceLocator.registerFactory(() => SplashBloc(
      checkFirstLaunch: serviceLocator(),
      userLoggedInUseCase: serviceLocator()));
  serviceLocator.registerFactory(
      () => IntroBloc(setFirstLaunchComplete: serviceLocator()));
  serviceLocator.registerFactory(
    () => LoginBloc(
      loginUseCase: serviceLocator(),
      saveUserDataUseCase: serviceLocator(),
      saveUserTokenUseCase: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(() => OtpBloc(
      otpRepository: serviceLocator(),
      saveUserDataUseCase: serviceLocator(),
      saveUserTokenUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => UserBloc(
      userDetailsUsecase: serviceLocator(), logoutUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => HomeBloc(
      getBannerUsecase: serviceLocator(),
      getMyCfCardDetails: serviceLocator()));
  serviceLocator
      .registerFactory(() => CfCardBloc(getMyCfCardDetails: serviceLocator()));
  serviceLocator
      .registerFactory(() => PromotionBloc(promotionUseCase: serviceLocator()));
  serviceLocator.registerFactory(
      () => OutletListBloc(getOutletListUseCase: serviceLocator()));
  serviceLocator.registerFactory(
      () => PointsHistoryBloc(getPointsHistoryUseCase: serviceLocator()));
  serviceLocator
      .registerFactory(() => RegisterBloc(registerUseCase: serviceLocator()));
  serviceLocator.registerFactory(() => SetPasswordBloc(
      saveUserDataUseCase: serviceLocator(),
      saveUserTokenUseCase: serviceLocator(),
      setPasswordUseCase: serviceLocator(),
      getUserTokenUseCase: serviceLocator()));

  /*
    ** Usecase
   */
  //check_first_launch_usecase
  serviceLocator.registerLazySingleton<CheckFirstLaunch>(
      () => CheckFirstLaunch(splashRepository: serviceLocator()));
  //check_first_launch_usecase
  serviceLocator.registerLazySingleton<CheckUserLoggedInUseCase>(
      () => CheckUserLoggedInUseCase(userRepository: serviceLocator()));
  //set_first_launch_complete
  serviceLocator.registerLazySingleton<SetFirstLaunchComplete>(
      () => SetFirstLaunchComplete(splashRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => LoginUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SaveUserDataUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SaveUserTokenUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => LoadUserDetailsUsecase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetHomeBannerUsecase(bannerRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetMyCfCardDetails(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetPromotionUseCase(promotionsRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => LogoutUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetOutletListUseCase(outletRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetPointsHistoryUseCase(pointsHistoryRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => RegisterUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SetPasswordUseCase(userRepository: serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => GetUserTokenUseCase(userRepository: serviceLocator()));

  /*
    ** Repositories
   */
  //splash_repository
  serviceLocator.registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(dataSource: serviceLocator()));

  //user_repository
  serviceLocator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userDataSource: serviceLocator(), networkInfo: serviceLocator()));
  //OTPRepository
  serviceLocator.registerLazySingleton<OTPRepository>(() => OTPRepositoryImpl(
      networkInfo: serviceLocator(), otpDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<BannerRepository>(() =>
      BannerRepositoryImpl(
          networkInfo: serviceLocator(),
          bannerDataSource: serviceLocator(),
          userDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<PromotionsRepository>(() =>
      PromotionsRepositoryImpl(
          networkInfo: serviceLocator(),
          promotionDataSource: serviceLocator(),
          userDataSource: serviceLocator()));

  serviceLocator.registerLazySingleton<OutletRepository>(() =>
      OutletRepositoryImpl(
          networkInfo: serviceLocator(),
          outletDataSource: serviceLocator(),
          userDataSource: serviceLocator()));
  serviceLocator.registerLazySingleton<PointsHistoryRepository>(() =>
      PointsHistoryRepositoryImpl(
          userDataSource: serviceLocator(),
          networkInfo: serviceLocator(),
          pointsHistoryDataSource: serviceLocator()));

  /*
    ** Datasource
   */
  //splash_datasource
  serviceLocator.registerLazySingleton<SplashDataSource>(
      () => SplashDataSourceImpl(sharedPreferences: serviceLocator()));

  //user_datasource
  serviceLocator.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
      preferences: serviceLocator(), httpClient: serviceLocator()));

  //OTPDataSource
  serviceLocator.registerLazySingleton<OTPDataSource>(
      () => OTPDataSourceImpl(client: serviceLocator()));

  //OTPDataSource
  serviceLocator.registerLazySingleton<BannerDataSource>(
      () => BannerDataSourceImpl(httpClient: serviceLocator()));

  serviceLocator.registerLazySingleton<PromotionsDataSource>(
      () => PromotionsDataSourceImpl(httpClient: serviceLocator()));
  serviceLocator.registerLazySingleton<OutletDataSource>(
      () => OutletDataSourceImpl(client: serviceLocator()));
  serviceLocator.registerLazySingleton<PointsHistoryDataSource>(
      () => PointsHistoryDataSourceImpl(httpClient: serviceLocator()));

  //Core
  serviceLocator.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(serviceLocator()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => DataConnectionChecker());
}
