import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/app/routes.dart';
import 'package:ozare/features/auth/bloc/auth_bloc.dart';
import 'package:ozare/features/auth/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Center(
              child: SizedBox(
                width: size.width < 500 ? null : 500,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          l10n.letsGetStarted,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.06),

                      // Email Field
                      InputField(
                        controller: emailController,
                        hintText: l10n.enterYourEmailAddress,
                        labelText: l10n.emailAddress,
                        textInputType: TextInputType.emailAddress,
                        inputFormatters: [
                          InputFormatters.spaceNotAllowed,
                        ],
                        validator: (val) => Validators.emailValidator(val!),
                      ),
                      const SizedBox(height: 16),
                      InputField(
                        controller: passwordController,
                        hintText: l10n.enterYourPassword,
                        labelText: l10n.password,
                        isPassword: true,
                        textInputType: TextInputType.visiblePassword,
                        maxLines: 1,
                        inputFormatters: [
                          InputFormatters.spaceNotAllowed,
                        ],
                      ),
                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          l10n.fogotPassword,
                          style: const TextStyle(
                            color: primary2Color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      ///
                      SizedBox(height: size.height * 0.07),

                      OButton(
                        onTap: () {
                          // check if user has entered valid data
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthLoginRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          } else {
                            showSnackBar(context, 'All fields are required');
                          }
                        },
                        label: l10n.login,
                      ),
                      const SizedBox(height: 16),

                      /// Or Continue With
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.orContinueWith,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// Social Buttons
                      OButton.icon(
                        onTap: () => context
                            .read<AuthBloc>()
                            .add(const AuthWalletLoginPageRequested()),
                        iconPath: 'assets/icons/ton.svg',
                      ),
                      SizedBox(height: size.height * 0.03),
                      OButton.icon(
                          onTap: () {
                            context.read<AuthBloc>().add(
                                  const AuthGoogleLoginRequested(),
                                );
                          },
                          iconPath: 'assets/icons/google.svg'),

                      ///
                      SizedBox(height: size.height * 0.04),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.dontHaveAnAccount,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(const AuthSignUpPageRequested());
                            },
                            child: Text(
                              l10n.register,
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
        ),
      ),
    );
  }
}
