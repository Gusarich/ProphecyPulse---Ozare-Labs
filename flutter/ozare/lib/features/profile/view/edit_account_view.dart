import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ozare/features/auth/widgets/input_field.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/l10n/l10n.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({
    required this.oUser,
    super.key,
  });

  final OUser oUser;

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.oUser.firstName;
    lastNameController.text = widget.oUser.lastName;
    emailController.text = widget.oUser.email;
    phoneController.text = widget.oUser.phoneNumber ?? '';
    dobController.text = widget.oUser.dob ?? '';
    genderController.text = widget.oUser.gender?.toString() ?? '';
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    genderController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime(2000);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final l10n = context.l10n;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
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
                  controller: dobController,
                  hintText: DateFormat.yMd().format(selectedDate),
                  labelText: l10n.dateOfBirth,
                  readOnly: true,
                  suffix: IconButton(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: primary1Color,
                    ),
                    onPressed: getDateFromUser,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(l10n.gender),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GenderPicker(
                      label: l10n.male,
                      onTap: () {
                        setState(() {
                          genderController.text = '1';
                        });
                      },
                      isActive: genderController.text == '1',
                    ),
                    GenderPicker(
                      label: l10n.female,
                      onTap: () {
                        setState(() {
                          genderController.text = '0';
                        });
                      },
                      isActive: genderController.text == '0',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: phoneController,
                  hintText: l10n.enterYourPhoneNumber,
                  labelText: l10n.phoneNumber,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: emailController,
                  hintText: l10n.enterYourEmailAddress,
                  labelText: l10n.emailAddress,
                  readOnly: true,
                ),
                const SizedBox(height: 32),
                OButton(
                  label: l10n.update,
                  onTap: () {
                    // If the user has changed any data, then update the user
                    context.read<ProfileBloc>().add(
                          ProfileUpdateRequested(
                            OUser(
                              uid: widget.oUser.uid,
                              email: widget.oUser.email,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              dob: dobController.text,
                              phoneNumber: phoneController.text,
                              gender: int.parse(genderController.text),
                            ),
                          ),
                        );
                  },
                ),
                SizedBox(height: size.height * 0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getDateFromUser() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2010),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        dobController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }
}
