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