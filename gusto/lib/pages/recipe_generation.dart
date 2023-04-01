import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gusto/pages/recipe_detail_page.dart';
import 'package:http/http.dart' as http;
import '../models/content_model.dart';

class RecipeGeneration extends StatefulWidget {
  const RecipeGeneration({Key? key}) : super(key: key);

  @override
  State<RecipeGeneration> createState() => _RecipeGenerationState();
}

class _RecipeGenerationState extends State<RecipeGeneration> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<ContentModel> content = [];

  Future<void> getRecipes() async {
    try {
      var url = 'http://10.0.2.2:8001/recipes';

      Map data = {
        "ingredients": ["chicken", "rice"]
      };

      // encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        var jsonData = jsonDecode(response.body) as List<dynamic>;
        content = jsonData.map((item) {
          return ContentModel(
            title: item['title'],
            image_name: item['image_name'],
          );
        }).toList();

        for (var item in jsonData) {
          if (kDebugMode) {
            print('Title: ${item['title']}');
          }
          if (kDebugMode) {
            print('Image Name: ${item['image_name']}');
          }
        }

        setState(() {}); // Update the state of the widget
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<String> _getImage(String imageName) async {
    if (kDebugMode) {
      print('$imageName.jpg');
    }
    final ref = _storage.ref().child('$imageName.jpg');
    return await ref.getDownloadURL().catchError((error) {
      if (kDebugMode) {
        print('Error getting download URL: $error');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFE9C8),
        body: content.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.fromLTRB(5.0, 60.0, 5.0, 0.0),
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: content.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeDetailPage(
                              title: content[index].title,
                            ),
                          ),
                        );
                      },
                      child: GridTile(
                        footer: GridTileBar(
                          backgroundColor: Colors.black45,
                          title: Text(
                            content[index].title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        child: FutureBuilder(
                          future: _getImage(content[index].image_name),
                          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                final imageUrl = snapshot.data;
                                if (imageUrl != null) {
                                  return Center(
                                    child: Image.network(imageUrl),
                                  );
                                } else {
                                  return const Text('Image not found');
                                }
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}

