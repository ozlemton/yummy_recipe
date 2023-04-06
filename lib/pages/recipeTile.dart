import 'package:flutter/material.dart';
import 'package:provider_rest_api/pages/recipeDetailScreen.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';

class RecipeTile extends StatefulWidget {
  const RecipeTile({
    Key? key,
    required this.recipeModel,
  }) : super(key: key);

  final RecipeModel recipeModel;

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  @override
  void initState() {
    RecipeDetailScreen.isFavoriteListNotifier.addListener(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(8.0),
      elevation: 2.0,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          border: Border.all(color: Colors.white),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                height: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    widget.recipeModel.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipeModel.label ?? "",
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.recipeModel.source ?? "",
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[500], //made this little brighter
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
