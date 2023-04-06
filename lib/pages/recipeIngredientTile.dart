import 'package:flutter/material.dart';
import 'package:provider_rest_api/pages/recipeDetailScreen.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';

class RecipeIngredientTile extends StatefulWidget {
  RecipeIngredientTile({Key? key, required this.recipeModel, required this.index})
      : super(key: key);
  late RecipeModel recipeModel;
  late int index;

  @override
  State<RecipeIngredientTile> createState() => _RecipeIngredientTileState();
}

class _RecipeIngredientTileState extends State<RecipeIngredientTile> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
/*
          Row(
            children: [
              Flexible(
                child: Text(
                  "quantity: "+(widget.recipeModel.ingredientsValues?.elementAt(widget.index).elementAt(1)??"").toString(),
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "measure: "+(widget.recipeModel.ingredientsValues?.elementAt(0).elementAt(2)??"").toString(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "food: "+(widget.recipeModel.ingredientsValues?.elementAt(0).elementAt(3)??"").toString(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "weight: "+(widget.recipeModel.ingredientsValues?.elementAt(0).elementAt(4)??"").toString(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  "foodCategory: "+(widget.recipeModel.ingredientsValues?.elementAt(0).elementAt(5)??"").toString(),
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                ),
              ),
            ],
          ),
          */
        ],
      ),
    );
  }
}
//String values2=widget.recipeModel.ingredientsValues?.elementAt(0).toString().replaceAll('(', '').replaceAll(')','')??"";//.split(",")??[];
//String values3=widget.recipeModel.ingredientsValues?.elementAt(0).elementAt(0);
