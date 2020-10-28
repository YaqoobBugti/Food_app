import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/provider/categories_provider.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/provider/myProvider.dart';
import 'package:food_ordering/screens/home_page.dart';
import 'package:food_ordering/screens/sign_up_page.dart';
import 'package:food_ordering/screens/welcome_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoriesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => MoreCategoriesProfiver(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.green,
          accentColor: Colors.white,
        ),
        home: StreamBuilder(stream: FirebaseAuth.instance.userChanges(),
          builder: (contex,userSnapshot){
              if(userSnapshot.hasData){
                return HomePage();
              }
              return WelcomePage();
          },
        )
      ),
    );
  }
}
