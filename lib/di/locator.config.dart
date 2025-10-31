// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_widgets/image/image_loader.dart' as _i698;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../database/database.dart' as _i660;
import '../features/news/data/data_source/local/news_local_data_source.dart'
    as _i282;
import '../features/news/data/data_source/remote/news_remote_data_source.dart'
    as _i776;
import '../features/news/data/data_source/remote/news_rest_client.dart'
    as _i874;
import '../features/news/data/repositories/news_repository.dart' as _i1001;
import '../features/news/domain/repositories/news_repository.dart' as _i828;
import '../features/news/domain/usecases/news_list_as_stream_usecase.dart'
    as _i929;
import '../features/news/domain/usecases/news_list_usecase.dart' as _i222;
import '../features/news/domain/usecases/sort_news_list_by_query_usecase.dart'
    as _i989;
import '../features/news/presenter/providers/news_list_provider.dart' as _i78;
import '../navigation/navigation_service.dart' as _i17;
import 'data_injector.dart' as _i518;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerDataModule = _$RegisterDataModule();
  gh.lazySingleton<_i361.Dio>(() => registerDataModule.dio);
  await gh.lazySingletonAsync<_i660.NewsDatabase>(
    () => registerDataModule.initDatabase(),
    preResolve: true,
  );
  gh.lazySingleton<String>(
    () => registerDataModule.basetUrl,
    instanceName: 'baseUrl',
  );
  gh.factory<_i989.SortNewsListByQueryUsecase>(
      () => _i989.SortNewsListByQueryUsecase());
  gh.lazySingleton<_i17.NavigationService>(
      () => registerDataModule.navigationService);
  gh.lazySingleton<_i698.ImageLoader>(
    () => registerDataModule.networkImageLoader,
    instanceName: 'NetworkImageLoader',
  );
  gh.lazySingleton<_i698.ImageLoader>(
    () => registerDataModule.assetEmptyImageLoader,
    instanceName: 'AssetEmptyImageLoader',
  );
  gh.factory<_i282.NewsLocalDataSource>(
      () => _i282.NewsLocalDataSourceImpl(database: gh<_i660.NewsDatabase>()));
  gh.factory<_i874.NewsRestClient>(() => _i874.NewsRestClient(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.factory<_i776.NewsRemoteDataSource>(() =>
      _i776.NewsRemoteDataSourceImpl(restClient: gh<_i874.NewsRestClient>()));
  gh.factory<_i828.NewsRepository>(() => _i1001.NewsRepositoryImpl(
        newsLocalDataSource: gh<_i282.NewsLocalDataSource>(),
        newsRemoteDataSource: gh<_i776.NewsRemoteDataSource>(),
      ));
  gh.factory<_i929.NewsListAsStreamUsecase>(() => _i929.NewsListAsStreamUsecase(
      newsRepository: gh<_i828.NewsRepository>()));
  gh.factory<_i222.NewsListUsecase>(
      () => _i222.NewsListUsecase(newsRepository: gh<_i828.NewsRepository>()));
  gh.factory<_i78.GetNewsListCubit>(() => _i78.GetNewsListCubit(
        newsListAsStreamUsecase: gh<_i929.NewsListAsStreamUsecase>(),
        newsListUsecase: gh<_i222.NewsListUsecase>(),
        sortNewsUsecase: gh<_i989.SortNewsListByQueryUsecase>(),
      ));
  return getIt;
}

class _$RegisterDataModule extends _i518.RegisterDataModule {}
