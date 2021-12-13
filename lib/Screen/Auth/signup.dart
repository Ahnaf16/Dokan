import 'package:dokan/Screen/Auth/signin.dart';
import 'package:dokan/Screen/Auth/userform.dart';
import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/texts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dokan/export.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({Key? key}) : super(key: key);

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  //TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //TextEditingController _confirmPasswordController = TextEditingController();

  signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const UserForm()));
      } else {
        Fluttertoast.showToast(msg: 'Something is Wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: const Padding(
                padding: EdgeInsets.all(30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: AppTextStyle.headerStyle,
                  ),
                ),
              ),
            ),
            //-----------------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextfieldHint(
                    hint: 'User Name',
                  ),
                  // Textfields(
                  //     isPassword: false,
                  //     needSaffixIcon: false,
                  //     inputTypes: TextInputType.emailAddress,
                  //     textControl: _nameController),
                  const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  const TextfieldHint(
                    hint: 'Email',
                  ),
                  // Textfields(
                  //     isPassword: false,
                  //     //needSaffixIcon: false,
                  //     inputTypes: TextInputType.emailAddress,
                  //     textControl: _emailController),
                  Textfields(
                    TextInputType.emailAddress,
                    _emailController,
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  const TextfieldHint(
                    hint: 'Password',
                  ),
                  // Textfields(
                  //     isPassword: true,
                  //     //needSaffixIcon: true,
                  //     inputTypes: TextInputType.visiblePassword,
                  //     textControl: _passwordController),
                  TextfieldPass(
                    false,
                    TextInputType.visiblePassword,
                    _passwordController,
                  ),
                  const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                  const TextfieldHint(
                    hint: 'Confirm Password',
                  ),
                  // Textfields(
                  //     isPassword: true,
                  //     needSaffixIcon: true,
                  //     inputTypes: TextInputType.visiblePassword,
                  //     textControl: _confirmPasswordController),
                  const Divider(
                    color: Colors.transparent,
                    height: 10,
                  ),
                ],
              ),
            ),
            //-----------------------------------------------------------------
            const Divider(
              color: Colors.transparent,
              height: 150,
            ),

            Column(
              children: [
                PrimaryButton(
                  buttonText: 'Sign Up',
                  gotoPage: () {
                    signUp();
                  },
                ),

                //-----------------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Richtexts(
                    firstText: 'Already have an account? ',
                    secText: 'Sign In',
                    roughtpage: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SinginPage(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
