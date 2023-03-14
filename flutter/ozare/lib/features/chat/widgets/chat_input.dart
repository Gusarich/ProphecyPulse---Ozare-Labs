// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ozare/features/chat/bloc/chat_bloc.dart';
import 'package:ozare/features/profile/bloc/profile_bloc.dart';
import 'package:ozare/styles/common/common.dart';
import 'package:ozare_repository/ozare_repository.dart';
import 'package:uuid/uuid.dart';

class ChatInput extends StatefulWidget {
  const ChatInput({super.key});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sender = context.read<ProfileBloc>().state.user;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 66,
      width: size.width,
      child: Row(
        children: [
          // Smile Icon
          SvgPicture.asset(
            'assets/icons/face.svg',
            color: Colors.grey,
          ),

          const SizedBox(width: 8),
          // Text Field
          Expanded(
            child: SizedBox(
              height: 52,
              child: TextField(
                cursorColor: primary2Color,
                controller: messageController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: 12,
                    top: 8,
                    bottom: 10,
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/attach.svg',
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 22),
                      GestureDetector(
                        onTap: () {
                          if (messageController.text.isNotEmpty) {
                            context.read<ChatBloc>().add(
                                  ChatSend(
                                    chat: Chat(
                                      id: const Uuid().v4(),
                                      senderName:
                                          '${sender.firstName} ${sender.lastName}',
                                      message: messageController.text,
                                      senderId: sender.uid!,
                                      timestamp: DateTime.now().toUtc(),
                                    ),
                                  ),
                                );
                            messageController.clear();
                            // hide keyboard
                            FocusScope.of(context).unfocus();
                          }
                        },
                        child: SvgPicture.asset(
                          'assets/icons/send.svg',
                          color: primary2Color,
                        ),
                      ),
                      const SizedBox(width: 22),
                    ],
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[200]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'Write your message',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: primary2Color,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
