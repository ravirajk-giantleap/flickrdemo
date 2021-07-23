import 'dart:convert';

import 'package:flickrdemo/Models/Feedmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class FeedProvider extends ChangeNotifier{

  List<FeedModel> _feedList=[];
  List<FeedModel> get data=>_feedList;

  Future<Null> getFeed(context)async{
   final raw = await rootBundle.loadString('assets/post.json');
   final data = json.decode(raw);
   var ndata = data as List;
   _feedList = ndata.map((e) => FeedModel.fromJson(e)).toList();
   notifyListeners();
   return null;
  }

  remove(int index){
    _feedList.removeAt(index);
    notifyListeners();
  }
}