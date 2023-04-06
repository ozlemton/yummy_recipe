import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider_rest_api/pages/recipe.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../pages/homePage.dart';

class RecipeProvider extends ChangeNotifier {
  bool isLoading = true;
  String error = '';
  String searchText = '';

  List<RecipeModel> recipeList = [];
  List<RecipeModel> recipes = [];

  getDataFromAPI() async {
    try {
      const String apiEndpoint =
          'https://api.edamam.com/search?q=dishes&app_id=5e4d0fd4&app_key=db9d32fda18668ca64cf3f6105b84b80&from=0&to=20&calories=750';
      final Uri url = Uri.parse(apiEndpoint);
      final response = await http.post(url);
      var jsonData = jsonDecode(response.body);
      if (jsonData['more'] == true) {
        jsonData['hits'].forEach((element) {
          if (element['recipe']['url'] != null &&
              element['recipe']['image'] != null &&
              element['recipe']['ingredientLines'] != null) {
            RecipeModel recipeModel = RecipeModel(
              label: element['recipe']['label'],
              image: element['recipe']['image'],
              source: element['recipe']['source'],
              ingredientLines: element['recipe']['ingredientLines']
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', ''),
              // ingredientsKeys: element['recipe']['ingredients'].map((e) => e.keys).toList(),
              //ingredientsValues: element['recipe']['ingredients'].map((e) => e.values).toList(),
            );
            recipes.add(recipeModel);
          }
        });
      }
    } catch (err) {}
    isLoading = false;
    updateData();
  }

  updateData() {
    recipeList.clear();
    if (searchText.isEmpty) {
      recipeList.addAll(recipes);
    } else {
      recipeList.addAll(recipes
          .where((element) => (element.label?.toLowerCase().startsWith(searchText) ?? true)|| (element.ingredientLines?.toLowerCase().contains(searchText) ??true))
          .toList());
    }
    notifyListeners();
  }

  search(String username) {
    searchText = username;
    updateData();
  }
}
