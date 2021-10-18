import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/utils/utils.dart';
import 'package:news_app/common/values/colors.dart';
import 'package:news_app/common/widgets/widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // logo
  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: duSetHeight(40)),
      child: Text(
        "Sing up",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: "Montserrat",
          fontWeight: FontWeight.w600,
          fontSize: duSetFontSize(24),
          height: 1
        ),
      ),
    );
  }

  // 注册表单
  Widget _buildInputForm() {
    return Container(
      width: duSetWidth(295),
      // height: 204,
      margin: EdgeInsets.only(top: duSetHeight(49)),
      child: Column(
        children: [
          // fullName input
          inputTextEdit(
            controller: _fullnameController,
            keyboardType: TextInputType.text,
            hintText: "Full name",
            marginTop: 0,
          ),
          // email input
          inputTextEdit(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            hintText: "Email",
          ),
          // password input
          inputTextEdit(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            hintText: "Password",
            isPassword: true,
          ),

          // 创建
          Container(
            height: duSetHeight(44),
            margin: EdgeInsets.only(top: duSetHeight(15)),
            child: btnElevatedButtonWidget(
              onPressed: () {
                if (!duCheckStringLength(_fullnameController.value.text, 5)) {
                  toastInfo(msg: '用户名不能小于5位');
                  return;
                }
                if (!duIsEmail(_emailController.value.text)) {
                  toastInfo(msg: '请正确输入邮件');
                  return;
                }
                if (!duCheckStringLength(_passController.value.text, 6)) {
                  toastInfo(msg: '密码不能小于6位');
                  return;
                }
                Navigator.pop(context);
              },
              width: 295,
              fontWeight: FontWeight.w600,
              title: "Create an account",
            ),
          ),
          // Spacer(),

          // Fogot password
          Container(
            // padding: EdgeInsets.fromLTRB(duSetWidth(8), 0, duSetWidth(8), 0),
            margin: EdgeInsets.only(top:duSetHeight(20)),
            alignment: Alignment.center,
            child: Container(
              // width: duSetWidth(duSetWidth(220)),
              alignment: Alignment.center,
              child: Text.rich(
                TextSpan(
                    text: 'By signing up you agree to our\n',
                    style: TextStyle(
                        color: Color.fromRGBO(45, 45, 47, 1),
                        fontSize: duSetWidth(16),
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        height: 1.375),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Terms',
                        style: TextStyle(
                          color: Color.fromRGBO(41, 103, 255, 1),
                            fontSize: duSetWidth(16),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            height: 1.375
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print(DateTime.now());
                          },
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            color: Color.fromRGBO(45, 45, 47, 1),
                            fontSize: duSetWidth(16),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            height: 1.375,

                        ),
                      ),
                      TextSpan(
                        text: 'Conditions of Use',
                        style: TextStyle(
                            color: Color.fromRGBO(41, 103, 255, 1),
                            fontSize: duSetWidth(16),
                            fontFamily: 'Avenir',
                            fontWeight: FontWeight.bold,
                            height: 1.375
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print(DateTime.now());
                          },
                      ),
                    ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 第三方
  Widget _buildThirdPartyLogin() {
    return Container(
      width: duSetWidth(295),
      margin: EdgeInsets.only(bottom: duSetHeight(88)),
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

  // 有账号
  Widget _buildHaveAccountButton() {
    return Container(
      margin: EdgeInsets.only(bottom: duSetHeight(60)),
      child: btnElevatedButtonWidget(
        onPressed: () {
          /// 跳转到注册页
          Navigator.pushNamed(
            context,
            "/sign-in",
          );
        },
        width: 294,
        backgroundColor: AppColors.secondaryElement,
        borderColor: AppColors.secondaryElement,
        fontColor: AppColors.primaryText,
        title: "I have an account",
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(''),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.info_outline,
              color: AppColors.primaryText,
            ),
            onPressed: () {
              toastInfo(msg: '这是注册界面');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Divider(height: 1),
            _buildLogo(),
            _buildInputForm(),
            Spacer(),
            _buildThirdPartyLogin(),
            _buildHaveAccountButton(),
          ],
        ),
      ),
    );
  }
}
