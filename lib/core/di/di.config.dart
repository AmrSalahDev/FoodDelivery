// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:food_delivery/core/services/auth_service.dart' as _i717;
import 'package:food_delivery/core/services/location_service.dart' as _i750;
import 'package:food_delivery/core/services/toast_service.dart' as _i947;
import 'package:food_delivery/features/cart/ui/cubits/cart_cubit.dart' as _i963;
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_address_cubit.dart'
    as _i740;
import 'package:food_delivery/features/cart/ui/cubits/cart_edit_items_cubit.dart'
    as _i273;
import 'package:food_delivery/features/home/data/repo/home_repo_impl.dart'
    as _i343;
import 'package:food_delivery/features/home/domain/repo/home_repo.dart'
    as _i534;
import 'package:food_delivery/features/home/domain/usecases/fetch_categories_usecase.dart'
    as _i561;
import 'package:food_delivery/features/home/ui/cubit/home_category_cubit.dart'
    as _i117;
import 'package:food_delivery/features/home/ui/cubit/home_cubit.dart' as _i559;
import 'package:food_delivery/features/login/data/repo/login_repo_impl.dart'
    as _i392;
import 'package:food_delivery/features/login/domain/repo/login_repo.dart'
    as _i852;
import 'package:food_delivery/features/login/domain/usecases/login_usecase.dart'
    as _i36;
import 'package:food_delivery/features/login/ui/cubit/login_cubit.dart'
    as _i318;
import 'package:food_delivery/features/payment/ui/cubits/card_cubit.dart'
    as _i211;
import 'package:food_delivery/features/payment/ui/cubits/selected_card_cubit.dart'
    as _i807;
import 'package:food_delivery/features/register/data/repo/register_repo_impl.dart'
    as _i70;
import 'package:food_delivery/features/register/domain/repo/register_repo.dart'
    as _i566;
import 'package:food_delivery/features/register/domain/usecases/register_usecase.dart'
    as _i640;
import 'package:food_delivery/features/register/ui/cubit/register_cubit.dart'
    as _i325;
import 'package:food_delivery/shared/cubits/food_cubit.dart' as _i1067;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i740.CartEditAddressCubit>(() => _i740.CartEditAddressCubit());
    gh.factory<_i273.CartEditItemsCubit>(() => _i273.CartEditItemsCubit());
    gh.factory<_i807.SelectedCardCubit>(() => _i807.SelectedCardCubit());
    gh.factory<_i559.HomeCubit>(() => _i559.HomeCubit());
    gh.lazySingleton<_i717.AuthService>(() => _i717.AuthService());
    gh.lazySingleton<_i750.LocationService>(() => _i750.LocationService());
    gh.lazySingleton<_i947.ToastService>(() => _i947.ToastService());
    gh.lazySingleton<_i963.CartCubit>(() => _i963.CartCubit());
    gh.lazySingleton<_i211.CardCubit>(() => _i211.CardCubit());
    gh.lazySingleton<_i1067.FoodCubit>(() => _i1067.FoodCubit());
    gh.lazySingleton<_i852.LoginRepo>(() => _i392.LoginRepoImpl());
    gh.lazySingleton<_i534.HomeRepo>(() => _i343.HomeRepoImpl());
    gh.lazySingleton<_i566.RegisterRepo>(() => _i70.RegisterRepoImpl());
    gh.factory<_i36.LoginUseCase>(
      () => _i36.LoginUseCase(loginRepo: gh<_i852.LoginRepo>()),
    );
    gh.factory<_i640.RegisterUseCase>(
      () => _i640.RegisterUseCase(registerRepo: gh<_i566.RegisterRepo>()),
    );
    gh.factory<_i561.FetchCategoriesUsecase>(
      () => _i561.FetchCategoriesUsecase(homeRepo: gh<_i534.HomeRepo>()),
    );
    gh.factory<_i325.RegisterCubit>(
      () => _i325.RegisterCubit(gh<_i640.RegisterUseCase>()),
    );
    gh.factory<_i318.LoginCubit>(
      () => _i318.LoginCubit(gh<_i36.LoginUseCase>()),
    );
    gh.factory<_i117.HomeCategoryCubit>(
      () => _i117.HomeCategoryCubit(gh<_i561.FetchCategoriesUsecase>()),
    );
    return this;
  }
}
