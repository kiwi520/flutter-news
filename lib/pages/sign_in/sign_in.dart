import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/api/user.dart';
import 'package:news_app/common/entity/user_login_request_entity.dart';
import 'package:news_app/common/entity/user_login_response_entity.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/values.dart';
import 'package:news_app/common/widgets/widgets.dart';
import 'package:news_app/global.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //email的控制器
  final TextEditingController _emailController = TextEditingController();

  //密码的控制器
  final TextEditingController _passController = TextEditingController();

  // logo
  Widget _buildLogo() {
    return Container(
      width: duSetWidth(110),
      margin: EdgeInsets.only(top: duSetHeight(40 + 44.0)), // 顶部系统栏 44px
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: duSetWidth(76),
            width: duSetWidth(76),
            margin: EdgeInsets.symmetric(horizontal: duSetWidth(17)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                    height: duSetWidth(76),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBackground,
                      boxShadow: [
                        Shadows.primaryShadow,
                      ],
                      borderRadius: BorderRadius.all(
                          Radius.circular(duSetWidth(38))), // 父容器的50%
                    ),
                    child: Container(),
                  ),
                ),
                Positioned(
                  top: duSetWidth(13),
                  child: Image.asset(
                    "assets/images/Logo.png",
                    fit: BoxFit.none,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Text(
              "SECTOR",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w600,
                fontSize: duSetFontSize(24),
                height: 1,
              ),
            ),
          ),
          Text(
            "news",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: duSetFontSize(16),
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  /// 登录操作
  _handleSignIn() async {
    if(!duIsEmail(_emailController.value.text)){
      toastInfo(msg:'请正确输入邮件');
      return;
    }

    if(!duCheckStringLength(_passController.value.text,6)){
      toastInfo(msg:'密码不能少于6位');
      return;
    }

    UserLoginRequestEntity userLoginRequestEntity = UserLoginRequestEntity(
        email: _emailController.value.text,
        password: duSHA256(_passController.value.text)
    );

    UserLoginResponseEntity userLoginResponseEntity = await UserAPI.login(params: userLoginRequestEntity, context: context);

    Global.saveProfile(userLoginResponseEntity);
    
    // print('StorageUtil.getMap(STORAGE_USER_PROFILE_KEY)');
    // print(StorageUtil.getMap(STORAGE_USER_PROFILE_KEY));
    // print('StorageUtil.getMap(STORAGE_USER_PROFILE_KEY)');

    // Navigator.pushNamed(context, "/app");
    // AutoRouter.of(context).pushNamed('/application-page');
    context.router.pushNamed('/application-page');
  }

  /// 跳转到注册页面
  _handleNavSignUp(){
    Navigator.pushNamed(context, "/sign-up");
  }

  // 登录表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(top: duSetHeight(49)),
      // decoration: BoxDecoration(
      //   color: AppColors.secondaryElement,
      //   borderRadius: Radii.k6pxRadius
      // ),
      child: Column(
        children: [
          inputTextEdit(
            controller: _emailController,
            hintText: 'Email',
            marginTop: 0,
          ),
          inputTextEdit(
            controller: _passController,
            hintText: 'Password',
            isPassword: true,
          ),
          Container(
            height: duSetWidth(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: Row(
              children: [
                /// 注册
                btnElevatedButtonWidget(
                  onPressed: _handleNavSignUp,
                  title: "Sign up",
                  foregroundColor: AppColors.thirdElement,
                  backgroundColor: AppColors.thirdElement,
                  borderColor: AppColors.thirdElement,
                ),
                Spacer(),

                /// 登录
                btnElevatedButtonWidget(
                  onPressed: _handleSignIn,
                  title: "Sign in",
                  foregroundColor: AppColors.secondaryElementText,
                  backgroundColor: AppColors.secondaryElementText,
                  borderColor: AppColors.secondaryElementText,
                ),
              ],
            ),
          ),
          // Fogot password
          Container(
            height: duSetHeight(22),
            margin: EdgeInsets.only(top: duSetHeight(20)),
            child: Text.rich(TextSpan(
              text: 'Fogot password?',
              style: TextStyle(
                color: AppColors.secondaryElementText,
                fontFamily: "Avenir",
                fontWeight: FontWeight.w400,
                fontSize: duSetFontSize(16),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(DateTime.now());
                },
            )),
          ),
        ],
      ),
    );
  }

  // 第三方登录
  Widget _buildThirdPartyLogin() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(bottom: duSetHeight(40)),
      child: Column(
        children: <Widget>[
          // title
          Text(
            "Or sign in with social networks",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontWeight: FontWeight.w400,
              fontSize: duSetFontSize(16),
            ),
          ),
          // 按钮
          Padding(
            padding: EdgeInsets.only(top: duSetHeight(20)),
            child: Row(
              children: <Widget>[
                btnElevatedButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 88,
                  iconFileName: "twitter",
                ),
                Spacer(),
                btnElevatedButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 88,
                  iconFileName: "google",
                ),
                Spacer(),
                btnElevatedButtonBorderOnlyWidget(
                  onPressed: () {},
                  width: 88,
                  iconFileName: "facebook",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 注册按钮
  Widget _buildSignupButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(60)),
      child: btnElevatedButtonWidget(
        onPressed: _handleNavSignUp,
        width: 294,
        backgroundColor: AppColors.secondaryElement,
        borderColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "Sign up",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            _buildLogo(),
            _buildInputForm(),
            Spacer(),
            _buildThirdPartyLogin(),
            _buildSignupButton(),
          ],
        ),
      ),
    );
  }
}
