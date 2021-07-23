
import 'package:flickrdemo/Models/ImageModel.dart';
import 'package:flickrdemo/Network/Apiprovider.dart';
import 'package:flutter/material.dart';

class Imageprovider extends ChangeNotifier{
final ApiProvider _apiProvider = ApiProvider();
 ImageModel? _imageModel;
List<Item> _imageList =[];
List<Item> get data=> _imageList;

Future<Null> getImages(mounted)async{
  final raw = await _apiProvider.get('photos_public.gne?tagmode=any&format=json&nojsoncallback=1&tags=biryani');
  _imageModel=  ImageModel.fromJson(raw);
  _imageList = _imageModel!.items!;
  print(_imageList);
  notifyListeners();
  return null;
}
onRefresh(mounted){
  getImages(mounted).whenComplete(() =>notifyListeners());
}
 addRatting(Item item){
     _imageList.forEach((element) {
       if(element==item){
         element.ratings=item.ratings;
       }
     });
      notifyListeners();
    }

}