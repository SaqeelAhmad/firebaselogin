import 'package:flutter/material.dart';




class CoustomButton extends StatefulWidget {
   CoustomButton({Key? key,required this.title,required this.onTap,required this. isLoading}) : super(key: key);
final onTap ;
String title;
bool isLoading = false ;

  @override
  State<CoustomButton> createState() => _CoustomButtonState();
}

class _CoustomButtonState extends State<CoustomButton> {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1,color: Colors.black38)
          ),
          child: Center(child: widget.isLoading ?  CircularProgressIndicator(color: Colors.white,strokeWidth: 10,
          ):Text( widget.title,style: const TextStyle(color: Colors.white,fontSize: 20)
            ,)),
        ),
      ),
    );
  }
}
