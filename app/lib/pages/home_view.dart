// lib/pages/home_view.dart

import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/modals/AddAccountModal.dart';
import 'package:ta_osso/modals/AddCardModal.dart';
import 'package:ta_osso/pages/account_list_view.dart';
import 'package:ta_osso/pages/card_list_view.dart';
import 'package:ta_osso/pages/profile_view.dart';
import 'package:ta_osso/pages/widgets/home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomePage(),
      const Center(child: Text('Página Listagem')),
      const Center(child: Text('Nova Operação')),
      const Center(child: Text('Página Gráficos')),
      const ProfileView(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá,',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'João Silva',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: const HomeDrawer(),
      body: pages[_currentIndex],
      bottomNavigationBar: _buildBottomBar(),
      floatingActionButton: _buildFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.savings,
                        size: 32,
                        color: Colors.purple.shade700,
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Saldo Atual',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'R\$ 5.000,00',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: Colors.green.shade600,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Receitas',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Text(
                              'R\$ 3.500,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Despesas
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.red.shade600,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Despesas',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Text(
                              'R\$ 2.500,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.account_balance,
                              color: Colors.blue.shade600,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Gastos Conta',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Text(
                              'R\$ 1.500,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      // Gastos Cartão
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.credit_card,
                              color: Colors.orange.shade600,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Gastos Cartão',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Text(
                              'R\$ 1.000,00',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Meus Cartões',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.eerieBlack,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 28,
                        ),
                        onPressed: () => showAddCardModal(context),
                      ),
                    ],
                  ),
                ),
                const CardList(),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Minhas Contas',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.eerieBlack,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.green,
                          size: 28,
                        ),
                        onPressed: () => showAddAccountModal(context),
                      ),
                    ],
                  ),
                ),
                const AccountList(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return BottomAppBar(
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
            onPressed: () => setState(() => _currentIndex = 0),
          ),
          IconButton(
            icon: Icon(
              Icons.list,
              color: _currentIndex == 1 ? Colors.black : Colors.grey,
            ),
            onPressed: () => setState(() => _currentIndex = 1),
          ),
          const SizedBox(width: 48),
          IconButton(
            icon: Icon(
              Icons.bar_chart,
              color: _currentIndex == 3 ? Colors.black : Colors.grey,
            ),
            onPressed: () => setState(() => _currentIndex = 3),
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 4 ? Colors.black : Colors.grey,
            ),
            onPressed: () => setState(() => _currentIndex = 4),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      onPressed: () => setState(() => _currentIndex = 2),
      backgroundColor: Colors.green,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
