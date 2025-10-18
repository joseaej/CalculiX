import 'package:calculix/core/config/app_colors.dart';
import 'package:calculix/core/shared_widgets/linear_divider.dart';
import 'package:calculix/core/shared_widgets/principal_rectangular_button.dart';
import 'package:calculix/core/shared_widgets/rectangular_text_form_field.dart';
import 'package:calculix/core/shared_widgets/wave_clipper.dart';
import 'package:calculix/data/models/auth_state.dart';
import 'package:calculix/presentation/auth/auth_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      } else if (next.status == AuthStatus.authenticated) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });

    IconData visibilityIcon = obscureText
        ? Icons.visibility
        : Icons.visibility_off;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  rectangularTextField(controller: _emailController),
                  SizedBox(height: 2.h),
                  rectangularTextField(
                    controller: _usernameController,
                    label: "Username",
                    hintText: "Username",
                    prefixIcon: Icons.person,
                  ),
                  SizedBox(height: 2.h),
                  rectangularPasswordTextField(
                    controller: _passwordController,
                    obscureText: obscureText,
                    icon: Icon(visibilityIcon),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  SizedBox(height: 2.h),
                  principalRectangularButton(
                    context: context,
                    onPressed: () {
                      ref
                          .read(authNotifierProvider.notifier)
                          .signUp(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            username: _usernameController.text.trim(),
                          );
                      if (ref.read(authNotifierProvider).status ==
                          AuthStatus.authenticated) {
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    },
                  ),
                  SizedBox(height: 5.h),
                  lineWithText(text: "Or"),
                  SizedBox(height: 3.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Image.asset(
                          "assets/icons/google_logo.png",
                          width: 12.w,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    const double validWaveHeightFactor = 0.15;

    return ClipPath(
      clipper: WaveClipper(waveHeightFactor: validWaveHeightFactor),
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.primaryBlue,
          image: DecorationImage(
            image: AssetImage("assets/images/background_container_login2.png"),
            fit: BoxFit.fill,
            opacity: 0.4,
          ),
        ),
        child: Center(
          child: Text(
            'CalculiX',
            style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
