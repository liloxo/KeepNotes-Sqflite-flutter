import 'package:anotherapp/home.dart';
import 'package:anotherapp/sqldb.dart';
import 'package:flutter/material.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const Text("Add Note",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
      ),
      body: Form(
        key: formkey,
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10),
              child: textformfield("Enter a title",title )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: textformfield("Enter a note",note )
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: MaterialButton(
                color: Colors.blueGrey,
                child: const Text("Add Note",style: TextStyle(color: Colors.white,fontSize: 17),),
                onPressed: ()async{
                  /*int response = await sqlDb.insertData(''' 
                  INSERT INTO notes (`title`, `note`) VALUES ("${title.text}", "${note.text}")
                  ''');*/
                  int response = await sqlDb.insertData('notes', {
                    'title' : title.text,
                    'note'  : note.text
                  });
                  if(response > 0 ){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const Home()), (route) => false);
                  }else{
                    print("failed");
                  }
                }
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget textformfield(String hintxt,TextEditingController controller){
    return TextFormField(
       controller: controller,
         decoration: InputDecoration(
           hintText: hintxt,
           prefixIcon: const Icon(Icons.note,color: Colors.blueGrey,),
           enabledBorder: OutlineInputBorder(
             borderSide: const BorderSide(
               width: 1,
               color: Colors.blueGrey
             ),
             borderRadius: BorderRadius.circular(13)
           ),
           focusedBorder: OutlineInputBorder(
             borderSide: const BorderSide(
               color: Colors.blueGrey
             ),
             borderRadius: BorderRadius.circular(13)
           ),
         ),
            );
  }
}