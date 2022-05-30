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
  });

  final GalleryStatus status;
  final List<Worker> workers;
  final Worker? lastDeletedWorker;
  final Worker? selected;

  GalleryState copyWith({
    GalleryStatus Function()? status,
    List<Worker> Function()? workers,
    Worker? Function()? lastDeletedWorker,
    Worker? Function()? selected,
  }) {
    return GalleryState(
      status: status != null ? status() : this.status,
      workers: workers!= null ? workers() : this.workers,
      lastDeletedWorker: lastDeletedWorker!= null ? lastDeletedWorker() : this.lastDeletedWorker,
      selected: selected!= null ? selected() : this.selected,
);
  }

  @override
  List<Object?> get props => [
    status,
    workers,
    lastDeletedWorker,
    selected,
  ];
}
