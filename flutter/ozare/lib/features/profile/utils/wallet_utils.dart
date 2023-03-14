final List<Map<String, dynamic>> wallets = [
  {
    'name': 'Wallet',
    'iconPath': 'assets/images/wallet.png',
  },
  {
    'name': 'TON Wallet',
    'iconPath': 'assets/images/tonwallet.png',
  },
  {
    'name': 'Tonkeeper',
    'iconPath': 'assets/images/tonkeeper.png',
  },
  {
    'name': 'Coin98',
    'iconPath': 'assets/images/coin98.png',
  },
];

Uri tonApiWeb = Uri.parse(
  'https://tonapi.io/login?return_url=https://ozare.page.link/?link=https://ozare-e8ed6.firebaseapp.com&apn=com.example.ozare',
);
Uri tonApiWallet = Uri.parse(
  'https://tonapi.io/login?return_url=https://ozare.page.link/walletAuth',
);
