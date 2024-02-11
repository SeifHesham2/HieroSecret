import '../home_page/widgets/grid_item_widget.dart';
import '../home_page/widgets/slider_item_widget.dart';
import 'controller/home_controller.dart';
import 'models/grid_item_model.dart';
import 'models/home_model.dart';
import 'models/slider_item_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hierosecret/core/app_export.dart';
import 'package:hierosecret/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:hierosecret/widgets/app_bar/appbar_trailing_iconbutton.dart';
import 'package:hierosecret/widgets/app_bar/appbar_trailing_image.dart';
import 'package:hierosecret/widgets/app_bar/custom_app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore_for_file: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeController controller = Get.put(HomeController(HomeModel().obs));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            appBar: _buildAppBar(),
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                padding: EdgeInsets.only(top: 56.v),
                decoration: BoxDecoration(
                    color: theme.colorScheme.onPrimary,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.imgOnboarding),
                        fit: BoxFit.cover)),
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.h, vertical: 15.v),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("lbl_what_s_new".tr,
                              style: theme.textTheme.titleLarge),
                          SizedBox(height: 5.v),
                          _buildSlider(),
                          SizedBox(height: 13.v),
                          Obx(() => Container(
                              height: 15.v,
                              margin: EdgeInsets.only(left: 120.h),
                              child: AnimatedSmoothIndicator(
                                  activeIndex: controller.sliderIndex.value,
                                  count: controller.homeModelObj.value
                                      .sliderItemList.value.length,
                                  axisDirection: Axis.horizontal,
                                  effect: ScrollingDotsEffect(
                                      spacing: 5,
                                      activeDotColor: appTheme.red300,
                                      dotColor: theme.colorScheme.primary,
                                      dotHeight: 15.v,
                                      dotWidth: 15.h)))),
                          SizedBox(height: 2.v),
                          Text("lbl_activities".tr,
                              style: theme.textTheme.titleLarge),
                          SizedBox(height: 12.v),
                          _buildGrid(),
                          SizedBox(height: 21.v)
                        ])))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
        height: 100.v,
        title: AppbarSubtitleOne(
            text: "lbl_hi_ahmed".tr, margin: EdgeInsets.only(left: 26.h)),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationBellNew,
              margin: EdgeInsets.fromLTRB(22.h, 18.v, 3.h, 6.v)),
          AppbarTrailingIconbutton(
              imagePath: ImageConstant.imgSettingsPrimary,
              margin: EdgeInsets.only(left: 14.h, top: 3.v, right: 25.h))
        ]);
  }

  /// Section Widget
  Widget _buildSlider() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.h),
        child: Obx(() => CarouselSlider.builder(
            options: CarouselOptions(
                height: 153.v,
                initialPage: 0,
                autoPlay: true,
                viewportFraction: 1.0,
                enableInfiniteScroll: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  controller.sliderIndex.value = index;
                }),
            itemCount:
                controller.homeModelObj.value.sliderItemList.value.length,
            itemBuilder: (context, index, realIndex) {
              SliderItemModel model =
                  controller.homeModelObj.value.sliderItemList.value[index];
              return SliderItemWidget(model);
            })));
  }

  /// Section Widget
  Widget _buildGrid() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.h),
        child: Obx(() => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 151.v,
                crossAxisCount: 2,
                mainAxisSpacing: 26.h,
                crossAxisSpacing: 26.h),
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.homeModelObj.value.gridItemList.value.length,
            itemBuilder: (context, index) {
              GridItemModel model =
                  controller.homeModelObj.value.gridItemList.value[index];
              return GridItemWidget(model, onTapTwentySix: () {
                onTapTwentySix();
              });
            })));
  }

  /// Navigates to the nameGeneratorScreen when the action is triggered.
  onTapTwentySix() {
    Get.toNamed(
      AppRoutes.nameGeneratorScreen,
    );
  }
}
