import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering/screens/cart_page.dart';
import 'package:food_ordering/screens/send_mail.dart';
import 'package:food_ordering/modle/categories_modle.dart';
import 'package:food_ordering/modle/more_categories_modle.dart';
import 'package:food_ordering/modle/single_food_modle.dart';
import 'package:food_ordering/modle/user_modle.dart';
import 'package:food_ordering/provider/categories_provider.dart';
import 'package:food_ordering/provider/more_categories_provider.dart';
import 'package:food_ordering/provider/myProvider.dart';
import 'package:food_ordering/screens/categories_page.dart';
import 'package:food_ordering/screens/detail_page.dart';
import 'package:food_ordering/screens/profile_page.dart';
import 'package:food_ordering/screens/search.dart';
import 'package:food_ordering/screens/welcome_page.dart';
import 'package:food_ordering/widgets/single_food.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoriesModle> addBurgerList = [];
  List<CategoriesModle> addJapaneseList = [];
  List<CategoriesModle> addNoodlesList = [];
  List<CategoriesModle> addRamenList = [];
  List<CategoriesModle> addSandWichesList = [];
  //////////single food list//////////////
  List<SingleFoodModle> addSingleFoodList = [];
  ///////////////////////////////////////
  List<MoreCategoriesModle> addBurgerCategoriesList = [];
  List<MoreCategoriesModle> addJapaneseCategoriesList = [];
  List<MoreCategoriesModle> addNoodlesCategoriesList = [];
  List<MoreCategoriesModle> addRamenCategoriesList = [];
  List<MoreCategoriesModle> addSandWichesCategoriesList = [];
  /////////////////////////////////////////////////////

  UserModle currentUsers;

  Widget foodCategories({
    @required String name,
    @required String image,
    @required Function onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              backgroundImage: NetworkImage(image),
            ),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerContainer({
    @required context,
    @required String tittle,
    @required IconData icon,
    @required Color color,
    @required Function onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        title: Text(
          tittle,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  Widget drawerCalling() {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              accountName: Text(
                currentUsers.firstName,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                currentUsers.emailAddress,
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {},
                child: CircleAvatar(
                    //backgroundImage: NetworkImage(currentUsers.userImage),
                    ),
              ),
            ),
            drawerContainer(
              icon: Icons.home,
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              tittle: 'HomePage',
              context: context,
            ),
            drawerContainer(
              color: Colors.blue,
              icon: Icons.shopping_cart,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              tittle: 'Cart Screen',
              context: context,
            ),
            drawerContainer(
              color: Colors.blue,
              icon: Icons.person,
              tittle: 'Profile',
              context: context,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      currentUsers: currentUsers,
                    ),
                  ),
                );
              },
            ),
            drawerContainer(
              color: Colors.blue,
              icon: Icons.help,
              onTap: () {},
              tittle: 'About',
              context: context,
            ),
            drawerContainer(
              color: Colors.blue,
              icon: Icons.mail,
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SendMail(),
                  ),
                );
              },
              tittle: 'SendMail',
              context: context,
            ),
            drawerContainer(
              color: Colors.blue,
              icon: Icons.exit_to_app,
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ),
                );
              },
              tittle: 'Logout',
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      title: Text(
        "Home",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          onPressed: () {
            showSearch(
              context: context,
              delegate: Search(),
            );
          },
        ),
      ],
      elevation: 01.1,
      backgroundColor: Theme.of(context).accentColor,
    );
  }

  Widget japaneseItemFunction() {
    return Row(
        children: addJapaneseList
            .map(
              (e) => foodCategories(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                        list: addJapaneseCategoriesList,
                      ),
                    ),
                  );
                },
                name: e.name,
                image: e.image,
              ),
            )
            .toList());
  }

  Widget burgetItemFunction() {
    return Row(
        children: addBurgerList
            .map(
              (e) => foodCategories(
                onTap: () {
        
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                        list: addNoodlesCategoriesList,
                      ),
                    ),
                  );
                },
                name: e.name,
                image: e.image,
              ),
            )
            .toList());
  }

  Widget noodlesItemFunction() {
    return Row(
        children: addNoodlesList
            .map(
              (e) => foodCategories(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                        list: addNoodlesCategoriesList,
                      ),
                    ),
                  );
                },
                name: e.name,
                image: e.image,
              ),
            )
            .toList());
  }

  Widget ramenItemFunction() {
    return Row(
        children: addRamenList
            .map(
              (e) => foodCategories(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                        list: addRamenCategoriesList,
                      ),
                    ),
                  );
                },
                name: e.name,
                image: e.image,
              ),
            )
            .toList());
  }

  Widget sandWichesItemFunction() {
    return Row(
        children: addSandWichesList
            .map(
              (e) => foodCategories(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => CategoriesPage(
                        list: addSandWichesCategoriesList,
                      ),
                    ),
                  );
                },
                name: e.name,
                image: e.image,
              ),
            )
            .toList());
  }

  Widget singleFoodFunction() {
    return Column(
        children: addSingleFoodList
            .map(
              (e) => SingleFood(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        image: e.image,
                        price: e.price,
                        name: e.name,
                      ),
                    ),
                  );
                },
                image: e.image,
                name: e.name,
                price: e.price,
              ),
            )
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    ///////////// geting drawer things /////////////
    MyProvider myProvider = Provider.of<MyProvider>(context);
    myProvider.getUserData();
    currentUsers = myProvider.throwUserData;
    ///////////////////// geted drawer thing/////////////////////

    ///////////////////  categories object/////////////////////

    CategoriesProvider categoriesProvider =
        Provider.of<CategoriesProvider>(context);
    categoriesProvider.getBurgerItem();
    categoriesProvider.getJapaneseItem();
    categoriesProvider.getNoodlesItem();
    categoriesProvider.getRamenItem();
    categoriesProvider.getSandWichesItem();

    addBurgerList = categoriesProvider.throwBurgetItem;
    addJapaneseList = categoriesProvider.throwJapaneseItem;
    addNoodlesList = categoriesProvider.throwNoodlesItem;
    addRamenList = categoriesProvider.throwRamenItem;
    addSandWichesList = categoriesProvider.throwSandWichesItem;

    /////////////////single food object /////////////////

    myProvider.getSingleFood();
    addSingleFoodList = myProvider.throwSingleFoodList;

    ///////////////////////////////////////////////////////////
    MoreCategoriesProfiver moreCategoriesProfiver =
        Provider.of<MoreCategoriesProfiver>(context);

    moreCategoriesProfiver.getBurgerCategories();
    moreCategoriesProfiver.getJapaneseCategories();
    moreCategoriesProfiver.getNoodlesCategories();
    moreCategoriesProfiver.getRamenCategories();
    moreCategoriesProfiver.getSandWichesCategories();
    addJapaneseCategoriesList =
        moreCategoriesProfiver.throwJapaneseCategoriesList;
    addBurgerCategoriesList = moreCategoriesProfiver.throwBurgerCategoriesList;
    addNoodlesCategoriesList =
        moreCategoriesProfiver.throwNoodlesCategoriesList;
    addRamenCategoriesList = moreCategoriesProfiver.throwRamenCategoriesList;
    addSandWichesCategoriesList =
        moreCategoriesProfiver.throwSandWichesCategoriesList;
    ////////////////////// geted categories object//////////////
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      drawer: drawerCalling(),
      appBar: appBar(),
      body: ListView(
        children: [
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Popular Categories",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      burgetItemFunction(),
                      japaneseItemFunction(),
                      noodlesItemFunction(),
                      ramenItemFunction(),
                      sandWichesItemFunction(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Best Deals',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 300,
            color: Colors.grey[300],
            width: double.infinity,
            child: Carousel(
              dotColor: Colors.white,
              dotSize: 5,
              dotBgColor: Colors.transparent,
              images: [
                AssetImage('images/food1.jpg'),
                AssetImage('images/food2.jpg'),
                AssetImage('images/food3.jpg'),
                AssetImage('images/food4.jpg'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.grey[100],
            height: 60,
            width: double.infinity,
            child: ListTile(
              title: Text(
                'Most Palular',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          //////
          singleFoodFunction()
        ],
      ),
    );
  }
}
