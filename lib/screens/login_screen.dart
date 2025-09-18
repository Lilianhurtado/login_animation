import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StateMachineController? controller;
  SMIBool? isChecking;
  SMIBool? isHandsUp;
  SMITrigger? trigSuccess;
  SMITrigger? trigFail;
  SMIInput? numLook;

  bool isPasswordVisible = false;

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Timer? _debounce;
  bool riveReady = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(emailFocus);
    });
  }

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    emailController.dispose();
    passwordController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onEmailTyping(String value) {
    if (numLook != null) numLook!.value = value.length.toDouble();
    if (isChecking != null) isChecking!.change(true);
    if (isHandsUp != null) isHandsUp!.change(false);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      if (isChecking != null) isChecking!.change(false);
    });
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (isChecking != null) isChecking!.change(false);
    if (isHandsUp != null) isHandsUp!.change(false);

    if (!riveReady) return;

    String email = emailController.text;
    String password = passwordController.text;

    if (email == "lilian@gmail.com" && password == "7710") {
      if (trigSuccess != null) trigSuccess!.fire();
    } else {
      if (trigFail != null) trigFail!.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (isChecking != null) isChecking!.change(false);
        if (isHandsUp != null) isHandsUp!.change(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width,
                  height: 200,
                  child: RiveAnimation.asset(
                    'animated_login_character.riv',
                    stateMachines: ["Login Machine"],
                    onInit: (artboard) {
                      controller = StateMachineController.fromArtboard(
                        artboard,
                        "Login Machine",
                      );
                      if (controller == null) return;
                      artboard.addController(controller!);

                      // Pequeño delay para asegurar que los triggers estén listos
                      Future.delayed(Duration(milliseconds: 100), () {
                        numLook = controller!.findSMI("numLook");
                        isChecking = controller!.findSMI('isChecking');
                        isHandsUp = controller!.findSMI('isHandsUp');
                        trigSuccess = controller!.findSMI('trigSuccess');
                        trigFail = controller!.findSMI('trigFail');
                        setState(() {
                          riveReady = true;
                        });
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  onTap: () {
                    if (isHandsUp != null) isHandsUp!.change(false);
                    if (isChecking != null) isChecking!.change(true);
                  },
                  onChanged: _onEmailTyping,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: passwordController,
                  focusNode: passwordFocus,
                  onTap: () {
                    if (isChecking != null) isChecking!.change(false);
                    if (isHandsUp != null) isHandsUp!.change(true);
                  },
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                SizedBox(
                  width: size.width,
                  child: const Text(
                    "Forgot your Password?",
                    textAlign: TextAlign.right,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 10),

                MaterialButton(
                  minWidth: size.width,
                  height: 50,
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: riveReady ? _handleLogin : null,
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
