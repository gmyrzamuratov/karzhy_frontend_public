import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/adaptive_scaffold.dart';
import '../controller/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const welcomeImage = './assets/images/welcome.jpg';
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _passwordConfirmationController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdaptiveScaffold(
        compact: CompactView(
            welcomeImage: welcomeImage,
            emailController: _emailController,
            passwordController: _passwordController,
            passwordConfirmationController: _passwordConfirmationController,
            formKey: _formKey),
        full: FullView(
            welcomeImage: welcomeImage,
            emailController: _emailController,
            passwordController: _passwordController,
            passwordConfirmationController: _passwordConfirmationController,
            formKey: _formKey),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final controller = Get.put(SignUpController());

  var oldLen = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.isRegistered == true
        ? Column(
        children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Рақмет. Сізді тіркедік",
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(1024, 60),
              ),
              child: const Text(
                'Жалғастыру',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ])
        : Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Қош келдіңіз',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Form(
                  key: widget._formKey,
                  child: Column(children: [
                    TextFormField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          hintText: 'Email'),
                      onChanged: (text) {},
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: widget.passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Құпиясөз',
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: widget.passwordConfirmationController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        labelText: 'Құпиясөзді растаңыз',
                      ),
                      obscureText: true,
                    )
                  ]),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    String _email = widget.emailController.text;
                    controller.register(_email, widget.passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: const Size(1024, 60),
                  ),
                  child: const Text(
                    'Тіркелу',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 50.0)
              ],
            ),
          ));
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({
    Key? key,
    required this.welcomeImage,
  }) : super(key: key);

  final String welcomeImage;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(welcomeImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 24,
          child: Text(
            'Тіркелу',
            maxLines: 2,
            style: textTheme.headline4!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 24,
          left: 24,
          child: Row(
            children: [
              const Icon(
                Icons.sunny_snowing,
                color: Colors.white,
                size: 30,
              ),
              const SizedBox(width: 8),
              Text(
                'Karzhy',
                maxLines: 2,
                style: textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CompactView extends StatelessWidget {
  const CompactView({
    Key? key,
    required this.welcomeImage,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: HeroImage(welcomeImage: welcomeImage),
            ),
            SignUpForm(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
                passwordConfirmationController: passwordConfirmationController),
          ],
        );
      }),
    );
  }
}

class FullView extends StatelessWidget {
  const FullView({
    Key? key,
    required this.welcomeImage,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final String welcomeImage;
  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Row(
        children: [
          Flexible(
              child: SignUpForm(
                  formKey: _formKey,
                  emailController: emailController,
                  passwordController: passwordController,
                  passwordConfirmationController:
                      passwordConfirmationController)),
          Flexible(
            child: HeroImage(welcomeImage: welcomeImage),
          ),
        ],
      );
    });
  }
}
