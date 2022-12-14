class Note{
  late String title;
  late String info;
  late String path;
  Note();


  Note.formMap(Map<String,dynamic>map){
    title=map['title'];
    info=map['info'];
  }
  Map<String,dynamic> toMap(){
    Map<String,dynamic>map=<String,dynamic>{};
    map['title']=title;
    map['info']=info;
    return map;
  }
}