import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_rest_api/pages/homePage.dart';
import 'package:provider_rest_api/pages/recipeIngredientTile.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';

class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen({Key? key, required this.index, required this.recipeModel}) : super(key: key);
  final RecipeModel recipeModel;
  int index;

  static List<RecipeModel> isFavoriteList = [];
  static ValueNotifier<int> isFavoriteListNotifier = ValueNotifier<int>(0);

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  @override
  void initState() {
    RecipeDetailScreen.isFavoriteListNotifier.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.recipeModel.label ?? "",
          maxLines: 1,
          softWrap: false,
          overflow: TextOverflow.fade,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0.0),
                  topRight: Radius.circular(0.0),
                ),
                child: Image.network(
                  widget.recipeModel.image ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      int isFav = 0;
                      var favoriteRecipe;
                      setState(() {
                        isFav = HomePage.favList.elementAt(widget.index).isFav ?? 0;
                        isFav = (isFav == 1 ? 0 : 1);
                        HomePage.favList.elementAt(widget.index).isFav = isFav;
                        favoriteRecipe = RecipeModel(
                            label: widget.recipeModel.label ?? "",
                            isFav: HomePage.favList.elementAt(widget.index).isFav,
                            image: widget.recipeModel.image.toString() ?? "image");
                      });
                      await HomePage.updateFavRecipies(favoriteRecipe);
                    },
                    icon: HomePage.favList.elementAt(widget.index).isFav == 1
                        ? const Icon(Icons.favorite)
                        : const Icon(Icons.favorite_border)),
                Flexible(
                  child: Text(
                    widget.recipeModel.label ?? "",
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Ingredients and Instructions ",
                maxLines: 50,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[800], //made this little brighter
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.recipeModel.ingredientLines.toString(),
                maxLines: 50,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[800], //made this little brighter
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            // RecipeIngredientTile(recipeModel: widget.recipeModel)
          ],
        ),
      ),
    );
  }
}
