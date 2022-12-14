import 'package:firebase_storage/firebase_storage.dart';

abstract class CrudState{}

enum ProcessState{create, delete}
class LoadingState extends CrudState{}

class CrudProcess extends CrudState{
  final String message;
  final bool success;
  final ProcessState processState;

  CrudProcess(this.message, this.success,this.processState);
}
class ReadState extends CrudState{
  final List<Reference> list;

  ReadState(this.list);
}