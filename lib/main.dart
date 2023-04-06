import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_rest_api/pages/homePage.dart';
import 'package:provider_rest_api/pages/recipeModel.dart';
import 'package:provider_rest_api/providers/recipe_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomePage.database = openDatabase(
    join(await getDatabasesPath(), 'recipes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE favs(name TEXT, isfav INTEGER, image TEXT)',
      );
    },
    version: 1,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> insertFav(RecipeModel favRecipies) async {
    final db = await HomePage.database;
    await db.insert(
      'favs',
      favRecipies.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeProvider(),
      child: MaterialApp(
        title: 'Recipies',
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
