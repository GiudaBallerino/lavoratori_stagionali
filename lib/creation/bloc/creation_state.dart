part of 'creation_bloc.dart';


enum CreationStatus { initial, loading, success, failure }

extension CreationStatusX on CreationStatus {
  bool get isLoadingOrSuccess => [
    CreationStatus.loading,
    CreationStatus.success,
  ].contains(this);
}

class CreationState extends Equatable {
  const CreationState({
    this.status = CreationStatus.initial,
  });

  final CreationStatus status;


  CreationState copyWith({
    CreationStatus Function()? status,
  }) {
    return CreationState(
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object?> get props => [status,];
}