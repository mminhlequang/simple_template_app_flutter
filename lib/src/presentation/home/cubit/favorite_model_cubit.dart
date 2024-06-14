import 'package:app/src/utils/utils.dart';
import 'package:bloc/bloc.dart';

FavoriteModelCubit get favoriteModelCubit => findInstance<FavoriteModelCubit>();

class FavoriteModelCubit extends Cubit<FavoriteModelState> {
  FavoriteModelCubit() : super(FavoriteModelState());

  addToFavorite(int m) {
    List<int> images = (AppPrefs.instance.favoriteModels ?? [])..insert(0, m);
    AppPrefs.instance.favoriteModels = images;
    fetchFavorites();
  }

  removeToFavorite(int m) {
    List<int> images = (AppPrefs.instance.favoriteModels ?? [])
      ..removeWhere((e) => e == m);
    AppPrefs.instance.favoriteModels = images;
    fetchFavorites();
  }

  fetchFavorites({bool refresh = false}) async {
    if (refresh) {
      state.images = null;
      emit(state.copyWith());
    }
    state.images = AppPrefs.instance.favoriteModels;
    emit(state.copyWith());
  }
}

class FavoriteModelState {
  List<int>? images;

  FavoriteModelState({
    this.images,
  });

  bool isFavorited(int m) => images?.any((e) => e == m) == true;

  FavoriteModelState copyWith({
    List<int>? images,
  }) {
    return FavoriteModelState(
      images: images ?? this.images,
    );
  }
}
