import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/theme/colors_theme.dart';
import '../../utils/easy_faq.dart';
import 'dart:async';

class FAQPage extends StatefulWidget {
  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ConstColors.whiteFontColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ThemeColor.black,
            )),
        title: Text(
          "FAQs",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ThemeColor.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: ThemeColor.lighterPrimary,
      body: ListView(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        children: [
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Co je Cermatík?",
              answer:
                  "Cermatík je aplikace, která pomáhá studentům připravit se na přijímací zkoušky na střední školy. Obsahuje testy, které simulují oficiální CERMAT testy, a nabízí nástroje pro sledování pokroku."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Pro koho je aplikace určená?",
              answer:
                  "Aplikace je primárně určena pro děti kolem 15 let, které se připravují na přijímací zkoušky na střední školy."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Jaké verze aplikace jsou k dispozici?",
              answer:
                  "Aplikace Cermatík nabízí tři různé verze:\n\nVerze Basic: Zdarma poskytuje všechny základní funkce potřebné pro přípravu na zkoušky s omezenými reklamami.\n\nVerze Plus:\n14denní předplatné: 39 Kč\nMěsíční předplatné: 79 Kč\nTříměsíční předplatné: 149 Kč\nRoční předplatné: 229 Kč\n\nVerze Premium:\nVyjde později a bude obsahovat prémiové funkce, jako řešení jednotlivých příkladů a pokročilé nástroje pro sledování pokroku."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Jaký je rozdíl mezi verzemi Basic, Plus a Premium?",
              answer:
                  "Basic je zdarma a nabízí základní funkce pro přípravu na zkoušky s omezenými reklamami.\nPlus je placená verze bez reklam a s rozšířenými funkcemi.\nPremium bude obsahovat řešení příkladů, pokročilé sledování pokroku a další analytické nástroje, ale bude k dispozici později."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question:
                  "Pomohou mi tyto testy při přípravě na přijímací zkoušky?",
              answer:
                  "Ano, testy jsou vytvořené s cílem zlepšit úspěšnost žáků při přijímacích zkouškách."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Jak mohu předplatné zaplatit?",
              answer:
                  "Předplatné lze zaplatit přes platební bránu přímo v aplikaci. Můžete použít platební karty nebo jiné dostupné platební metody, které aplikace podporuje."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Mohu si aplikaci vyzkoušet zdarma?",
              answer:
                  "Ano, verze Basic je zdarma k dispozici s omezenými funkcemi. Můžete si ji vyzkoušet a poté případně přejít na placené předplatné bez reklam a s rozšířenými možnostmi."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Jak mohu zrušit předplatné?",
              answer:
                  "Předplatné můžete kdykoli zrušit prostřednictvím nastavení účtu v aplikaci. Po zrušení bude vaše předplatné pokračovat až do konce již zaplaceného období."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question:
                  "Co se stane, když mi vyprší předplatné? Budu mít stále přístup k testům, které jsem již udělal?",
              answer:
                  "Ne, po vypršení předplatného nebudou testy, které jste již udělali, nadále k dispozici. Bude však možné si je znovu projít za Coins, stejně jako ve verzi Basic."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Jak často jsou přidávány nové testy?",
              answer:
                  "Testy jsou pravidelně aktualizovány, aby odpovídaly nejnovějším požadavkům na přijímací zkoušky a aktuálnímu obsahu."),
          const SizedBox(height: 10),
          EasyFaq(
              questionTextStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.white),
              anserTextStyle: TextStyle(fontSize: 14, color: ThemeColor.black),
              backgroundColor: ThemeColor.primary,
              question: "Co mám dělat, pokud mám technické problémy?",
              answer:
                  "Pokud narazíte na technické problémy, kontaktujte nás prostřednictvím sekce „Podpora“ v aplikaci nebo nám napište na michal@cermatik.cz."),
        ],
      ),
    );
  }
}
