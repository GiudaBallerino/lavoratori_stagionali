part of 'creation_bloc.dart';

abstract class CreationEvent extends Equatable {
  const CreationEvent();

  @override
  List<Object> get props => [];
}

class WorkerSubmitted extends CreationEvent {
  const WorkerSubmitted(this.worker);

  final Worker worker;

  @override
  List<Object> get props => [worker];
}

class FirstNameChanged extends CreationEvent{
  const FirstNameChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class LastNameChanged extends CreationEvent{
  const LastNameChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class BirthdayChanged extends CreationEvent{
  const BirthdayChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class BirthplaceChanged extends CreationEvent{
  const BirthplaceChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class NationalityChanged extends CreationEvent{
  const NationalityChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];

}

class AddressChanged extends CreationEvent{
  const AddressChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class PhoneChanged extends CreationEvent{
  const PhoneChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class EmailChanged extends CreationEvent{
  const EmailChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

class LanguageAdded extends CreationEvent {
  const LanguageAdded(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}

class LanguageDeleted extends CreationEvent {
  const LanguageDeleted(this.language);

  final String language;

  @override
  List<Object> get props => [language];
}

class LicenseAdded extends CreationEvent {
  const LicenseAdded(this.license);

  final String license;

  @override
  List<Object> get props => [license];
}

class LicenseDeleted extends CreationEvent {
  const LicenseDeleted(this.license);

  final String license;

  @override
  List<Object> get props => [license];
}

class AreaAdded extends CreationEvent {
  const AreaAdded(this.area);

  final String area;

  @override
  List<Object> get props => [area];
}

class AreaDeleted extends CreationEvent {
  const AreaDeleted(this.area);

  final String area;

  @override
  List<Object> get props => [area];
}

class PeriodAdded extends CreationEvent {
  const PeriodAdded(this.start, this.end);

  final DateTime start;
  final DateTime end;

  @override
  List<Object> get props => [start,end];
}

class PeriodDeleted extends CreationEvent {
  const PeriodDeleted(this.period);

  final Period period;

  @override
  List<Object> get props => [period];
}