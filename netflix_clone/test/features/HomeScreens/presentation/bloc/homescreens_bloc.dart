import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'homescreens_event.dart';
part 'homescreens_state.dart';

class HomescreensBloc extends Bloc<HomescreensEvent, HomescreensState> {
  HomescreensBloc() : super(HomescreensInitial()) {
    on<HomescreensEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
