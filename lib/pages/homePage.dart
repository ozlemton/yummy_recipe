import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:provider_rest_api/pages/recipeDetailScreen.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';
import 'package:provider_rest_api/pages/recipeTile.dart';
import 'package:provider_rest_api/providers/recipe_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'recipeFavoritesScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static var database;
  static late List<RecipeModel> favList;
  static late RecipeProvider recipeProvider;

  static Future<void> insertFav(RecipeModel favRecipies) async {
    final db = await HomePage.database;
    await db.insert(
      'favs',
      favRecipies.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<RecipeModel>> favRecipies() async {
    final db = await HomePage.database;
    final List<Map<String, dynamic>> favList = await db.query('favs');
    return List.generate(favList.length, (i) {
      return RecipeModel(
        label: favList[i]['name'],
        isFav: favList[i]['isFav'],
        image: favList[i]["image"],
      );
    });
  }

  static Future<RecipeModel> favRecipe(int index) async {
    print(index);

    final db = await HomePage.database;
    final List<Map<String, dynamic>> favList = await db.query('favs');
    return RecipeModel(
      label: favList[index]['name'],
      isFav: favList[index]['isFav'],
    );
  }

  static Future<void> updateFavRecipies(RecipeModel favRecipies) async {
    final db = await HomePage.database;
    await db.update(
      'favs',
      favRecipies.toMap(),
      //where: 'name = ? ',
      //whereArgs: [favRecipies.label],
    );
    HomePage.favList
        .map((e) => e.label == favRecipies.label ? e.isFav = favRecipies.isFav : e.isFav = 0);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RecipeModel> recipeList = [];

  @override
  void initState() {
    final provider = Provider.of<RecipeProvider>(context, listen: false);
    provider.getDataFromAPI();
   // RecipeDetailScreen.isFavoriteListNotifier.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yummy Recipes'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? getLoadingUI()
          : provider.error.isNotEmpty
              ? getErrorUI(provider.error)
              : getBodyUI(),
    );
  }

  Widget getLoadingUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SpinKitFadingCircle(
            color: Colors.blue,
            size: 80,
          ),
          Text(
            'Loading...',
            style: TextStyle(fontSize: 20, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget getErrorUI(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red, fontSize: 22),
      ),
    );
  }

  Widget getBodyUI() {
    HomePage.recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    HomePage.favList = HomePage.recipeProvider.recipeList
        .map((e) => RecipeModel(label: e.label, isFav: 0, image: e.image))
        .toList();
    HomePage.favList.map((e) async => await HomePage.insertFav(e));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              HomePage.recipeProvider.search(value);
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer(
            builder: (context, RecipeProvider recipesProvider, child) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FavoriteRecipeScreen(),
                ));
              },
              child: Row(
                children: const [
                  Icon(Icons.favorite),
                  Text("Visit Your Favorite Recipes",
                      style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8, top: 20, bottom: 20),
          child: Text("All Yummy Recipes",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
        ),
        Expanded(
          child: Consumer(
              builder: (context, RecipeProvider recipesProvider, child) => GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(recipesProvider.recipeList.length, (index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RecipeDetailScreen(
                                  recipeModel: recipesProvider.recipeList[index],
                                  index: index,
                                ),
                              ));
                            },
                            child: RecipeTile(
                              recipeModel: recipesProvider.recipeList[index],
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
        ),
      ],
    );
  }
}
