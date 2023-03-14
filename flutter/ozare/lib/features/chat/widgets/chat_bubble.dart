import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    required this.chat,
    super.key,
  });

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMe = context.read<ProfileBloc>().state.user.uid == chat.senderId;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.7,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isMe ? primary2Color : Colors.grey[200],
          // gradient: isMe ? gradient : null,
          borderRadius: BorderRadius.only(
            topLeft: isMe ? const Radius.circular(16) : Radius.zero,
            topRight: const Radius.circular(16),
            bottomLeft: const Radius.circular(16),
            bottomRight: isMe ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (!isMe)
              Row(
                children: [
                  Text(
                    chat.senderName,
                    style: const TextStyle(
                      color: primary1Color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            Text(
              chat.message,
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    // extract time from timestamp

                    DateFormat.Hm().format(chat.timestamp.toLocal()),
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  // if (isMe) ...[
                  //   const SizedBox(width: 8),
                  //   const Icon(
                  //     Icons.done_all,
                  //     color: primary1Color,
                  //     size: 16,
                  //   ),
                  // ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
