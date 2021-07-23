import 'package:flickrdemo/Models/Feedmodel.dart';
import 'package:flutter/material.dart';

class FeedProvider extends ChangeNotifier{

  List<FeedModel> _feedModel=[];
  List<FeedModel> get data=>_feedModel;

  Future<Null> getFeed(context)async{
    final raw = await DefaultAssetBundle.of(context).loadString('local.json');
    _feedModel =  feedModelFromJson(raw);
    notifyListeners();
  }

}