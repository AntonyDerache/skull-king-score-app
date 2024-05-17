import 'package:bloc/bloc.dart';

class RoundObserver extends BlocObserver {
  const RoundObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
  }
}
