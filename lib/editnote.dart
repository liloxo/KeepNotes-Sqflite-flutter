import 'package:anotherapp/home.dart';
import 'package:anotherapp/sqldb.dart';
import 'package:flutter/material.dart';

class EditNote extends StatefulWidget {
  final title,note,id;
  const EditNote({Key? key, this.title, this.note, this.id}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {

  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    title.text = widget.title;
    note.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: const Text("Edit Note",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
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
                child: const Text("Edit Note",style: TextStyle(color: Colors.white,fontSize: 17),),
                onPressed: ()async{
                /*  int response = await sqlDb.updateData(''' 
                  UPDATE notes SET 
                    title = "${title.text}", 
                    note  = "${note.text}"
                    WHERE id = ${widget.id}
                  ''');*/
                  int response = await sqlDb.updateData('notes', {
                   'title' : title.text, 
                    'note'  : note.text
                  },
                  'id = ${widget.id}'
                  );
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