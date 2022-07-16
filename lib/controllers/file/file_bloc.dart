import 'dart:io';

import 'package:admin/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final UploadFileService _uploadFileService;

  FileBloc()
      : _uploadFileService = UploadFileService(),
        super(FileInitial()) {
    on<UploadFile>(_onUploadFile);
    on<UploadImage>(_onUploadImage);
  }

  Future<void> _onUploadFile(
    UploadFile event,
    Emitter<FileState> emit,
  ) async {
    emit(FileUploading());
    String? url = await _uploadFileService.uploadFile(
      event.file,
      event.fileName,
    );
    if (url == null) {
      emit(const FileFaliure(message: 'Failed to upload file'));
    } else {
      emit(FileUploaded(url: url));
    }
  }

  Future<void> _onUploadImage(
    UploadImage event,
    Emitter<FileState> emit,
  ) async {
    emit(FileUploading());
    String? url = await _uploadFileService.uploadImage(event.file);
    if (url == null) {
      emit(const FileFaliure(message: 'Failed to upload file'));
    } else {
      emit(FileUploaded(url: url));
    }
  }
}
