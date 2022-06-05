part of 'gallery_bloc.dart';

enum GalleryStatus { initial, loading, success, failure }

extension GalleryStatusX on GalleryStatus {
  bool get isLoadingOrSuccess => [
        GalleryStatus.loading,
        GalleryStatus.success,
      ].contains(this);
}

class GalleryState extends Equatable {
  const GalleryState({
    this.status = GalleryStatus.initial,
    this.workers = const [],
    this.lastDeletedWorker,
    this.selected,
    this.filtersIsOpen = false,
    this.filters = Filters.empty,
    this.allLicenses = const [],
    this.allLanguages = const [],
    this.allAreas = const [],
    this.allFields = const [],
    this.searchMode = false,
  });

  final GalleryStatus status;
  final List<Worker> workers;
  final Worker? lastDeletedWorker;
  final Worker? selected;
  final bool filtersIsOpen;

  final List<String> allLanguages;
  final List<String> allLicenses;
  final List<String> allAreas;
  final List<String> allFields;

  final Filters filters;
  final bool searchMode;

  Iterable<Worker> get filteredWorkers {
    if (filters.isEmpty) {
      return workers;
    }
    if (searchMode) {
      //OR
      // return workers.where((w) =>
      //     filters.licenses.any((l) => w.licenses.contains(l))&&
      //     filters.languages.any((l) => w.languages.contains(l))&&
      //     filters.areas.any((a) => w.areas.contains(a)) &&
      //     filters.fields.any((f) => w.fields.contains(f)) &&
      //     (filters.ownCar == true ? filters.ownCar == w.ownCar : true) &&
      //     filters.periods.any((p) => w.periods.indexWhere((pw) => p.include(pw)) > -1));

      return workers.where((w) =>
      filters.licenses.toSet().intersection(w.licenses.toSet()).isNotEmpty&&
          filters.languages.toSet().intersection(w.languages.toSet()).isNotEmpty&&
          filters.areas.toSet().intersection(w.areas.toSet()).isNotEmpty&&
          filters.fields.toSet().intersection(w.fields.toSet()).isNotEmpty&&
          (filters.ownCar == true ? filters.ownCar == w.ownCar : true)&&
          filters.periods.any((p) => w.periods.indexWhere((pw) => p.include(pw)) > -1)
      );
    } else {
      //AND
      return workers.where((w) =>
          filters.licenses.every((l) => w.licenses.contains(l)) &&
          filters.languages.every((l) => w.languages.contains(l)) &&
          filters.areas.every((a) => w.areas.contains(a)) &&
          filters.fields.every((f) => w.fields.contains(f)) &&
          (filters.ownCar == true ? filters.ownCar == w.ownCar : true) &&
          filters.periods
              .every((p) => w.periods.indexWhere((pw) => p.include(pw)) > -1));
    }
  }

  GalleryState copyWith({
    GalleryStatus Function()? status,
    List<Worker> Function()? workers,
    Worker? Function()? lastDeletedWorker,
    Worker? Function()? selected,
    bool Function()? filtersIsOpen,
    List<String> Function()? allLanguages,
    List<String> Function()? allLicenses,
    List<String> Function()? allAreas,
    List<String> Function()? allFields,
    Filters Function()? filters,
    bool Function()? searchMode,
  }) {
    return GalleryState(
      status: status != null ? status() : this.status,
      workers: workers != null ? workers() : this.workers,
      lastDeletedWorker: lastDeletedWorker != null
          ? lastDeletedWorker()
          : this.lastDeletedWorker,
      selected: selected != null ? selected() : this.selected,
      filtersIsOpen:
          filtersIsOpen != null ? filtersIsOpen() : this.filtersIsOpen,
      allLanguages: allLanguages != null ? allLanguages() : this.allLanguages,
      allLicenses: allLicenses != null ? allLicenses() : this.allLicenses,
      allAreas: allAreas != null ? allAreas() : this.allAreas,
      allFields: allFields != null ? allFields() : this.allFields,
      filters: filters != null ? filters() : this.filters,
      searchMode: searchMode != null ? searchMode() : this.searchMode,
    );
  }

  @override
  List<Object?> get props => [
        status,
        workers,
        lastDeletedWorker,
        selected,
        filtersIsOpen,
        allFields,
        allLanguages,
        allLicenses,
        allAreas,
        filters,
        searchMode,
      ];
}
