import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ta_osso/common/constants/app_colors.dart';
import 'package:ta_osso/common/constants/routes.dart';
import 'package:ta_osso/pages/Onboarding/onboarding_items.dart';
import 'package:ta_osso/services/prefs_service.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();
  final PrefsService _prefsService = PrefsService();
  bool isLastPage = false;
  bool javi = false;

 @override
  void initState() {
    super.initState();
    _checkIfOnboardingCompleted();
  }

   Future<void> _checkIfOnboardingCompleted() async {
    final onboardingCompleted = await _prefsService.carregarBool('onboarding_completed');
    print('Status do Shared para onboarding: $onboardingCompleted');
    if (onboardingCompleted) {
      Navigator.pushReplacementNamed(context, NamedRoutes.login);
    }
  }

  void _completeOnboarding() async {
    await _prefsService.salvarBool('onboarding_completed', true);
    Navigator.pushReplacementNamed(context, NamedRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () =>
                        pageController.jumpToPage(controller.items.length - 1),
                    child: const Text("Pular"),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    effect: const WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      dotColor: AppColors.jonquil,
                 
                    ),
                  ),
                  TextButton(
                    onPressed: () => pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    child: const Text("Próximo"),
                  ),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) =>
              setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  controller.items[index].image,
                  height: MediaQuery.of(context).size.height * 0.4,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    controller.items[index].description,
                    style: const TextStyle(
                      color: AppColors.timberwolf,
                      fontSize: 17,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: AppColors.jonquil,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 55,
      child: TextButton(
        onPressed: _completeOnboarding,
        child: const Text(
          "Começar Agora",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
