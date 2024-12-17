// lib/pages/select_icon_page.dart

import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';

class SelectIconPage extends StatelessWidget {
  const SelectIconPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> icons = [
      {'name': 'Banco do Brasil', 'path': 'assets/icons/LogoBrasil.png'},
      {'name': 'Nubank', 'path': 'assets/icons/LogoNubank.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecionar Ícone',
          style: TextStyle(color: AppColors.eerieBlack),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.eerieBlack),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => Navigator.pop(context, icons[index]),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.timberwolf),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      icons[index]['path']!,
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      icons[index]['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.eerieBlack,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}