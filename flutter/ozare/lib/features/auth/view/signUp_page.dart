import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare/styles/common/const_strings.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: size.width < 500 ? null : 500,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.04),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.createAccount,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Form(
                    key: formKey,
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InputField(
                              controller: firstNameController,
                              hintText: l10n.enterYourFirstName,
                              labelText: l10n.firstName,
                            ),
                            const SizedBox(height: 16),
                            InputField(
                              controller: lastNameController,
                              hintText: l10n.enterYourLastName,
                              labelText: l10n.lastName,
                            ),
                            const SizedBox(height: 16),
                            InputField(
                              controller: emailController,
                              hintText: l10n.enterYourEmailAddress,
                              labelText: l10n.emailAddress,
                              textInputType: TextInputType.emailAddress,
                              validator: (val) =>
                                  Validators.emailValidator(val!),
                              inputFormatters: [
                                InputFormatters.spaceNotAllowed,
                              ],
                            ),
                            const SizedBox(height: 16),
                            InputField(
                              controller: passwordController,
                              hintText: l10n.enterYourPassword,
                              labelText: l10n.password,
                              isPassword: true,
                              maxLines: 1,
                              textInputType: TextInputType.visiblePassword,
                              validator: (val) =>
                                  Validators.passwordValidator(val!),
                              inputFormatters: [
                                InputFormatters.spaceNotAllowed,
                              ],
                            ),
                            const SizedBox(height: 16),
                            InputField(
                              controller: confirmPasswordController,
                              hintText: l10n.enterYourPassword,
                              labelText: l10n.confirmPassword,
                              isPassword: true,
                              maxLines: 1,
                              validator: (val) =>
                                  Validators.confirmPasswordValidator(
                                      passwordController.text, val!,),
                              textInputType: TextInputType.visiblePassword,
                              inputFormatters: [
                                InputFormatters.spaceNotAllowed,
                              ],
                            ),
                            SizedBox(height: size.height * 0.3),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ///
                  const SizedBox(height: 24),
                  OButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUpRequested(
                              oUser: {
                                'uid': null,
                                'email': emailController.text,
                                'firstName': firstNameController.text,
                                'lastName': lastNameController.text,
                                'photoURL': defaultProfileUrl,
                              },
                              password: passwordController.text,
                            ),);
                      } else {
                        showSnackBar(context, 'All fields are required');
                      }
                    },
                    label: l10n.register,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        l10n.alreadyHaveAnAccount,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(const AuthLoginPageRequested());
                        },
                        child: Text(
                          l10n.login,
                          style: const TextStyle(
                            color: primary2Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
