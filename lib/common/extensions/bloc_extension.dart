import 'package:bloc/bloc.dart';

extension CubitX<T> on Cubit<T> {
  void safeEmit(T state) {
    if (isClosed) return;
    emit(state);
  }
}

extension BlocX<T, E> on Bloc<T, E> {
  void safeEmit(E state) {
    if (isClosed) return;
    emit(state);
  }
}
