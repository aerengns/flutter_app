import 'package:drive_or_drunk_app/config/routes.dart';
import 'package:drive_or_drunk_app/core/theme/theme_provider.dart';
import 'package:drive_or_drunk_app/features/authentication/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool rememberMeChecked = false;

  @override
  void initState() {
    super.initState();

    // Create an animation controller with a duration of 1 second
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    // Define an animation that scales the image from 1.0 to 0.4
    _animation = Tween<double>(begin: 4.0, end: 2.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await context.read<AuthProvider>().signIn(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            );
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      } catch (e) {
        // Show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // title: const Text('Login'),
        actions: [
          IconButton(
            icon: Icon(
                context.watch<ThemeProvider>().themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
            onPressed: () {
              context.read<ThemeProvider>().toggleTheme();
            },
          ),
        ],
      ),
      body: Column(children: [
        ClipPath(
          clipper: WavyClipper(),
          child: Container(
            color: Colors.blue, //TODO: fix color
            child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                      scale: _animation.value,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/logos/logo_android12.png',
                          width: 150,
                        ),
                      ));
                }),
          ),
        ),
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffffc953),
                            width: 1.5), //TODO: fix color
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffffc953), width: 2)),
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter an email' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xffffc953),
                            width: 1.5), //TODO: fix color
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffffc953), width: 2)),
                      fillColor: Colors.white,
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a password' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //TODO implement theese
                      Row(
                        children: [
                          Checkbox(
                              value: rememberMeChecked,
                              onChanged: (value) {
                                setState(() {
                                  rememberMeChecked = value ?? false;
                                });
                              }),
                          const Text('Remember me'),
                        ],
                      ),
                      const Text('Forget Password?'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: const Size(400, 60),
                        backgroundColor: Colors.blue),
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Don’t have an account?'),
                      const SizedBox(width: 0),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.register);
                        },
                        child: const Text('SIGN UP',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),

                  // ElevatedButton(
                  //   onPressed: _isLoading
                  //       ? null
                  //       : () {
                  //           context.read<AuthProvider>().signInWithGoogle();
                  //         },
                  //   child: Text('Sign in with Google'),
                  // ),
                  // ElevatedButton(
                  //   onPressed: _isLoading
                  //       ? null
                  //       : () {
                  //           context.read<AuthProvider>().signInWithFacebook();
                  //         },
                  //   child: Text('Sign in with Facebook'),
                  // ),
                ],
              ),
            )),
      ]),
    );
  }
}

// Custom Clipper for Wavy Shape
class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0, size.height);

    final firstCurve = Offset(0, size.height - 50);
    final lastCurve = Offset(50, size.height - 50);
    path.quadraticBezierTo(
        firstCurve.dx, firstCurve.dy, lastCurve.dx, lastCurve.dy);

    final secondFirstCurve = Offset(0, size.height - 50);
    final secondLastCurve = Offset(size.width - 50, size.height - 50);
    path.quadraticBezierTo(secondFirstCurve.dx, secondFirstCurve.dy,
        secondLastCurve.dx, secondLastCurve.dy);

    final thirdFirstCurve = Offset(size.width, size.height - 50);
    final thirdLastCurve = Offset(size.width + 5, size.height - 100);
    path.quadraticBezierTo(thirdFirstCurve.dx, thirdFirstCurve.dy,
        thirdLastCurve.dx, thirdLastCurve.dy);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
