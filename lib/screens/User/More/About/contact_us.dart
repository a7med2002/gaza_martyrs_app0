import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/components/custom_button.dart';
import 'package:gaza_martyer_app/components/custom_my_app_bar.dart';
import 'package:gaza_martyer_app/components/custom_text_field.dart';
import 'package:gaza_martyer_app/controllers/User/contact_controller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    ContactController contactController = Get.put(ContactController());
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomMyAppBar(title: "contactUs".tr),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Obx(() => Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Email
                      Text(
                        "email".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      CustomTextField(
                        hintText: "emailEmpty".tr,
                        svgSuffixIcon: "assets/svgs/email.svg",
                        controller: contactController.email,
                        validator: (String? value) {
                          return null;
                        },
                        isSecure: false,
                        readOnly: true,
                      ),
                      SizedBox(height: 24),
                      // Message
                      Text(
                        "message".tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Form(
                          key: _formKey,
                          child: TextFormField(
                            maxLines: 6,
                            controller: messageController,
                            validator: (value) {
                              if (value == '' || value!.isEmpty) {
                                return "emptyMessage".tr;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(8)),
                                filled: true,
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                hintText: "hintMessage".tr,
                                hintStyle: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withOpacity(0.7))),
                          )),
                      SizedBox(height: 32),
                      // Button
                      CustomButton(
                          text: "send".tr,
                          txtColor: Theme.of(context).colorScheme.onPrimary,
                          btnColor: Theme.of(context).colorScheme.primary,
                          withIcon: false,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              contactController.message.value =
                                  messageController.text;
                              contactController.submitMessage();
                              messageController.clear();
                            }
                          },
                          fontSize: 16),
                      SizedBox(height: 16),
                      // Social Media Account
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  "https://www.instagram.com/gaza_shaheed");
                              try {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print("Error launching URL: $e");
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.1))),
                                  child: Image.asset(
                                    "assets/logo/instagram-.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Gaza_Shaheed",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(width: 32),
                          InkWell(
                            onTap: () async {
                              final Uri url =
                                  Uri.parse("https://t.me/Gaza_shaheed");
                              try {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print("Error launching URL: $e");
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.1))),
                                  child: Image.asset(
                                    "assets/logo/telegram.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Gaza_Shaheed",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              final Uri url =
                                  Uri.parse("https://www.x.com/gaza_shaheed");
                              try {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print("Error launching URL: $e");
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.1))),
                                  child: Image.asset(
                                    "assets/logo/twitter-.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("Gaza_Shaheed",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ))
                              ],
                            ),
                          ),
                          SizedBox(width: 32),
                          InkWell(
                            onTap: () async {
                              final Uri url = Uri(
                                scheme: 'mailto',
                                path: 'gazashaheed@gmail.com',
                              );
                              try {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print("Error launching URL: $e");
                              }
                            },
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withOpacity(0.1))),
                                  child: Image.asset(
                                    "assets/logo/gmail.png",
                                    width: 24,
                                    height: 24,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text("gazashaheed",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  contactController.isLoading.value
                      ? Positioned.fill(
                          child: Center(child: CircularProgressIndicator()))
                      : SizedBox.shrink()
                ],
              )),
        ),
      ),
    );
  }
}