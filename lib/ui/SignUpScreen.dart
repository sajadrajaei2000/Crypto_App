import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:project3/ui/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';

import '../network/ResponseModel.dart';
import 'MainWrapper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObserved = false;
  final _keyForm = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //UserDataProvider? userProvider;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Lottie.asset('images/wave_loop.json',
                fit: BoxFit.fill, width: double.infinity, height: height * 0.2),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Sign Up',
                  style: GoogleFonts.ubuntu(
                      fontSize: height * 0.035,
                      color: Theme.of(context).unselectedWidgetColor)),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Create Account',
                  style: GoogleFonts.ubuntu(
                      fontSize: height * 0.030,
                      color: Theme.of(context).unselectedWidgetColor)),
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                  key: _keyForm,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'User name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter a name!';
                          } else if (value.length < 4) {
                            return 'enter a name more than 4 letter!';
                          } else if (value.length > 32) {
                            return 'enter a name less than 32 letter!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            hintText: 'Gmail',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter a Gmail!';
                          } else if (!value.endsWith('gmail.com') &&
                              !value.endsWith('yahoo.com')) {
                            return 'enter a valid gmail !';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        obscureText: _isObserved,
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_open),
                            suffixIcon: IconButton(
                              icon: Icon(_isObserved
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObserved = !_isObserved;
                                });
                              },
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'please enter a Password!';
                          } else if (value.length < 7) {
                            return 'password must be more than 7 letter!';
                          } else if (value.length > 32) {
                            return 'password must be less than 32 letter!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                        style: GoogleFonts.ubuntu(
                            fontSize: 15, height: 1.5, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Consumer<UserDataProvider>(
                          builder: (context, userDataProvider, child) {
                        switch (userDataProvider.registerStatus?.status) {
                          case Status.LOADING:
                            return const CircularProgressIndicator();
                          case Status.COMPLETED:
                            // savedLogin(userDataProvider.registerStatus?.data);
                            WidgetsBinding.instance.addPostFrameCallback(
                                (timeStamp) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MainWrapper())));
                            return signupBtn();
                          case Status.ERROR:
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                signupBtn(),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.error,
                                      color: Colors.redAccent,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      userDataProvider.registerStatus!.massege,
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.redAccent,
                                          fontSize: 15),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          default:
                            return signupBtn();
                        }
                      }),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget signupBtn() {
    final userProvider = Provider.of<UserDataProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.blue, width: 2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                backgroundColor: Colors.blue),
            onPressed: () {
              if (_keyForm.currentState!.validate()) {
                userProvider.callRegisterApi(nameController.text,
                    emailController.text, passwordController.text);
              }
            },
            child: Text(
              'Sign Up',
              style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 18),
            )),
      ),
    );
  }
}
