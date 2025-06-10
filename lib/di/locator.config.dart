// GENERATED CODE - DO NOT MODIFY BY HAND

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

import '../features/news/data/data_source/local/news_local_data_source.dart' as _i261;
import '../features/news/data/data_source/remote/news_remote_data_source.dart' as _i198;
import '../features/news/data/data_source/remote/news_rest_client.dart' as _i775;
import '../features/news/data/repositories/news_repository.dart' as _i1041;
import '../features/news/domain/repositories/news_repository.dart' as _i258;
import '../features/news/domain/usecases/news_list_as_stream_usecase.dart' as _i685;
import '../features/news/domain/usecases/news_list_usecase.dart' as _i236;
import '../features/news/domain/usecases/sort_news_list_by_query_usecase.dart' as _i342;
import '../navigation/navigation_service.dart' as _i568;
import '../database/database.dart' as _i49;
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
  await gh.lazySingletonAsync<_i49.NewsDatabase>(
    () => registerDataModule.initDatabase(),
    preResolve: true,
  );
  gh.lazySingleton<String>(
    () => registerDataModule.basetUrl,
    instanceName: 'baseUrl',
  );
  gh.factory<_i342.SortNewsListByQueryUsecase>(() => _i342.SortNewsListByQueryUsecase());
  gh.lazySingleton<_i568.NavigationService>(() => registerDataModule.navigationService);
  gh.lazySingleton<_i698.ImageLoader>(
    () => registerDataModule.networkImageLoader,
    instanceName: 'NetworkImageLoader',
  );
  gh.factory<_i261.NewsLocalDataSource>(() => _i261.NewsLocalDataSourceImpl(database: gh<_i49.NewsDatabase>()));
  gh.lazySingleton<_i698.ImageLoader>(
    () => registerDataModule.assetEmptyImageLoader,
    instanceName: 'AssetEmptyImageLoader',
  );
  gh.factory<_i775.NewsRestClient>(() => _i775.NewsRestClient(
        gh<_i361.Dio>(),
        baseUrl: gh<String>(instanceName: 'baseUrl'),
      ));
  gh.factory<_i198.NewsRemoteDataSource>(() => _i198.NewsRemoteDataSourceImpl(restClient: gh<_i775.NewsRestClient>()));
  gh.factory<_i258.NewsRepository>(() => _i1041.NewsRepositoryImpl(
        newsLocalDataSource: gh<_i261.NewsLocalDataSource>(),
        newsRemoteDataSource: gh<_i198.NewsRemoteDataSource>(),
      ));
  gh.factory<_i685.NewsListAsStreamUsecase>(() => _i685.NewsListAsStreamUsecase(newsRepository: gh<_i258.NewsRepository>()));
  gh.factory<_i236.NewsListUsecase>(() => _i236.NewsListUsecase(newsRepository: gh<_i258.NewsRepository>()));
  return getIt;
}

class _$RegisterDataModule extends _i518.RegisterDataModule {}
