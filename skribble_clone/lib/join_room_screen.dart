import 'package:flutter/material.dart';
import 'package:skribble_clone/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Join Room',style: TextStyle(color: Colors.black,fontSize: 30),),
          SizedBox(height: MediaQuery.of(context).size.height*0.08,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(controller: _nameController,hintText: 'Enter your Name',),
          ),
         const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(controller: _roomNameController,hintText: 'Enter room Name',),
          ),

          const SizedBox(height: 40,),
          ElevatedButton(onPressed: (){},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
            minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width/2.5,50)),
          ),
          child:const  Text('Join',style: TextStyle(fontSize: 16,color: Colors.white),),)
        ],
      ),
    );
  }
}
