import 'package:flickrdemo/Providers/FeedProvider.dart';
import 'package:flickrdemo/Providers/ImageProvider.dart';
import 'package:flickrdemo/Ui/Imageshome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Imageprovider>(create: (context)=> Imageprovider()),
        ChangeNotifierProvider<FeedProvider>(create: (context)=>FeedProvider())
      ],
      child: MaterialApp(
      title: 'Flickr demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.green[300],
        buttonColor: Colors.green[300]
      ),
      home: ImagesHome()
    ),
    );
  }
}
