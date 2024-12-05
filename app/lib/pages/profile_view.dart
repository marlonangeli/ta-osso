import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cabeçalho
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 200,
                  color: const Color.fromARGB(255, 238, 196, 7), // Cor amarelada
                ),
                Positioned(
                  top: 40,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(Icons.notifications, color: Colors.white),
                    onPressed: () {
                      // Apenas efeito visual
                    },
                  ),
                ),
                const Positioned(
                  top: 50,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Placeholder para a imagem do usuário
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Enjelin Morgeana',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'engelinemorgeana@email.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Opções do perfil
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _buildOptionTile(
                  context,
                  icon: Icons.lock,
                  title: 'Mudar Senha',
                ),
                const Divider(),
                _buildOptionTile(
                  context,
                  icon: Icons.flag,
                  title: 'Definir Objetivo',
                ),
                const Divider(),
                _buildOptionTile(
                  context,
                  icon: Icons.category,
                  title: 'Minhas Categorias',
                ),
                const Divider(),
                _buildOptionTile(
                  context,
                  icon: Icons.account_balance_wallet,
                  title: 'Minhas Contas',
                ),
                const Divider(),
                _buildOptionTile(
                  context,
                  icon: Icons.logout,
                  title: 'Sair',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context,
      {required IconData icon, required String title}) {
    return InkWell(
      onTap: () {
        // Apenas efeito visual ao tocar
      },
      splashColor: Theme.of(context).primaryColor.withOpacity(0.2), // Efeito ao clicar
      highlightColor: Theme.of(context).primaryColor.withOpacity(0.1), // Efeito ao pressionar
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(title),
      body: Column(
        children: [
          // Header
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                color: const Color.fromARGB(255, 238, 196, 7), // Cor amarelada
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    // Ação para o sino (não implementado ainda)
                  },
                ),
              ),
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150', // Placeholder para a imagem do usuário
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Enjelin Morgeana',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'engelinemorgeana@email.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 80), // Espaço entre o header e as opções
          // Opções
          ListTile(
            leading: const Icon(Icons.person, color: Colors.black),
            title: const Text('Change name'),
            onTap: () {
              // Ação para mudar nome (não implementado ainda)
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.black),
            title: const Text('Change password'),
            onTap: () {
              // Ação para mudar senha (não implementado ainda)
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout'),
            onTap: () {
              // Ação para logout (não implementado ainda)
            },
          ),
        ],
      ),
    );
  }
}
