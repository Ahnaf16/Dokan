// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:dokan/Properties/export.dart';
import 'package:dokan/Screen/Auth/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  //
  final Function(User?) onLogIn;
  LoginPage({required this.onLogIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //----------------------------guest Login-------------------------------------

  Future guestLogIn() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    widget.onLogIn(userCredential.user);
  }

//------------------------------------------------------------------------------

  Future logIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;

      if (authCredential!.uid.isNotEmpty) {
        error = 'Login success';
      } else {
        error = 'Something is Wrong';
      }
      widget.onLogIn(userCredential.user);
    } on FirebaseException catch (e) {
      setState(() {
        error = e.message!;
        if (e.code == 'user-not-found') {
          error = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          error = 'Wrong password provided for that user.';

          if (e.message == 'Given String is empty or null') {
            error = 'Please enter a email';
          }
        }
      });
    }
  }

  onSignUp(userCred) {
    setState(() {
      user = userCred;
      widget.onLogIn(user);
    });
  }

  String error = '';
  User? user;
  bool isloading = false;
  bool loginLoading = false;
  bool isPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              cDivider(100),

              Text(
                'Log In',
                style: AppTextStyle.headerStyle,
              ),

              cDivider(100),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: AppTextStyle.bodyTextStyle,
                  decoration: textfilesStyle('Email'),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText: isPassword,
                  style: AppTextStyle.bodyTextStyle,
                  decoration: textfilesStyle('Password').copyWith(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      },
                      icon: Icon(
                        isPassword ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.appMainColor,
                      ),
                    ),
                  ),
                ),
              ),

              cDivider(5),

              Text(
                error,
                style: AppTextStyle.errorText,
              ),

              cDivider(50),

              //----------------------------button-------------------------------------

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () async {
                        if (loginLoading) return;
                        setState(() {
                          loginLoading = true;
                        });
                        await logIn();
                        loginLoading = false;
                      },
                      style: buttonStyle,
                      child: loginLoading
                          ? CircularProgressIndicator(
                              color: AppColor.appMainColor,
                            )
                          : Text(
                              'Log In',
                              style: AppTextStyle.bodyTextStyle,
                            ),
                    ),
                    // OutlinedButton(
                    //   onPressed: () async {
                    //     if (isloading) return;
                    //     setState(() {
                    //       isloading = true;
                    //     });
                    //     await guestLogIn();
                    //   },
                    //   style: buttonStyle,
                    //   child: isloading
                    //       ? CircularProgressIndicator(
                    //           color: AppColor.appMainColor,
                    //         )
                    //       : Text(
                    //           'Guest LogIn',
                    //           style: AppTextStyle.bodyTextStyle,
                    //         ),
                    // ),
                  ],
                ),
              ),

              cDivider(8),

              Richtexts(
                firstText: 'Don\'t have an account? ',
                secText: 'Sign Up',
                roughtpage: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpPage(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
