import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entity/user.dart';
import '../../../utils/dimension_scale.dart';
import '../../../utils/routes.dart';
import '../../controller/user_controller/user_cubit.dart';

import '../widgets/big_text.dart';
import '../widgets/main_button.dart';
import '../widgets/normal_text.dart';

class ProfilePage extends StatelessWidget {
  Dimension scaleDimension = GetIt.instance.get<Dimension>();
  User? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _appBarBuilder(),
            _bodyBuilder(context),
          ],
        ),
      ),
    );
  }

  Widget _appBarBuilder() {
    return Column(
      children: [
        SizedBox(
          height: scaleDimension.scaleHeight(20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: scaleDimension.scaleWidth(50),
            ),
            BigText(text: "Profile"),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return (state is UserInfoLoaded)
                    ? IconButton(
                        onPressed: () {
                          BlocProvider.of<UserCubit>(context).signOut();
                        },
                        icon: Icon(Icons.logout_outlined))
                    : Container(width: scaleDimension.scaleWidth(50));
              },
            )
          ],
        ),
        SizedBox(
          height: scaleDimension.scaleHeight(20),
        ),
      ],
    );
  }

  Widget _bodyBuilder(BuildContext context) {
    bool isLogin = false;
    //
    return BlocBuilder<UserCubit, UserState>(builder: (context, state) {
      if (state is UserInfoLoaded) {
        isLogin = true;
        user = state.user;
      }
      if (state is UserLoggedOut) isLogin = false;
      return isLogin ? loggedPage(context) : unLoggedPage(context);
    });
  }

  Widget loggedPage(BuildContext context) {
    // draw ui related to logged in user
    return Padding(
      padding: EdgeInsets.all(scaleDimension.scaleWidth(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: scaleDimension.scaleHeight(50),
          ),
          loggedPageItem("Name", user!.name),
          loggedPageItem("Email", user!.email),
          loggedPageItem("Phone", user!.phone),
          loggedPageItem("address", user!.address),
          SizedBox(
            height: scaleDimension.scaleHeight(100),
          ),
          (user!.level == 0)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainButton(
                        title: "Make Sale",
                        onTap: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamed(Routes.salePage);
                        })
                  ],
                )
              : Container()
        ],
      ),
    );
  }

  Widget unLoggedPage(BuildContext context) {
    // page that will appear when user not logged in
    return SizedBox(
      height: scaleDimension.screenHeight - scaleDimension.scaleHeight(150),
      child: Center(
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true)
                .pushNamed(Routes.loginPage);
          },
          child: Container(
            width: scaleDimension.screenWidth - scaleDimension.scaleWidth(30),
            height: scaleDimension.scaleHeight(100),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius:
                    BorderRadius.circular(scaleDimension.scaleWidth(20))),
            child: Center(
                child: BigText(text: "Sign In", size: 40, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget loggedPageItem(String title, String value) {
    // user info item template
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          text: title,
          color: Colors.grey,
        ),
        SizedBox(
          height: scaleDimension.scaleHeight(10),
        ),
        NormalText(text: value),
        SizedBox(
          height: scaleDimension.scaleHeight(20),
        )
      ],
    );
  }
}
