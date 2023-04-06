class RecipeModel {
  String? label;
  int? isFav;
  String? image;
  String? source;

  // List? ingredientsKeys;
  // List? ingredientsValues;
  String? ingredientLines;

  RecipeModel({
    this.label,
    this.isFav,
    this.image,
    this.source,
    // this.ingredientsKeys,
    //this.ingredientsValues,
    this.ingredientLines,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': label,
      'isFav': isFav,
      'image': image,
    };
  }
}
