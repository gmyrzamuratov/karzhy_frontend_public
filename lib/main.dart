import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:karzhy_frontend/firebase_options.dart';
import 'package:karzhy_frontend/functions/catalogs/bank/list/view/bank_list_view.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/add/view/add_bank_account_view.dart';
import 'package:karzhy_frontend/functions/catalogs/bank_account/list/view/bank_account_list.dart';
import 'package:karzhy_frontend/functions/catalogs/client/add/view/add_client_view.dart';
import 'package:karzhy_frontend/functions/catalogs/client/list/view/client_list_view.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/add/view/add_contract_view.dart';
import 'package:karzhy_frontend/functions/catalogs/contract/list/view/contract_list.dart';
import 'package:karzhy_frontend/functions/invoice/invoice_preview/view/invoice_preview_view.dart';
import 'package:karzhy_frontend/functions/invoice/new_invoice/view/invoice_view.dart';
import 'package:karzhy_frontend/functions/unknown/view/unknown_view.dart';
import 'package:karzhy_frontend/models/invoice.dart';

import 'functions/login/binding/login_binding.dart';
import 'functions/login/view/login_view.dart';
import 'functions/sign_up/binding/sign_up_binding.dart';
import 'functions/sign_up/view/sign_up_view.dart';
import 'functions/splash/view/splash_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      unknownRoute: GetPage(name: '/notfound', page: () => UnknownView()),
      debugShowCheckedModeBanner: false,
      title: 'Karzhy',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: () => SplashView()),
        GetPage(name: "/login", page: () => LoginView(), binding: LoginBinding()),
        GetPage(name: "/sign_up", page: () => SignUpView(), binding: SignUpBinding()),
        GetPage(name: InvoiceView.routeNamed, page: () => InvoiceView()),
        GetPage(name: AddClientView.routeNamed, page: () => const AddClientView()),
        GetPage(name: ClientListView.routeNamed, page: () => ClientListView()),
        GetPage(name: BankAccountListView.routeNamed, page: () => BankAccountListView()),
        GetPage(name: AddBankAccountView.routeNamed, page: () => const AddBankAccountView()),
        GetPage(name: BankListView.routeNamed, page: () => BankListView()),
        GetPage(name: ContractListView.routeNamed, page: () => ContractListView()),
        GetPage(name: AddContractView.routeNamed, page: () => const AddContractView()),
        GetPage(name: InvoicePreviewView.routeNamed, page: () => InvoicePreviewView()),
      ],
      //initialRoute: "/login",
    );
  }
}