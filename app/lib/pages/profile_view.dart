import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
