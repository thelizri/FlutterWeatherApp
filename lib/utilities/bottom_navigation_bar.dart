import 'package:flutter/material.dart';

class BottomNavigationBarWeather extends StatefulWidget {
  final List<Widget> pages;
  const BottomNavigationBarWeather(this.pages, {super.key});

  @override
  State<BottomNavigationBarWeather> createState() =>
      _BottomNavigationBarWeatherState();
}

class _BottomNavigationBarWeatherState
    extends State<BottomNavigationBarWeather> {
  int selectedIndex = 0;

  final PageController pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Weather App',
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: widget.pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[800],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Current',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment_outlined),
            label: 'Forecast',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose(); // Dispose the controller when you're done
    super.dispose();
  }
}
