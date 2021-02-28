import 'package:addis_teller_app/auth/auth.dart';
import 'package:addis_teller_app/multi.dart';
import 'package:addis_teller_app/post/bloc/bloc.dart';
import 'package:addis_teller_app/post/data_provider/data_provider.dart';
import 'package:addis_teller_app/post/repository/post_repository.dart';
import 'package:addis_teller_app/station/screens/homepage.dart';
import 'package:addis_teller_app/auth/screens/login.dart';
import 'package:addis_teller_app/station/screens/routes.dart';
import 'package:addis_teller_app/station/station.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'blocObservor.dart';

String token;
Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preference = await SharedPreferences.getInstance();
  token = preference.getString('token');

  final AuthRepo authRepo =
      AuthRepo(authDataProvider: AuthDataProvider(httpClient: http.Client()));
  final StationRepository stationRepository = StationRepository(
      stationDataProvider: StationDataProvider(httpClient: http.Client()));
  final PostRepository postRepository =
      PostRepository(postProvider: PostDataProvider(httpClient: http.Client()));
  runApp(AddisTeller(
    authRepo: authRepo,
    stationRepository: stationRepository,
    postRepository: postRepository,
  ));
}

class AddisTeller extends StatelessWidget {
  AddisTeller(
      {@required this.authRepo,
      @required this.stationRepository,
      @required this.postRepository})
      : assert(authRepo != null),
        assert(stationRepository != null);
  final AuthRepo authRepo;
  final StationRepository stationRepository;
  final PostRepository postRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepo>(create: (context) => authRepo),
        RepositoryProvider<StationRepository>(
            create: (context) => stationRepository),
        RepositoryProvider(create: (context) => postRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  AuthBloc(authRepo: authRepo)..add(StartEvent())),
          BlocProvider(
              create: (context) =>
                  StationBloc(stationRepository: stationRepository)
                    ..add(StationLoad())),
          BlocProvider(
              create: (context) =>
                  PostBloc(postRepository: postRepository)..add(PostLoad()))
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: token != null ? Homepage.routeName : Login.routeName,
          onGenerateRoute: StationAppRoute.generateRoute,
        ),
      ),
    );
  }
}
