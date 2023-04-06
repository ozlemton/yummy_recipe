import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider_rest_api/pages/recipeDetailScreen.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';
import 'package:provider_rest_api/pages/recipeTile.dart';

import 'homePage.dart';

class FavoriteRecipeScreen extends StatefulWidget {
  FavoriteRecipeScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteRecipeScreen> createState() => _FavoriteRecipeScreenState();
}

class _FavoriteRecipeScreenState extends State<FavoriteRecipeScreen> {
List<RecipeModel> favs=[];
Map data={};
  @override
  void initState() {
    RecipeDetailScreen.isFavoriteListNotifier.addListener(() {});
    for(int i=0;i<HomePage.favList.length;i++){
      if(HomePage.favList[i].isFav==1){
        favs.add(HomePage.favList[i]);
        data[HomePage.favList[i].label]=i;
      }
    }
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Favorites ",
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: HomePage.favList.where((element) => element.isFav==1)
              .map((e) => Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (BuildContext context) async {
                              var favoriteRecipe;
                              setState(() {
                                favoriteRecipe = RecipeModel(
                                    label: e.label ?? "",
                                    isFav: 0,
                                    image: e.image.toString() ?? "image");
                                HomePage.favList.elementAt(data[e.label]).isFav=0;
                              });
                              await HomePage.updateFavRecipies(favoriteRecipe);
                            },
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: SizedBox(
                        width: 500,
                        height: 200,
                        child: RecipeTile(
                          recipeModel: e,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
