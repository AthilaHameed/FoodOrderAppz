import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> _restaurants = [
    'Platez',
    'AariyaBavan',
    '50 Bucks',
    'Shawarma Hut',
    'Hotel Prabhu',
    'King Chic Restaurant'
  ];

  final List<String> _restaurantImages = [
    'assets/restaurant1.jpg',
    'assets/restaurant2.jpg',
    'assets/restaurant3.jpg',
    'assets/restaurant4.jpg',
    'assets/restaurant5.jpg',
    'assets/restaurant6.jpg'
  ];

  final List<double> _ratings = [4.5, 4.2, 4.8, 4.0, 4.3, 4.6];
  final List<String> _waitTimes = ['30 mins', '25 mins', '40 mins', '35 mins', '20 mins', '45 mins'];

  List<String> _filteredRestaurants = [];
  List<String> _filteredImages = [];
  List<double> _filteredRatings = [];
  List<String> _filteredWaitTimes = [];

  @override
  void initState() {
    super.initState();
    _filteredRestaurants = _restaurants;
    _filteredImages = _restaurantImages;
    _filteredRatings = _ratings;
    _filteredWaitTimes = _waitTimes;
  }

  void _filterRestaurants(String query) {
    setState(() {
      _filteredRestaurants = _restaurants
          .where((restaurant) => restaurant.toLowerCase().contains(query.toLowerCase()))
          .toList();
      _filteredImages = _restaurantImages
          .asMap()
          .entries
          .where((entry) => _filteredRestaurants.contains(_restaurants[entry.key]))
          .map((entry) => entry.value)
          .toList();
      _filteredRatings = _ratings
          .asMap()
          .entries
          .where((entry) => _filteredRestaurants.contains(_restaurants[entry.key]))
          .map((entry) => entry.value)
          .toList();
      _filteredWaitTimes = _waitTimes
          .asMap()
          .entries
          .where((entry) => _filteredRestaurants.contains(_restaurants[entry.key]))
          .map((entry) => entry.value)
          .toList();
    });
  }

  void _refreshRestaurants() {
    setState(() {
      _filteredRestaurants = _restaurants;
      _filteredImages = _restaurantImages;
      _filteredRatings = _ratings;
      _filteredWaitTimes = _waitTimes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.location_on),
                SizedBox(width: 8),
                Text('31, Mallick Dhinar'),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filterRestaurants,
                decoration: InputDecoration(
                  hintText: 'Search for restaurants or dishes',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Explore the best restaurants in town!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:FontWeight.bold,
                  color: Colors.black,
                ),
              ),




            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset('assets/promo_banner.jpg', width: double.infinity),
            ),

            Container(

              color: Colors.orange[100],

              padding: EdgeInsets.all(16.0),
              child: Text(
                "Riders may slow down to be safe during rains. Dont worry,your food will be delivered with care!",
                style: TextStyle(fontSize: 14,
                fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _filteredImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(_filteredImages[index], width: double.infinity, height: 250, fit: BoxFit.cover),
                      SizedBox(height: 8),
                      Text(
                        _filteredRestaurants[index],
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${_filteredRatings[index]} ★',
                            style: TextStyle(fontSize: 18, color: Colors.amber),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${_filteredWaitTimes[index]}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_filteredImages.length, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blueAccent : Colors.grey,
                  ),
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'REORDER FROM FAVOURITES',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.delivery_dining, size: 50),
                  Icon(Icons.credit_card, size: 50),
                  GestureDetector(
                    onTap: _refreshRestaurants,
                    child: Icon(Icons.replay, size: 50),
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
