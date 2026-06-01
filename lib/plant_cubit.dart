import 'package:flutter_application_8/services/plant_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_8/models/list_model.dart';

abstract class PlantState {}

class PlantInitial extends PlantState {}
class PlantLoading extends PlantState {}
class PlantLoaded extends PlantState {
  final List<Plant> plants;
  PlantLoaded(this.plants);
}
class PlantError extends PlantState {
  final String message;
  PlantError(this.message);
}

class PlantCubit extends Cubit<PlantState> {
  final PlantApiService apiService;

  PlantCubit(this.apiService) : super(PlantInitial());

  void getPlants() async {
    emit(PlantLoading());
    try {
      final plantsList = await apiService.fetchPlantsList();
      emit(PlantLoaded(plantsList));
    } catch (e) {
      emit(PlantError(e.toString()));
    }
  }
}