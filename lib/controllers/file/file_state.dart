part of 'file_bloc.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object> get props => [];
}

class FileInitial extends FileState {}

class FileUploading extends FileState {}

class FileUploaded extends FileState {
  final String url;
  const FileUploaded({required this.url});

  @override
  List<Object> get props => [url];
}

class FileFaliure extends FileState {
  final String message;
  const FileFaliure({required this.message});

  @override
  List<Object> get props => [message];
}
