import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqfliteCrud extends StatefulWidget {
  const SqfliteCrud({super.key});

  @override
  State<SqfliteCrud> createState() => _SqfliteCrudState();
}

class _SqfliteCrudState extends State<SqfliteCrud> {
  late Database _database;
  List<Map<String,dynamic>> datalist=[];
  var nameControler=new TextEditingController();

  Future<void> _intitDatabase() async{
    _database=await openDatabase(
        join(await getDatabasesPath(),'local_db'),
        onCreate: (db, version) {
          return db.execute('CREATE TABLE todo(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)');
        },
        version: 1
    );
    _fetchData();
  }


  Future<void> _fetchData() async{
    final List<Map<String,dynamic>> data=await _database.query('todo');
    setState(() {
      datalist=data;
    });
  }
  Future<void> update(int id,String name) async{
    await _database.update('todo', {'name':name},
        where: 'id = ?',
        whereArgs: [id]
    );
    _fetchData();
  }
  Future<void> postData(String name) async{
    await _database.insert('todo', {'name':name},
        conflictAlgorithm: ConflictAlgorithm.replace
    );
    _fetchData();
  }
  Future<void> delete(int id) async{
    await _database.delete('todo',where: 'id = ?',whereArgs: [id]);
    _fetchData();
  }
  void showButtom(BuildContext context){
    showModalBottomSheet(context: context, builder: (context) {
      return Column(
        children: [
          TextField(
            controller: nameControler,
            decoration: InputDecoration(
              labelText: 'name',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () async{
            await postData(nameControler.text.toString());
            nameControler.clear();
          }, child: Text('add'))
        ],
      );
    },);
  }
  @override
  void initState() {
    // TODO: implement initState
    _intitDatabase();
    _fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite crud'),
      ),
      floatingActionButton: ElevatedButton(onPressed: (){
        showButtom(context);
      }, child: Icon(Icons.add)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: ListView.builder(itemCount: datalist.length,itemBuilder: (context, index) {
              var updateConttroller=new TextEditingController(text: datalist[index]['name']);
              return ListTile(
                leading: CircleAvatar(child: Text(datalist[index]['id'].toString()),),
                title: Text(datalist[index]['name']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(onPressed: ()async{
                      showModalBottomSheet(context: context, builder: (context) {
                        return Column(
                          children: [
                            TextField(
                              controller: updateConttroller,
                              decoration: InputDecoration(
                                labelText: 'name',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(onPressed: () async{
                              await update(datalist[index]['id'],updateConttroller.text);
                            }, child: Text('add'))
                          ],
                        );
                      },);
                    }, icon: Icon(Icons.edit)),
                    SizedBox(width: 10,),
                    IconButton(onPressed: ()async{
                      await delete(datalist[index]['id']);
                    }, icon: Icon(Icons.delete,color: Colors.red,))
                  ],
                ),
              );
            },))
          ],
        ),
      ),
    );
  }
}
