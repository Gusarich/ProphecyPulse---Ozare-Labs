import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ozare/app/routes.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/features/profile/models/models.dart';

import 'package:ozare/features/profile/widgets/widgets.dart';
import 'package:ozare/styles/common/widgets/dialogs/dialogs.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarProfileSection.singlePage(
          title: 'Wallets',
          appBarAction: GestureDetector(
            onTap: () async {
              //REVIEW - Muted the route to adding wallets.

              await Navigator.pushNamed(context, Routes.addWallet);
              // await launchUrl(Uri.parse('https://ozare-react.vercel.app/'));
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white30,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ),
        BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state.wallet.isNotEmpty && state.wallet.length == 1) {
              showAlertDialog(
                context: context,
                title: 'Success',
                content: 'Wallet connected successfully',
              );
            }
          },
          bloc: context.read<ProfileBloc>(),
          builder: (context, state) {
            if (state.wallet.isNotEmpty) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => WalletTile(
                    wallet: Wallet(
                      name: state.wallet[index].name,
                      key: state.wallet[index].key,
                      iconPath: state.wallet[index].iconPath,
                    ),
                  ),
                  itemCount: state.wallet.length,
                ),
              );
            } else {
              //FIXME - Show no wallet {widget}
              // return const Center(
              //   child: Text('Add wallet'),
              // );

              return const SizedBox();
            }
          },
        )
      ],
    );
  }
}
