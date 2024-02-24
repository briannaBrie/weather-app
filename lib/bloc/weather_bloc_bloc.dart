import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  // 81e7c1a3383d9fb6a5c0ca77c8b03ae6  -api_key
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);

        // Position pstn = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
            event.pstn.latitude, event.pstn.longitude);
        print(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        print(e);
        emit(WeatherBlocFailure());
      }
    });
  }
}
