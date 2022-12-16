import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sanalira_test/cores/firebase_services/authentication_service.dart';
import 'package:sanalira_test/cores/firebase_services/firestore_service.dart';
import 'package:sanalira_test/features/authentication_pages/register_page/view_model/register_page_view_model.dart';
import 'package:sanalira_test/features/home_pages/card_page/view/card_main_page.dart';
import 'package:sanalira_test/models/firebase_models/user_local.dart';
import 'package:sizer/sizer.dart';

class RegisterMainPage extends StatefulWidget {
  const RegisterMainPage({super.key});

  @override
  State<RegisterMainPage> createState() => _RegisterMainPageState();
}

class _RegisterMainPageState extends State<RegisterMainPage> {
  Size? size;

  var _viewModel = RegisterPageViewModel();

  var formKey = GlobalKey<FormState>();
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  String? name, surname, email, areaCode, phoneNumber;
  bool isOkForm = false;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background_image.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#141C2D").withOpacity(0.75),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/logo.png"),
                      ),
                    ),
                  ),
                  Text(
                    "SanaLira",
                    style: GoogleFonts.getFont(
                      'Inter',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19.sp,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Hexcolor("#252D3D").withOpacity(0.70),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 4.w,
                      right: 4.w,
                      top: 1.h,
                      bottom: 0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 0.5.h),
                        RichText(
                          text: TextSpan(
                            text: "SanaLira'ya ",
                            style: GoogleFonts.getFont(
                              "Inter",
                              color: Colors.green,
                              fontSize: 14.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Yeni Üyelik",
                                style: GoogleFonts.getFont(
                                  "Inter",
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "Bilgilerinizi girip sözleşmeyi onaylayın.",
                          style: GoogleFonts.getFont(
                            "Inter",
                            color: Colors.white,
                            fontSize: 10.sp,
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: SizedBox(
                            height: 53.h,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                SizedBox(height: 1.h),
                                const Text(
                                  "Ad",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 0.2.h),
                                SizedBox(
                                  height: 6.h,
                                  child: TextFormField(
                                    onSaved: (newValue) => name = newValue,
                                    validator: (value) {
                                      if (value!.length < 3 &&
                                          value.length > 50) {
                                        return "Minimum 3, maksimum 50 karakter içermelidir.";
                                      }
                                    },
                                    style: _inputTextStyle(),
                                    decoration: _inputDecoration(),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                const Text(
                                  "Soyad",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 0.2.h),
                                SizedBox(
                                  height: 6.h,
                                  child: TextFormField(
                                    onSaved: (newValue) => surname = newValue,
                                    validator: (value) {
                                      if (value!.length < 3 &&
                                          value.length > 50) {
                                        return "Minimum 3, maksimum 50 karakter içermelidir.";
                                      }
                                    },
                                    style: _inputTextStyle(),
                                    decoration: _inputDecoration(),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                const Text(
                                  "E-posta",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 0.2.h),
                                SizedBox(
                                  height: 6.h,
                                  child: TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (newValue) => email = newValue,
                                    validator: (value) {
                                      RegExp regex =
                                          new RegExp(pattern.toString());

                                      if (!regex.hasMatch(value!))
                                        return 'Geçerli bir e-posta girin.';
                                      else
                                        return null;
                                    },
                                    style: _inputTextStyle(),
                                    decoration: _inputDecoration(),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                const Text(
                                  "Cep Telefonu Numaranız",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 0.2.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 25.w,
                                      height: 6.h,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        onSaved: (newValue) =>
                                            areaCode = newValue,
                                        validator: (value) {
                                          if (!value!.contains("+")) {
                                            return "Alan kodunun başına '+' ekleyin.";
                                          }
                                        },
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          prefixIcon: Image.asset(
                                              "assets/images/turkey.png"),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 65.w,
                                      height: 6.h,
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        onSaved: (newValue) =>
                                            phoneNumber = newValue,
                                        validator: (value) {
                                          if (value!.trim().length != 10) {
                                            return "Geçerli bir telefon numarası girin.";
                                          }
                                        },
                                        style: _inputTextStyle(),
                                        decoration: _inputDecoration(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    Checkbox(
                                      fillColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      side: MaterialStateBorderSide.resolveWith(
                                          (states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return BorderSide(
                                              color: Colors.white);
                                        } else {
                                          return BorderSide(
                                              color: Colors.white);
                                        }
                                      }),
                                      checkColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      value: isOkForm,
                                      onChanged: (val) {
                                        setState(() {
                                          isOkForm = val!;
                                        });
                                      },
                                    ),
                                    Expanded(
                                      child: RichText(
                                        text: const TextSpan(
                                          text: "Hesabınızı oluştururken ",
                                          children: [
                                            TextSpan(
                                              text: "sözleşme ve koşulları",
                                              style: TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                            TextSpan(
                                              text: " kabul etmeniz gerekir.",
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 1.h),
                                GestureDetector(
                                  onTap: () => _viewModel.loginButtonClicked(
                                    formKey,
                                    email,
                                    name,
                                    surname,
                                    phoneNumber,
                                    isOkForm,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 6.h,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Observer(
                                      builder: (context) {
                                        return Center(
                                          child: _viewModel.isLoadingLogin
                                              ? const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )
                                              : Text(
                                                  "Giriş Yap",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.sp),
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _inputTextStyle() {
    return TextStyle(
      fontSize: 11.sp,
      color: Colors.white,
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
