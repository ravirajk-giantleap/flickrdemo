
import 'package:flickrdemo/Providers/ImageProvider.dart';
import 'package:flickrdemo/Ui/DetailsView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImagesHome extends StatefulWidget {
  const ImagesHome({ Key? key }) : super(key: key);

  @override
  _ImagesHomeState createState() => _ImagesHomeState();
}

class _ImagesHomeState extends State<ImagesHome> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration.zero,(){
        context.read<Imageprovider>().getImages(mounted);
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final imageData= context.watch<Imageprovider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
       body: RefreshIndicator(
      child: ListView(
        children: [
        Container(
        height: 300,
        child: ListView.builder(
          shrinkWrap: true,
          primary: true,
          //physics: ScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: imageData.data.length,
          itemBuilder: (context ,i){
            return Container(
              height: 300,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(7),
              child: GestureDetector(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: 
                  (context)=>DetailsView(item: imageData.data[i],))),
                  child: Column(
                  children: [
                   Container(
                        height: 200,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(imageData.data[i].media!.m!),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    Text(imageData.data[i].title!),
                    imageData.data[i].ratings!=null? 
                    Text("Rated:-\t"+imageData.data[i].ratings.toString()
                    +'\tprovided by:'+imageData.data[i].name.toString())
                    :Container()
                  ],
                ),
              ),
            );
          },
      ),
        ),
      SizedBox(
        height: 10,
      ),
      ListView.builder(
        itemBuilder: (BuildContext context,int index){
          return Container();
        },
      )

      ],
      ),
       
      onRefresh: ()async{
        context.read<Imageprovider>().onRefresh(mounted);
      }),
    );
  }
}