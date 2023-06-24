import 'package:demo_meal/presentation/controller/user_controller/user_cubit.dart';
import 'package:demo_meal/utils/dimension_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../widgets/big_text.dart';
import '../widgets/main_button.dart';


class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              // CustomAppBar(title: "Login"),
              SizedBox(
                height: scaleDimension.scaleHeight(100),
              ),
              _bodyBuilder(context),
            ],
          ),
        )),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        children: [
          _textFieldBuilder("Email", "Enter your email", emailController),
          SizedBox(
            height: scaleDimension.scaleHeight(30),
          ),
          _textFieldBuilder(
              "Password", "Enter your password", passwordController),
          SizedBox(
            height: scaleDimension.scaleHeight(70),
          ),
          SizedBox(
              width: scaleDimension.scaleHeight(100),
              child: MainButton(
                  title: "Login",
                  onTap: () async {
                   await login(context);
                    FocusManager.instance.primaryFocus?.unfocus();
                  })),
          SizedBox(
            height: scaleDimension.scaleHeight(70),
          ),
        ],
      ),
    );
  }

  Widget _textFieldBuilder(String title, String hint,
      TextEditingController controller) {
    return Container(
      width:
           scaleDimension.screenWidth - scaleDimension.scaleWidth(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BigText(text: title, size: scaleDimension.scaleWidth(18)),
          SizedBox(
            height: scaleDimension.scaleHeight(10),
          ),
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: scaleDimension.scaleWidth(10)),
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(scaleDimension.scaleWidth(16)),
                border: Border.all(color: Colors.grey[400]!, width: 1.5)),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                    fontSize: scaleDimension.scaleWidth(14),
                    color: Colors.grey[400]),
                border: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }

  login(BuildContext context)
  async {
  await BlocProvider.of<UserCubit>(context).signIn(emailController.text.trim(), passwordController.text.trim());
  Navigator.of(context).pop();
  }
}
