import 'package:dokan/Properties/app_properties.dart';
import 'package:dokan/Properties/export.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppColor.appMainColor,
          ),
        ),
        backgroundColor: AppColor.appBackground,
        shadowColor: AppColor.appBackground,
        elevation: 0,
      ),
//-----------------------------------------------------------------
      body: Column(
        children: [
          SizedBox(
            //color: Colors.amber,
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: const Padding(
              padding: EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Restore Password',
                  style: AllTextStyle.headerStyle,
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
                  hint: 'Email',
                ),
                // Textfields(
                //     isPassword: false,
                //     //needSaffixIcon: false,
                //     inputTypes: TextInputType.emailAddress,
                //     textControl: _passwordController),
                Textfields(
                  TextInputType.emailAddress,
                  _emailController,
                ),
                const Divider(
                  height: 10,
                ),
              ],
            ),
          ),
//-----------------------------------------------------------------
          const Divider(
            height: 150,
          ),
          PrimaryButton(
            buttonText: 'Restore password',
            gotoPage: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
