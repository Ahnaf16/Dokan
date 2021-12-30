// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables
import 'package:dokan/Properties/export.dart';
import 'package:dokan/services/firebasefirestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignUpPage extends StatefulWidget {
  //

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
//
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

//----------------------------signup-------------------------------------

  Future signUp() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      userCredential.user!.updateDisplayName(_nameController.text);
      //  userCredential.user!.

      var authCredential = userCredential.user;
      if (authCredential!.uid.isNotEmpty) {
        Navigator.pop(context);
      } else {
        error = 'Something is Wrong';
      }
      // widget.onLogIn(userCredential.user);
    } on FirebaseException catch (e) {
      setState(() {
        error = e.message!;
        if (e.code == 'email-already-in-use') {
          error = 'The account already exists for that email.';
        }
      });
    }
  }

  User? user;
  String? userName;
  String? userMail;
  String? phone;
  String? address;

  String error = '';
  String password = '';
  bool isloading = false;
  bool isPassword = true;
  bool isPassword2 = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: formkey,
            child: Column(
              children: [
                cDivider(100),

                Text(
                  'Sign Up',
                  style: AppTextStyle.headerStyle,
                ),

                cDivider(100),
//----------------------------name-------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    //onChanged: (value) => userName = value,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.bodyTextStyle,
                    decoration: textfilesStyle('Name'),
                  ),
                ),

//----------------------------email-------------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    //onChanged: (value) => userMail = value,
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: EmailValidator(errorText: 'Invalid Email'),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppTextStyle.bodyTextStyle,
                    decoration: textfilesStyle('Email'),
                  ),
                ),

//----------------------------password-------------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.disabled,
                    onChanged: (value) => password = value,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(6,
                          errorText: 'password must be at least 8 digits long')
                    ]),
                    controller: _passwordController,
                    obscureText: isPassword,
                    style: AppTextStyle.bodyTextStyle,
                    decoration: textfilesStyle('Password').copyWith(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(
                            () {
                              isPassword = !isPassword;
                            },
                          );
                        },
                        child: Icon(
                          isPassword ? Icons.visibility_off : Icons.visibility,
                          color: AppColor.appMainColor,
                        ),
                      ),
                    ),
                  ),
                ),

//----------------------------confirm password-------------------------------------

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    validator: (value) =>
                        MatchValidator(errorText: 'Passwod did\'t match')
                            .validateMatch(value!, password),
                    controller: _confirmPassController,
                    obscureText: isPassword,
                    style: AppTextStyle.bodyTextStyle,
                    decoration: textfilesStyle('Confirm Password').copyWith(
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(
                            () {
                              isPassword2 = !isPassword2;
                            },
                          );
                        },
                        child: Icon(
                          isPassword2 ? Icons.visibility_off : Icons.visibility,
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

                OutlinedButton(
                  onPressed: () async {
                    if (isloading) return;
                    setState(() {
                      isloading = true;
                    });
                    if (formkey.currentState!.validate()) {
                      await signUp();
                      sendUserNameDB(_nameController.text,
                          _emailController.text, phone, address);
                    }
                    isloading = false;
                  },
                  style: buttonStyle,
                  child: isloading
                      ? CircularProgressIndicator(
                          color: AppColor.appMainColor,
                        )
                      : Text(
                          'Sign Up',
                          style: AppTextStyle.bodyTextStyle,
                        ),
                ),

                cDivider(8),

                Richtexts(
                  firstText: 'Already have an account? ',
                  secText: 'Log In',
                  roughtpage: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
