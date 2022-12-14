
import 'dart:io';

abstract class CrudEvent{}

class CreateEvent extends CrudEvent{
  final File file;
  CreateEvent(this.file);
}
class ReadEvent extends CrudEvent{

  ReadEvent();
}
class DeleteEvent extends CrudEvent{
  final int index;

  DeleteEvent(this.index);
}
