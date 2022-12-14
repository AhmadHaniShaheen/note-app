import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secand_in_firebase/bloc/events/crud_event.dart';
import 'package:secand_in_firebase/bloc/states/crud_state.dart';
import 'package:secand_in_firebase/firebase/fb_storage_controller.dart';

class ImagesBloc extends Bloc<CrudEvent,CrudState>{
  ImagesBloc(super.initialState){
    on<CreateEvent>(_onCreateEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<ReadEvent>(_onReadEvent);
  }

  List<Reference> reference=<Reference>[];
  final FbStorageController _controller=FbStorageController();

  void _onCreateEvent(CreateEvent createEvent, Emitter emitter){
    UploadTask uploadTask=_controller.createImage(file: createEvent.file);
    uploadTask.snapshotEvents.listen((event) {
      if(event.state==TaskState.success){
        reference.add(event.ref);
        emit(ReadState(reference));
        emit(CrudProcess('Image Uploaded successfully', true, ProcessState.create));
      }
        else if(event.state==TaskState.error){
        emit(CrudProcess('Image Uploaded failed', false,ProcessState.create));
      }
    });

  }

  void _onReadEvent(ReadEvent event,Emitter emitter)async{
    reference= await _controller.readImages();
    emit(ReadState(reference));
  }

  void _onDeleteEvent(DeleteEvent deleteEvent, Emitter emitter)async{
    bool deleted= await _controller.deleteImage(path: reference[deleteEvent.index].fullPath);
    if(deleted){
      reference.removeAt(deleteEvent.index);
      emit(ReadState(reference));
    }
    emit(CrudProcess(deleted? 'Deleted successfully': 'Deleted failed', false, ProcessState.delete));
  }


}