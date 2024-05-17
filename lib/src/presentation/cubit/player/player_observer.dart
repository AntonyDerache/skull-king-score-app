import 'package:bloc/bloc.dart';

class PlayerObserver extends BlocObserver {
  const PlayerObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }
}
