import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
      }
  }

intialDb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'mir.db') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 5  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

_onUpgrade(Database db , int oldversion , int newversion ) {

 print("onUpgrade =====================================") ; 
}

_onCreate(Database db , int version) async {
  await db.execute('''
  CREATE TABLE "notes" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "title" TEXT NOT NULL,
    "note" TEXT NOT NULL
  )
 ''') ;
 print(" onCreate =====================================") ; 
}

readData(String table) async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.query(table);
  return response ; 
}
insertData(String table,Map<String, Object?> values) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.insert(table,values);
  return response ; 
}
updateData(String table,Map<String, Object?> values,String mywhere) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.update(table,values,where: mywhere);
  return response ; 
}
deleteData(String table,String mywhere) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.delete(table,where: mywhere);
  return response ; 
}
mydeletedb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'mir.db') ;    
  await deleteDatabase(path);
}

}