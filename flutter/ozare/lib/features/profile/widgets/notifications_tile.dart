// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart' hide Notification;
// import 'package:intl/intl.dart';
// import 'package:ozare/features/profile/widgets/widgets.dart';
// import 'package:ozare/models/notification.dart';

// class NotificationTile extends StatelessWidget {
//   const NotificationTile({
//     super.key,
//     required this.notification,
//   });

//   final Notification notification;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return HistoryItem(bet: bet)
  
//     // return Container(
//     //   height: 64,
//     //   padding: const EdgeInsets.all(6),
//     //   margin: const EdgeInsets.only(bottom: 12, right: 24, left: 24),
//     //   decoration: BoxDecoration(
//     //       color: Colors.white,
//     //       borderRadius: BorderRadius.circular(12),
//     //       boxShadow: [
//     //         BoxShadow(
//     //           color: Colors.grey.shade100,
//     //           blurRadius: 4,
//     //           offset: const Offset(0, 1),
//     //         ),
//     //       ]),
//     //   child: Row(
//     //     mainAxisSize: MainAxisSize.max,
//     //     children: [
//     //       const SizedBox(width: 8),
//     //       Image.asset(
//     //         'assets/images/notification.png',
//     //         height: 42,
//     //       ),
//     //       const SizedBox(width: 16),
//     //       Column(
//     //         crossAxisAlignment: CrossAxisAlignment.start,
//     //         mainAxisAlignment: MainAxisAlignment.center,
//     //         children: [
//     //           Row(
//     //             children: [
//     //               Text(
//     //                 notification.title,
//     //                 style: const TextStyle(
//     //                   fontWeight: FontWeight.w600,
//     //                   fontSize: 12,
//     //                 ),
//     //               ),
//     //               SizedBox(width: size.width * 0.2),
//     //               Text(
//     //                 "${DateFormat.Hm().format(notification.dateTime.toLocal())} - ${DateFormat.yMMMd().format(notification.dateTime.toLocal())}",
//     //                 style: TextStyle(
//     //                   fontSize: 9,
//     //                   color: Colors.grey[700],
//     //                 ),
//     //               ),
//     //             ],
//     //           ),
//     //           SizedBox(
//     //             height: 32,
//     //             width: size.width * 0.6,
//     //             child: AutoSizeText(
//     //               notification.body,
//     //               maxFontSize: 11,
//     //               minFontSize: 7,
//     //               maxLines: 2,
//     //               style: const TextStyle(
//     //                 color: Colors.grey,
//     //                 height: 1.2,
//     //               ),
//     //             ),
//     //           ),
//     //         ],
//     //       )
//     //     ],
//     //   ),
//     // );
  
  
//   }
// }
