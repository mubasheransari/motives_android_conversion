import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:motives_android_conversion/Bloc/global_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/Features/dashboard_screen.dart';
import 'package:motives_android_conversion/Service/getDeviceId.dart';
import 'package:motives_android_conversion/widget/gradient_button.dart';
import 'package:motives_android_conversion/widget/gradient_text.dart';
import 'package:motives_android_conversion/widget/toast_widget.dart';

class LoginScreenDark extends StatefulWidget {
  const LoginScreenDark({super.key});

  @override
  State<LoginScreenDark> createState() => _LoginScreenDarkState();
}

class _LoginScreenDarkState extends State<LoginScreenDark> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  final LocalAuthentication auth = LocalAuthentication();
  String _authMessage = "Not authenticated";

  bool isAuthorized = false;

  Future<void> _authenticate() async {
    try {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );

      if (didAuthenticate) {
        setState(() {
          isAuthorized = true;
        });

        final box = GetStorage();
        var email = box.read("email_auth");
        var password = box.read("password-auth");

        context.read<GlobalBloc>().add(
          LoginEvent(email: email, password: password),
        );
        toastWidget("✅ Authentication Successful!", Colors.green);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      } else {
        toastWidget("❌ Authentication Failed!", Colors.red);
      }
    } catch (e) {
      debugPrint("Auth error: $e");
      toastWidget(
        "❌ Authentication Unsuccessful! Configure your security settings to continuet",
        Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final box = GetStorage();

    var check_email = box.read("email_auth");

    return Scaffold(
      appBar: AppBar(
        title: GradientText("Login".toUpperCase(), fontSize: 24),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Card(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.grey[200],
          elevation: 8,
          shadowColor: isDark
              ? Colors.purple.withOpacity(0.4)
              : Colors.grey.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Center(
                  child: Image.asset(
                    'assets/logo.png',
                    height: 110,
                    width: 110,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {},
                    child: GradientText("Welcome Back", fontSize: 20),
                  ),
                ),
                // GradientText("Welcome Back", fontSize: 20),
                const SizedBox(height: 20),
                _customTextField(
                  controller: emailController,
                  hint: "Email Address",
                  icon: Icons.email_outlined,
                  isDark: isDark,
                ),
                const SizedBox(height: 16),
                _customTextField(
                  controller: passwordController,
                  hint: "Password",
                  icon: Icons.lock_outline,
                  isPassword: true,
                  isDark: isDark,
                ),
                const SizedBox(height: 5),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                BlocConsumer<GlobalBloc, GlobalState>(
                  listener: (context, state) {
                    if (state.status == LoginStatus.success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                      );
                      toastWidget(
                        "✅ Authenticated Successfully!",
                        Colors.green,
                      );

                      box.write('isLoggedIn', true);
                    } else if (state.status == LoginStatus.failure) {
                      toastWidget("Incorrect Email or Password", Colors.red);
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      width: 160,
                      child: GradientButton(
                        text: state.status == LoginStatus.loading
                            ? "Loading..."
                            : "Login",
                        onTap: state.status == LoginStatus.loading
                            ? null
                            : () async {
                                final email = emailController.text.trim();
                                final password = passwordController.text.trim();
                                final emailRegex = RegExp(
                                  r'^[^@]+@[^@]+\.[^@]+',
                                );

                                print("EMAIL ::: $email");
                                print("PASSWORD ::: $password");

                                if (email.isEmpty || password.isEmpty) {
                                  toastWidget(
                                    "Please Enter Complete Form Data!",
                                    Colors.red,
                                  );
                                  return;
                                } else if (!emailRegex.hasMatch(email)) {
                                  toastWidget(
                                    "Please Enter Valid Email Address",
                                    Colors.red,
                                  );
                                } else {
                                  context.read<GlobalBloc>().add(
                                    LoginEvent(
                                      email: email,
                                      password: password,
                                    ),
                                  );
                                }
                                // context.read<GlobalBloc>().add(
                                //   LoginEvent(email: email, password: password),
                                // );

                                Focus.of(context).unfocus();
                              },
                      ),
                    );
                  },
                ),

                check_email != null
                    ? Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "OR",
                            style: TextStyle(color: Colors.cyan),
                          ),
                        ),
                      )
                    : SizedBox(),
                check_email != null
                    ? InkWell(
                        onTap: () {
                          _authenticate();
                        },
                        child: SizedBox(
                          height: 55,
                          width: 60,
                          child: Image.asset(
                            "assets/faceid_icon.png",
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      )
                    : SizedBox(),

                const SizedBox(height: 12),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Version 1.1.0",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    required bool isDark,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.grey),
        prefixIcon: Icon(icon, color: Colors.cyan),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: isDark ? Colors.white54 : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: isDark ? const Color(0xFF2A2A2A) : Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
