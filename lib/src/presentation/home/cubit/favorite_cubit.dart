import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/utils/utils.dart';
import 'package:bloc/bloc.dart';

import 'report_cubit.dart';

FavoriteCubit get favoriteCubit => findInstance<FavoriteCubit>();

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState());

  addToFavorite(CivitaiImage m) {
    List<CivitaiImage> images = (AppPrefs.instance.favoriteImages ?? [])
      ..insert(0, m);
    AppPrefs.instance.favoriteImages = images;
    fetchFavorites();
  }

  removeToFavorite(CivitaiImage m) {
    List<CivitaiImage> images = (AppPrefs.instance.favoriteImages ?? [])
      ..removeWhere((e) => e.id == m.id);
    AppPrefs.instance.favoriteImages = images;
    fetchFavorites();
  }

  updateFilter({String? sort}) {
    emit(state.copyWith(sort: sort));
    if (sort != null) fetchFavorites(refresh: true);
  }

  fetchFavorites({bool refresh = false}) async {
    if (refresh) {
      state.images = null;
      emit(state.copyWith());
    }
    state.images = AppPrefs.instance.favoriteImages;
    emit(state.copyWith());
  }
}

class FavoriteState {
  String sort;
  List<CivitaiImage>? images;

  List<CivitaiImage>? get imagesDisplay =>
      images?.where((e) => !reportCubit.state.isReported(e)).toList();

  FavoriteState({
    this.sort = "Most Reactions",
    this.images,
  });

  bool isFavorited(m) => images?.any((e) => e.id == m.id) == true;

  FavoriteState copyWith({
    String? sort,
    List<CivitaiImage>? images,
  }) {
    return FavoriteState(
      sort: sort ?? this.sort,
      images: images ?? this.images,
    );
  }
}
