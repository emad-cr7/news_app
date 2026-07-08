import 'package:flutter/material.dart';
import 'package:news_app/features/onboarding/onbording_controller.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/datasource/local_data/servies/user_repository.dart';
import '../auth/sign_in_screen.dart';
import 'models/onboarding_model.dart';

class Onboarding extends StatelessWidget {
  Onboarding({super.key});

  _onFinish(context) async {
    await UserRepository().setOnboardingComplete(true);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnbordingController>(
      create: (BuildContext context) => OnbordingController(),
      builder: (context, _) {
        final controller = context.read<OnbordingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF5F5F5),
            actions: [
              Consumer<OnbordingController>(
                builder:
                    (
                      BuildContext context,
                      OnbordingController value,
                      Widget? child,
                    ) {
                      return value.isLastPage
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                _onFinish(context);
                              },
                              child: Text(
                                "Skip",
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            );
                    },
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizes.ph30,
              horizontal: AppSizes.pw16,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    onPageChanged: (index) {
                      context.read<OnbordingController>().onPage(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    controller: controller.pageController,
                    itemBuilder: (BuildContext context, int index) {
                      final model = OnboardingModel.onboardingList[index];
                      return Column(
                        children: [
                          Image.asset(model.image),
                          SizedBox(height: AppSizes.ph24),
                          Text(
                            model.title,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SizedBox(height: AppSizes.ph20),
                          Text(
                            model.description,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller.pageController,
                  count: 3,
                  effect: WormEffect(activeDotColor: Color(0xffC53030)),
                ),
                SizedBox(height: AppSizes.ph112),
                Consumer<OnbordingController>(
                  builder:
                      (
                        BuildContext context,
                        OnbordingController controller,
                        Widget? child,
                      ) {
                        final controller = context.read<OnbordingController>();
                        return ElevatedButton(
                          onPressed: () {
                            if (!controller.isLastPage) {
                              controller.pageController.nextPage(
                                duration: Duration(milliseconds: 700),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _onFinish(context);
                            }
                          },
                          child: Text(
                            controller.isLastPage ? 'Get Started' : "Next",
                          ),
                        );
                      },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
