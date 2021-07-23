
import 'package:flickrdemo/Providers/FeedProvider.dart';
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
        context.read<FeedProvider>().getFeed(context);
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    final imageData= context.watch<Imageprovider>();
    final feedData = context.watch<FeedProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Images'),
      ),
       body: RefreshIndicator(
          child: Column(
                  children: [
                  Expanded(flex: 4,
                  child: ListView.builder(
                  shrinkWrap: true,
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
          ),),
          Expanded(
          flex: 7,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            itemCount: feedData.data.length,
            itemBuilder: (context,index){
              final item = feedData.data[index];
              return Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction){
                    if(direction == DismissDirection.startToEnd){
                      context.read<FeedProvider>().remove(index);
                    }
                  },
                  child: Container(
                  padding: EdgeInsets.only(top:7),
                  margin: EdgeInsets.only(top:10,right: 15,left: 15),
                  height: 350,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black26
                      )
                    ]
                  ),
                child: Column(
                  children: [
                   Row(
                     children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(item.profile!),
                        ),
                        SizedBox(width: 10,),
                        Text(item.name!,
                        style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),
                        )
                     ],
                   ),
                   SizedBox(height: 5,),
                   Text(item.comment!,
                   style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,
                   ),
                   textAlign: TextAlign.left,
                   ),
                   SizedBox(height: 10,),
                   Container(
                     height: 180,
                     width: 300,
                     child: Image.network(item.commentphoto!,
                     fit: BoxFit.cover,
                     ),
                   )
                  ],
                ),
                ),
              );
            },
          )
          
          )
          ],
          ),
        onRefresh: ()async{
        context.read<Imageprovider>().onRefresh(mounted);
      }
      ),
    );
  }
}