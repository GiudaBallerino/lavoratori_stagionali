part of 'gallery_bloc.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();

  @override
  List<Object> get props => [];
}

class WorkersSubscriptionRequested extends GalleryEvent {
  const WorkersSubscriptionRequested();
}

class LanguagesSubscriptionRequested extends GalleryEvent {
  const LanguagesSubscriptionRequested();
}

class LicensesSubscriptionRequested extends GalleryEvent {
  const LicensesSubscriptionRequested();
}

class AreasSubscriptionRequested extends GalleryEvent {
  const AreasSubscriptionRequested();
}

class FieldsSubscriptionRequested extends GalleryEvent {
  const FieldsSubscriptionRequested();
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

class OpenFilters extends GalleryEvent {
  const OpenFilters();
}

class AddLanguages extends GalleryEvent {
  const AddLanguages(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}

class AddLicenses extends GalleryEvent {
  const AddLicenses(this.license);

  final String license;

  @override
  List<Object> get props => [license];
}

class AddAreas extends GalleryEvent {
  const AddAreas(this.area);

  final String area;

  @override
  List<Object> get props => [area];
}

class AddFields extends GalleryEvent {
  const AddFields(this.field);

  final String field;

  @override
  List<Object> get props => [field];
}

class AddPeriods extends GalleryEvent {
  const AddPeriods(this.period);

  final Period period;

  @override
  List<Object> get props => [period];
}

class RemoveLanguages extends GalleryEvent {
  const RemoveLanguages(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}

class RemoveLicenses extends GalleryEvent {
  const RemoveLicenses(this.license);

  final String license;

  @override
  List<Object> get props => [license];
}

class RemoveAreas extends GalleryEvent {
  const RemoveAreas(this.area);

  final String area;

  @override
  List<Object> get props => [area];
}

class RemoveFields extends GalleryEvent {
  const RemoveFields(this.field);

  final String field;

  @override
  List<Object> get props => [field];
}

class RemovePeriods extends GalleryEvent {
  const RemovePeriods(this.period);

  final Period period;

  @override
  List<Object> get props => [period];
}

class OwnCarChange extends GalleryEvent{
  const OwnCarChange();
}

class ChangeSearchMode extends GalleryEvent{
  const ChangeSearchMode();
}
