import 'package:app/src/network_resources/civitai/model/model.dart';
import 'package:app/src/utils/utils.dart';
import 'package:bloc/bloc.dart';

ReportCubit get reportCubit => findInstance<ReportCubit>();

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportState());

  addToReport(CivitaiImage m) {
    List<CivitaiImage> images = (AppPrefs.instance.reportedImages ?? [])
      ..insert(0, m);
    AppPrefs.instance.reportedImages = images;
    fetchReports();
  }

  removeToReport(CivitaiImage m) {
    List<CivitaiImage> images = (AppPrefs.instance.reportedImages ?? [])
      ..removeWhere((e) => e.id == m.id);
    AppPrefs.instance.reportedImages = images;
    fetchReports();
  }

  fetchReports({bool refresh = false}) async {
    if (refresh) {
      state.images = null;
      emit(state.copyWith());
    }
    state.images = AppPrefs.instance.reportedImages;
    emit(state.copyWith());
  }
}

class ReportState {
  List<CivitaiImage>? images;

  ReportState({
    this.images,
  });

  bool isReported(CivitaiImage m) => images?.any((e) => e.id == m.id) == true;

  ReportState copyWith({
    List<CivitaiImage>? images,
  }) {
    return ReportState(
      images: images ?? this.images,
    );
  }
}
