import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddBucketList extends StatefulWidget {
  int newIndex;
  AddBucketList({super.key, required this.newIndex});

  @override
  State<AddBucketList> createState() => _AddBucketListState();
}

class _AddBucketListState extends State<AddBucketList> {
  TextEditingController itemText = TextEditingController();
  TextEditingController costText = TextEditingController();
  TextEditingController imageURLText = TextEditingController();
  Future<void> addData() async {
    try {
      Map<String, dynamic> data = {
        "completed": false,
        "item": itemText.text,
        "cost": costText.text,
        "image": imageURLText.text
      };
      Response response = await Dio().patch(
          'https://flutterapitest123-e4604-default-rtdb.firebaseio.com/bucketlist/${widget.newIndex}.json',
          data: data);
      Navigator.pop(context, 'refresh');
    } catch (e) {
      print('Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Bucket List'),
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: addForm,
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value.toString().length<3) {
                        return '*Must be more than 3 characters!';
                      }
                      if(value == null || value.isEmpty) {
                        return '*This must not be empty';
                      }
                    },
                    controller: itemText,
                    decoration: const InputDecoration(
                      label: Text('Item'),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value.toString().length<3) {
                        return '*Must be more than 3 characters!';
                      }
                      if(value == null || value.isEmpty) {
                        return '*This must not be empty';
                      }
                    },
                    controller: costText,
                    decoration: const InputDecoration(
                        label: Text('Estimated Cost')
                    ),
                  ),
                  const SizedBox(height: 30,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if(value.toString().length<3) {
                        return '*Must be more than 3 characters!';
                      }
                      if(value == null || value.isEmpty) {
                        return '*This must not be empty';
                      }
                    },
                    controller: imageURLText,
                    decoration: const InputDecoration(
                        label: Text('Image URL')
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if(addForm.currentState!.validate()) {
                                addData();
                              }
                            },
                            child: const Text('Add Data')
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}
