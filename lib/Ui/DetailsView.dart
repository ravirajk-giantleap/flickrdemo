
import 'package:flickrdemo/Models/ImageModel.dart';
import 'package:flickrdemo/Providers/ImageProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:provider/provider.dart';

class DetailsView extends StatefulWidget {
  final Item item;
  const DetailsView({ required this.item,Key? key }) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _scaffoldKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  var rating=0.0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Column(
          children: [
             Container(
                height: MediaQuery.of(context).size.height/2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.item.media!.m!),
                    fit: BoxFit.cover
                  )
                ),
              ),
            SizedBox(
              height: 10,
            ),
            Text(widget.item.title!),
            SizedBox(
             height: 5,
           ),
           // Text('description:'+widget.item!.description!),
           Text('Rate this Image',
           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
           ),
           SizedBox(
             height: 5,
           ),
           //Submit Form
           Form(
             key: _formKey,
            child: 
           Column(
             children: [
             Container(
               height: 50,
               width: MediaQuery.of(context).size.width*0.8,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black26,
                     blurRadius: 8
                   )
                 ]
               ),
               child: TextFormField(
                 validator: (value){
                   if(value!.isEmpty){
                     return 'Name cant be Empty';
                   }if(value is int){
                     return 'This is not name';
                   }
                 },
                 controller: _nameController,
                 decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                  hintStyle:
                  TextStyle(color: Colors.grey)),
                  
               ),
             ),
             SizedBox(height:10),
             RatingStars(
              value: rating,
              onValueChanged: (v) {
               setState(() {
                 rating=v;
               });
              },
              starBuilder: (index, color) => Icon(
                Icons.favorite_outline_sharp,
                color: color,
              ),
              starCount: 5,
              starSize: 40,
              valueLabelColor: const Color(0xff9b9b9b),
              valueLabelTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                  fontSize: 12.0),
              valueLabelRadius: 10,
              maxValue: 5,
              starSpacing: 1,
              maxValueVisibility: true,
              valueLabelVisibility: true,
              animationDuration: Duration(milliseconds: 1000),
              valueLabelPadding:
                  const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
              valueLabelMargin: const EdgeInsets.only(right: 8),
              starOffColor: const Color(0xffe7e8ea),
              starColor: Colors.yellow,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
               height: 50,
               width: MediaQuery.of(context).size.width*0.8,
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black26,
                     blurRadius: 8
                   )
                 ]
               ),
               child: TextFormField(
                 validator: (value){
                   if(value!.isEmpty){
                     return 'Please justify your reason';
                   }if(value is int){
                     return 'Please add reason';
                   }
                 },
                 controller: _reasonController,
                 decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Reason",
                  hintStyle:
                  TextStyle(color: Colors.grey)),
                  
               ),
             ),
            ],
           )),
           SizedBox(
             height: 10,
           ),
           Container(
            height: 50,
            width: MediaQuery.of(context).size.width*0.6,
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
           
            Color.fromRGBO(143, 148, 251, 1),
            Color.fromRGBO(143, 148, 251, .6),
            ])),
            child: InkWell(
            onTap: () {
            if(_formKey.currentState!.validate()){
              if(rating !=0.0){
              widget.item.ratings=rating;
              widget.item.name=_nameController.text;
              widget.item.reason= _reasonController.text;
              context.read<Imageprovider>().addRatting(widget.item);
              Future.delayed(
                Duration(milliseconds: 700),(){
                  Navigator.pop(context);
                }
              );
              }else{
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('One more step:- Please Rate image'),
                ),
              );
            }
            }
            },
            child: Center(
            child: Text(
            "Submit",
            style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold),
            ),
            ),
            )),
          
          ],
        ),
      )
    );
  }
}