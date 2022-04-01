import 'package:flutter/material.dart';
import 'package:flutter_food_finder/providers/favourites_provider.dart';
import 'package:flutter_food_finder/providers/location_provider.dart';
import 'package:flutter_food_finder/providers/restaurant_provider.dart';
import 'package:flutter_food_finder/screens/favourites_screen.dart';
import 'package:flutter_food_finder/screens/home_screen.dart';
import 'package:flutter_food_finder/screens/map_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

Future main() async {
  // Load .env variables before running app
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FavouritesProvider()),
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProxyProvider<LocationProvider, RestaurantProvider>(
        create: (BuildContext context) => RestaurantProvider(
            Provider.of<LocationProvider>(context, listen: false).location),
        update: (BuildContext context, LocationProvider location, _) =>
            RestaurantProvider(location.location),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.grey,
            textTheme: GoogleFonts.openSansTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0,
                titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.black,
                )),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                showSelectedLabels: false,
                showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed)),
        home: const MainPage());
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const HomeScreen(),
          MapScreen(
            key: UniqueKey(),
          ),
          const FavouritesScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: 'Map', icon: Icon(Icons.map)),
          BottomNavigationBarItem(
              label: 'Favourites', icon: Icon(Icons.favorite)),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
