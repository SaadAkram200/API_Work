import 'package:first_app/widgets/reuseable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ToDoWithHive extends StatefulWidget {
  const ToDoWithHive({super.key});

  @override
  State<ToDoWithHive> createState() => _ToDoWithHiveState();
}

class _ToDoWithHiveState extends State<ToDoWithHive> {
  // reference of box
  final mybox = Hive.box("testbox");

  // add data in box
  addData(data) {
    mybox.add(data);
    controller.clear();
    print("Added: $data");
    setState(() {});
  }

  // delete data from box
  deleteData(int index) {
    if (mybox.getAt(index) != null) {
      mybox.deleteAt(index);
      print("Deleted item at index $index");
    }
    setState(() {});
  }

  //delete comformation
  confirmDeleteDialog(index) {
    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            deleteData(index);
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text("Delete"),
        ),
      ],
    );
  }

  Widget todoTile(index) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red[100],
        borderRadius: BorderRadius.circular(12),
      ),
      foregroundDecoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        iconColor: Colors.red,
        trailing: IconButton(
          onPressed: () {
            // Show a confirmation dialog before deleting
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return confirmDeleteDialog(index);
              },
            );
          },
          icon: Icon(Icons.delete),
        ),
        title: Text(mybox.getAt(index)?.toString() ?? ''),
      ),
    );
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mybox.length,
                itemBuilder: (context, index) {
                  return todoTile(index);
                },
              ),
            ),
            reusableTextFields(
              controller: controller,
              fieldName: "To Do",
              obscureText: false,
              icon: Icons.data_array,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () => addData(controller.text),
              child: Text(
                "Add",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
