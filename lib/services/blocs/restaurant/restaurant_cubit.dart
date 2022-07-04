import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:moj_student/data/restaurant/restaurant_data_model.dart';
import 'package:moj_student/data/restaurant/restaurant_repo.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantRepo restaurantRepo;

  RestaurantCubit(this.restaurantRepo) : super(RestaurantLoadingState()) {
    loadData();
  }

  Future<void> loadData() async {
    emit(RestaurantLoadingState());
    try {
      var data = await restaurantRepo.getRestaurantData();
      emit(RestaurantLoadedState(data));
    } catch (e) {
      emit(RestaurantErrorState("Napaka pri pridobivanju podatkov"));
    }
  }
}
