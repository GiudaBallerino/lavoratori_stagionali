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

  Iterable<Worker> get andFilteredWorkers {
    if (filters.isEmpty) {
      return workers;
    }

    return workers.where((w) =>
        filters.licenses.every((l) => w.licenses.contains(l)) &&
        filters.languages.every((l) => w.languages.contains(l)) &&
        filters.areas.every((a) => w.areas.contains(a)) &&
        filters.fields.every((f) => w.fields.contains(f)) &&
        (filters.ownCar==true ? filters.ownCar == w.ownCar : true));
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
      ];
}
