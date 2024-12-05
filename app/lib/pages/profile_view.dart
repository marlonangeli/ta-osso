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
      ),
    );
  }
}
