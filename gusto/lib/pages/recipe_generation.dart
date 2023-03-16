import 'package:flutter/material.dart';

import '../models/recipe_model.dart';

class RecipeGeneration extends StatefulWidget {
  const RecipeGeneration({Key? key}) : super(key: key);

  @override
  State<RecipeGeneration> createState() => _RecipeGenerationState();
}

class _RecipeGenerationState extends State<RecipeGeneration> {
  List<RecipeModel> recipies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE9C8),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("Gusto"),
            ),
            Container(
              child: GridView(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 10.0, maxCrossAxisExtent: 200.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  children: List.generate(recipies.length, (index) {
                    return GridTile(
                        child: RecipeTile(
                          title: recipies[index].title,
                          ingredients: recipies[index].ingredients,
                          instructions: recipies[index].instructions,
                          image_name: recipies[index].image_name,
                        ));
                  })),
            ),
          ],
        ),
      )
    );
  }
}

class RecipeTile extends StatefulWidget {
  final String title, ingredients, instructions, image_name;
  const RecipeTile({Key? key, required this.title, required this.ingredients, required this.instructions, required this.image_name}) : super(key: key);

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}



