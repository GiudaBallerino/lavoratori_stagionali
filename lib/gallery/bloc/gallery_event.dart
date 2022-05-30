part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class WorkersSubscriptionRequested extends GalleryEvent {
  const WorkersSubscriptionRequested();
}

class WorkerDeleted extends GalleryEvent {
  const WorkerDeleted(this.worker);

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

class WorkerUndoDeletionRequested extends GalleryEvent {
  const WorkerUndoDeletionRequested();
}

class WorkerSelection extends GalleryEvent {
  const WorkerSelection(this.selection);

  final Worker selection;

  @override
  List<Object> get props => [selection];
}