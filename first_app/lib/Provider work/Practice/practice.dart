import 'package:first_app/Provider%20work/Practice/practice_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'second_screen.dart';

class Practice extends StatelessWidget {
  const Practice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider')),
      body: SafeArea(
          child:  Consumer<PracticeProvider>(
          builder: (context, value, child) {

            var fav = value.favlist;

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(value.eligibilityMessage.toString(),
                    style: TextStyle(
                      color: (value.isEligible== true) ? Colors.green : Colors.red 
                    ),),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter your age',
                      ),
                      onChanged: (age) {
                        if(age != ""){
                          value.checkEligibility(int.parse(age));
                        }
                        
                      },
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 400,
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)
                            
                                ),
                                child: ListTile(
                                  title: Text('Book ${index}'),
                                  trailing: InkWell(
                                    onTap: () {
                                      
                                      
                                      if (!fav.contains(index)) {
                              
                                        value.addtoList(index);
                                        
                                      } else {
                                        value.removeFav(index);
                                      }
                                    },
                                    child: Icon(Icons.favorite, color: fav.contains(index)? Colors.red:Colors.grey)),
                                ),
                              ),
                            );
                          },),
                      ),
                    ),
                    
                    FloatingActionButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen()));
                    },child: Icon(Icons.favorite_border_outlined),)
                  ],
                ),
              ),
            );
          },
        ),
      ));
    
  }
}
