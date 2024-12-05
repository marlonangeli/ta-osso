import 'package:flutter/material.dart';
import 'package:ta_osso/pages/profile_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Lista de páginas
    final List<Widget> _pages = [
      const Center(child: Text('Página Home')),
      const Center(child: Text('Página Listagem')),
      const Center(child: Text('Nova Operação')),
      const Center(child: Text('Página Gráficos')),
      const ProfileView(), // Integração da ProfileView
    ];

    return Scaffold(
     // appBar: AppBar(
       // title: const Text('Tá Osso'),
     // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: _currentIndex == 0 ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.list,
                color: _currentIndex == 1 ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: Icon(
                Icons.bar_chart,
                color: _currentIndex == 3 ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 3;
                });
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _currentIndex == 4 ? Colors.black : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _currentIndex = 4;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _currentIndex = 2;
          });
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}