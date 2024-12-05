import 'package:flutter/material.dart';
import 'package:ta_osso/common/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.timberwolf,

     /* 
     bottomNavigationBar: BottomAppBar(
        color: AppColors.aureolin,
        child: BottomAppBarContents,
      ),
      floatingActionButton: const FloatingActionButton(onPressed: null),
      */

      body: const Center(
        child: Text('Manda o Pix! rsrs'),
      ),
    );
  }
}
