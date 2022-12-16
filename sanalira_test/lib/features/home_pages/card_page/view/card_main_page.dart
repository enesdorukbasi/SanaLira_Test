import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sanalira_test/cores/api_services/api_service.dart';
import 'package:sanalira_test/features/home_pages/card_page/view_model/card_main_page_view_model.dart';
import 'package:sanalira_test/models/json_models/bank_json_model.dart';
import 'package:sizer/sizer.dart';

class CardMainPage extends StatefulWidget {
  const CardMainPage({super.key});

  @override
  State<CardMainPage> createState() => _CardMainPageState();
}

class _CardMainPageState extends State<CardMainPage> {
  final _viewModel = CardMainPageViewModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Hexcolor("#F3F4F6"),
        appBar: _appbar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            children: [
              _item(
                9.h,
                8.h,
                "assets/images/turkey2.png",
                12.w,
                "Türk Lirası",
                "TL",
                12.sp,
                Text(
                  "234 ₺",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Türk lirası yatırmak için banka seçiniz.",
                  style: TextStyle(
                    color: Hexcolor("#CFD4DE"),
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              FutureBuilder<List<BankJsonModel>?>(
                  future: ApiService().getBanks(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.data == null) {
                      return Center(
                        child: Text("Banka Hesabı Bulunamamaktadır."),
                      );
                    }

                    return SizedBox(
                      height: 62.h,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String imagePath = "";
                          BankJsonModel bank = snapshot.data![index];
                          if (bank.bankName ==
                              "ALBARAKA TÜRK KATILIM BANKASI A.Ş.") {
                            imagePath = "assets/images/albaraka.png";
                          } else if (bank.bankName ==
                              "TÜRKİYE VAKIFLAR BANKASI T.A.O.") {
                            imagePath = "assets/images/albaraka.png";
                          } else {
                            imagePath = "assets/images/ziraat.png";
                          }
                          return _listItem(
                            13.h,
                            13.h,
                            imagePath,
                            4.w,
                            bank.bankName.toString(),
                            "Havale / EFT ile para gönderin.",
                            10.sp,
                            null,
                            bank,
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 9.h,
          decoration: BoxDecoration(
            color: Hexcolor("#FFFFFF"),
            boxShadow: [
              BoxShadow(
                color: Hexcolor("#8F99AC69").withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 7.w,
                height: 7.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/home.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 7.w,
                height: 7.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/transaction.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: 15.w,
                width: 15.w,
                decoration: BoxDecoration(
                  color: Hexcolor("#26293B"),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 1.w,
                  height: 1.w,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/middlenav.png"),
                    ),
                  ),
                ),
              ),
              Container(
                width: 7.w,
                height: 7.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/card.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 7.w,
                height: 7.w,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/user.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _listItem(
      double height,
      double width,
      String imagePath,
      double imageSize,
      String title,
      String subtitle,
      double subtitleSize,
      Widget? action,
      BankJsonModel bank) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.6.h),
      child: GestureDetector(
        onTap: () => _bottomSheet(bank),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 15.w,
                      height: 3.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(imagePath), fit: BoxFit.fill),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 55.w,
                              child: Expanded(
                                child: Text(
                                  title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          subtitle,
                          style: TextStyle(
                              color: Colors.grey.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                              fontSize: subtitleSize),
                        ),
                      ],
                    ),
                  ],
                ),
                action != null ? action : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _item(
    double height,
    double width,
    String imagePath,
    double imageSize,
    String title,
    String subtitle,
    double subtitleSize,
    Widget? action,
  ) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: imageSize,
                  child: Image.asset(
                    imagePath,
                  ),
                ),
                SizedBox(width: 2.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.grey.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: subtitleSize),
                    ),
                  ],
                ),
              ],
            ),
            action != null ? action : SizedBox(),
          ],
        ),
      ),
    );
  }

  PreferredSize _appbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(11.h),
      child: Container(
        height: 11.h,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _viewModel.signOut(),
                child: Container(
                  height: 13.w,
                  width: 13.w,
                  decoration: BoxDecoration(
                    color: Hexcolor("#FFFFFF"),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(Icons.arrow_back),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 13.w,
                    width: 13.w,
                    decoration: BoxDecoration(
                      color: Hexcolor("#FFFFFF"),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.notifications),
                  ),
                  SizedBox(width: 2.w),
                  Container(
                    height: 13.w,
                    width: 13.w,
                    decoration: BoxDecoration(
                      color: Hexcolor("#FFFFFF"),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.settings),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _bottomSheet(BankJsonModel bank) {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 2.h),
              Center(
                child: Container(
                  height: 0.7.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Hexcolor("#141C2D"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                "Hesap Adı",
                style: TextStyle(color: Hexcolor("#CFD4DE")),
              ),
              SizedBox(height: 0.4.h),
              SizedBox(
                height: 7.h,
                child: TextFormField(
                  readOnly: true,
                  initialValue: bank.bankAccountName,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Hexcolor("#141C2D"),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await copyMethod(bank.bankAccountName);
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.green,
                      ),
                    ),
                    fillColor: Hexcolor("#F3F4F6"),
                    filled: true,
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
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "IBAN",
                style: TextStyle(color: Hexcolor("#CFD4DE")),
              ),
              SizedBox(height: 0.4.h),
              SizedBox(
                height: 7.h,
                child: TextFormField(
                  readOnly: true,
                  initialValue: bank.bankIban,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Hexcolor("#141C2D"),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await copyMethod(bank.bankIban);
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.green,
                      ),
                    ),
                    fillColor: Hexcolor("#F3F4F6"),
                    filled: true,
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
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "Açıklama",
                style: TextStyle(color: Hexcolor("#CFD4DE")),
              ),
              SizedBox(height: 0.4.h),
              SizedBox(
                height: 7.h,
                child: TextFormField(
                  readOnly: true,
                  initialValue: bank.descriptionNo,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Hexcolor("#141C2D"),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        await copyMethod(bank.descriptionNo);
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Colors.green,
                      ),
                    ),
                    fillColor: Hexcolor("#F3F4F6"),
                    filled: true,
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
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                  color: Hexcolor("#F3F4F6"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Lütfen havale yaparken açıklama alanına yukarıdaki kodu yazmayı unutmayın.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Hexcolor("#BCC2CE"),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                  color: Hexcolor("#FFF6F6"),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Eksik bilgi girilmesi sebebiyle tutarın askıda kalması durumunda, ücret kesintisi yapılacaktır.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Hexcolor("#F64949"),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  copyMethod(text) async {
    FlutterClipboard.copy(text).then((value) => print('copied'));
  }
}
