import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ta_osso/Onboarding/onboarding_items.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  bool isLastPage = false;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: isLastPage ? getStarted(context) : buildBottomNavigation(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          controller: pageController,
          itemCount: controller.items.length,
          onPageChanged: (index) {
            setState(() {
              currentPage = index;
              isLastPage = index == controller.items.length - 1;
            });
          },
          itemBuilder: (context, index) {
            return buildOnboardingPage(index);
          },
        ),
      ),
    );
  }

  Widget buildOnboardingPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(controller.items[index].image, height: 450),
        const SizedBox(height: 15),
        Text(
          controller.items[index].title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          controller.items[index].description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildBottomNavigation() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () =>
                pageController.jumpToPage(controller.items.length - 1),
            child: const Text('Pular'),
          ),
          SmoothPageIndicator(
            controller: pageController,
            count: controller.items.length,
            onDotClicked: (index) => pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn,
            ),
            effect: const WormEffect(
              dotHeight: 12,
              dotWidth: 12,
              activeDotColor: Color.fromARGB(255, 230, 200, 33),
            ),
          ),
          TextButton(
            onPressed: () {
              if (currentPage < controller.items.length - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              }
            },
            child: const Text('Próximo'),
          ),
        ],
      ),
    );
  }
}

Widget getStarted(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    color: Colors.orange,
    child: TextButton(
      onPressed: () {
        // Nevar para a tela de login ou home
      },
      child: const Text(
        'Começar Agora',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    ),
  );
}
