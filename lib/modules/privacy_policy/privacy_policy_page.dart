import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors_theme.dart';
// import 'update_profile_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  var controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
                'https://www.cermatik.cz/podminky-ochrany-osobnich-udaju/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://www.cermatik.cz/podminky-ochrany-osobnich-udaju/'));
  }

  @override
  Widget build(BuildContext context) {
    // UpdateProfileController updateProfileController =
    //     Get.find<UpdateProfileController>();
    return Scaffold(
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
            "Privacy Policy",
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
        body: Container(
            // padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: ThemeColor.white,
                borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: Text(
                      "Podmínky ochrany osobních údajů\n\nI. Zpracování osobních údajů\nZpracováváme osobní údaje, které nám poskytnete při využívání našich služeb, nákupu zboží a komunikaci s námi. Tyto údaje jsou nezbytné pro poskytování našich služeb a správnou funkčnost aplikace.\n\nII. Jak mohu smazat svůj účet?\nPokud si přejete smazat svůj účet, postupujte takto:\n1.	Pošlete e-mail na adresu michal@cermatik.cz s předmětem 'Žádost o smazání účtu'.\n2.	Uveďte důvod, proč chcete svůj účet smazat (tento krok není povinný, ale může nám pomoci vylepšit naše služby).\n3.	Jakmile bude váš účet smazán, nebude možné jej obnovit a ztratíte přístup ke všem službám spojeným s tímto účtem.\n\nIII. Jaké údaje zpracováváme?\nZpracováváme následující osobní údaje, které nám poskytnete:\n•	Jméno a příjmení\n•	E-mailovou adresu\n•	Telefonní číslo\n•	Fakturační a doručovací adresu\nTyto údaje používáme pro správu objednávek, poskytování služeb a komunikaci s vámi.\n\nIV. Jak dlouho údaje uchováváme?\nVaše osobní údaje uchováváme po dobu nezbytnou pro zajištění našich služeb. V případě komunikace uchováváme údaje po dobu 1 roku od posledního kontaktu. U údajů spojených s objednávkami uchováváme data po dobu 10 let pro účely účetnictví a daňových povinností.\n\nV. Vaše práva\nMáte právo na přístup ke svým osobním údajům, jejich opravu, výmaz nebo omezení zpracování. Pokud chcete využít svá práva, kontaktujte nás na e-mailu michal@cermatik.cz.\n\nVI. Používání cookies\nPoužíváme cookies pro zajištění lepšího uživatelského zážitku a pro analytické účely. Můžete si nastavit svůj prohlížeč tak, aby cookies blokoval, nebo si zvolit, jaké cookies povolíte.\nPoužíváme tyto typy cookies:\n•	Nezbytné cookies: Pro správnou funkčnost služeb.\n•	Analytické cookies: Pro sledování návštěvnosti a zlepšování výkonu našich služeb.\n•	Reklamní cookies: Pro zobrazování cílené reklamy.\n\nVII. Kdo má přístup k vašim údajům?\nVaše údaje zůstávají u nás, ale mohou být zpracovávány i třetími stranami, které nám pomáhají poskytovat služby, například:\n•	Poskytovatelé platebních a fakturačních služeb\n•	Marketingové a analytické platformy (např. Google, Meta)\n•	Poskytovatelé e-mailových služeb\nData jsou zpracovávána pouze v rámci Evropské unie.\n\nVIII. Kontakt\nPokud máte otázky ohledně zpracování osobních údajů, kontaktujte nás na e-mailu michal@cermatik.cz",
                      textAlign: TextAlign.justify,
                    ))
              ],
            )));
  }
}
