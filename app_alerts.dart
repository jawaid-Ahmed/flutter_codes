import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:shared_components/lib.dart';

typedef SuccessCallback = void Function(dynamic data);
typedef OnChangeCallback = void Function(bool? val);
typedef AlertSuccessCallback = void Function();

enum AlertTypes {
  info,
  warning,
  error,
  alert,
  connectivity,
  success,
  logout,
}

class AppAlerts {
  customAlert({
    String? title,
    String? subTitle,
    String? message,
    AlertSuccessCallback? callback,
    AlertSuccessCallback? cancelCallback,
    AlertSuccessCallback? otherCallback,
    AlertTypes alertTypes = AlertTypes.info,
    String? cancelText,
    String? okText,
    String? otherActionText,
    bool showCheckbox = false,
    bool checkBoxValue = false,
    OnChangeCallback? onChangeCallback,
  }) async {
    List<Widget> getBtns(BuildContext context) {
      return [
        PointerInterceptor(
          child: hTButton(context, onPressed: () {
            Get.back();
            if (callback != null) {
              callback();
            }
          },
              title:
                  okText ?? (alertTypes == AlertTypes.warning ? "Yes" : "OK"),
              minWidth: 80),
        ),
        if (otherCallback != null &&
            otherActionText != null &&
            otherActionText.isNotEmpty) ...[
          const SizedBox(width: 8,height: 10,),
          hTButton(
            context,
            onPressed: () {
              Get.back();
              otherCallback();
            },
            title: otherActionText,
            buttonType: ButtonTypes.primary50,
            minWidth: 80,
          ),
        ],
        if (cancelCallback != null) ...[
          const SizedBox(
            width: 8,
            height: 10,
          ),
          hTButton(
            context,
            onPressed: () {
              Get.back();
              cancelCallback();
            },
            title: cancelText ??
                (alertTypes == AlertTypes.warning ? "No" : "Cancel"),
            buttonType: ButtonTypes.primary50,
            minWidth: 50,
          ),
        ],
      ];
    }

    if (Get.isDialogOpen == false) {
      await Get.defaultDialog(
        radius: 10,
        barrierDismissible: false,
        title: "",
        titlePadding: const EdgeInsets.all(0),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppUIConstant.kDefaultPadding,
        ),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(5),
              width: Responsive.isDesktop(context)
                  ? (getBtns(context).length > 4
                      ? (MediaQuery.of(context).size.width * 0.45)
                      : (getBtns(context).length > 2
                          ? MediaQuery.of(context).size.width * 0.3
                          : 300))
                  : MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 5),
                  if (alertTypes == AlertTypes.warning) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.error) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.info) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.connectivity) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.success) ...[
                    SvgPicture.asset(
                      AssetsConstant.kCheckCircleBroken,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.logout) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ] else if (alertTypes == AlertTypes.alert) ...[
                    SvgPicture.asset(
                      AssetsConstant.kAnnotationAlert,
                      width: 40,
                      height: 40,
                      color: getThemeColor(
                        light: LightColors.kPrimary900,
                        dark: DarkColors.kPrimary900,
                      ),
                    )
                  ],
                  const SizedBox(height: AppUIConstant.kDefaultPadding),
                  if (title != null && title.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: HTStyles.bodyBold.copyWith(
                            fontSize: 20,
                            color: getThemeColor(
                                light: LightColors.kBlack,
                                dark: DarkColors.kWhite))),
                  ],

                  if (subTitle != null && subTitle.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      subTitle,
                      textAlign: TextAlign.center,
                      style: HTStyles.bodyRegular.copyWith(fontSize: 18),
                    ),
                  ],
                  // const SizedBox(height: AppUIConstant.kDefaultPadding),
                  if (message != null && message.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      message,
                      maxLines: 3,
                      style: HTStyles.bodyRegular.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  const SizedBox(height: AppUIConstant.kDefaultPadding),

                  if (showCheckbox) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                            value: checkBoxValue,
                            onChanged: (val) {
                              setState(() {
                                checkBoxValue = !checkBoxValue;
                              });
                              onChangeCallback!.call(val);
                            }),
                        const Text('Enable Recurring Payment'),
                      ],
                    )
                  ],
                  const SizedBox(height: AppUIConstant.kDefaultPadding),
                  getBtns(context).length > 4
                      ? isWeb()
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getBtns(context),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: getBtns(context),
                            )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getBtns(context),
                        )
                ],
              ),
            );
          },
        ),
      );
    }
  }

  bool isWeb() {
    return kIsWeb;
  }
}

AppAlerts appAlerts = AppAlerts();
