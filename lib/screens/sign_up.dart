import 'package:esgi_project/components/custom_textfield.dart';
import 'package:esgi_project/components/loader.dart';
import 'package:esgi_project/components/logo.dart';
import 'package:esgi_project/components/round_btn.dart';
import 'package:esgi_project/controllers/auth_controller.dart';
import 'package:esgi_project/localization/localization.dart';
import 'package:esgi_project/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_validator/the_validator.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            // enleve clavier si clique ailleurs
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: EdgeInsets.only(left: 30.0, right: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Logo(),
                    _buildEmailField(),
                    SizedBox(height: 10.0),
                    _buildPseudoField(),
                    SizedBox(height: 10.0),
                    _buildPasswordField(),
                    SizedBox(height: 10.0),
                    _buildCheckBoxOrganizer(),
                    _buildSignUpBtn(),
                    _buildChangeToSignInFormBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
        keyboardType: TextInputType.emailAddress,
        controller: AuthController.to.emailController,
        suffixIcon: Icon(Icons.email, color: ConstantColor.white),
        hintText: Localization.yourEmail.tr,
        validator: AuthController.to.emailValidator());
  }

  Widget _buildPseudoField() {
    return CustomTextField(
      controller: AuthController.to.pseudoController,
      suffixIcon: Icon(Icons.person, color: ConstantColor.white),
      hintText: Localization.yourNickname.tr,
      validator:
          FieldValidator.minLength(3, message: Localization.errorPseudo.tr),
    );
  }

  Widget _buildPasswordField() {
    return CustomTextField(
      obscureText: true,
      controller: AuthController.to.passwordController,
      suffixIcon: Icon(
        Icons.lock,
        color: ConstantColor.white,
      ),
      hintText: Localization.yourPassword.tr,
      validator: FieldValidator.password(
        minLength: 6,
        errorMessage: Localization.errorPassword.tr,
      ),
    );
  }

  Widget _buildCheckBoxOrganizer() {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return CheckboxListTile(
          title: Text(
            Localization.isOrganizerTitle.tr,
            style: TextStyle(color: ConstantColor.white),
          ),
          value: controller.isOrganizerCheckbox,
          onChanged: (newValue) => controller.changeIsOrganizerCheck(newValue),
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: ConstantColor.primaryColor,
        );
      },
    );
  }

  Widget _buildSignUpBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: GetBuilder<AuthController>(
        builder: (controller) {
          return RoundBtn(
            child: controller.isLoading
                ? Loader(
                    width: 25,
                    height: 25,
                  )
                : Text(
                    Localization.signUpTitle.tr,
                    style: TextStyle(
                        color: ConstantColor.backgroundColor,
                        fontWeight: FontWeight.w500),
                  ),
            onPressed: () {
              if (_formKey.currentState.validate()) AuthController.to.signUp();
            },
          );
        },
      ),
    );
  }

  Widget _buildChangeToSignInFormBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 50),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          height: 50,
          child: Center(
            child:
                Text(Localization.signInTitle.tr, style: Get.textTheme.caption),
          ),
        ),
      ),
    );
  }
}
