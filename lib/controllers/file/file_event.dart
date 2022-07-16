part of 'file_bloc.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class UploadFile extends FileEvent {
  final File file;
  final String fileName;

  const UploadFile({required this.file, required this.fileName});
}

class UploadImage extends FileEvent {
  final File file;
  
  const UploadImage({required this.file});
}
