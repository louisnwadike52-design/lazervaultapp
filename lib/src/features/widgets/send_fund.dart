import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'dart:io';
import '../authentication/data/datasources/chat_database.dart';
import '../authentication/data/models/chat_message_model.dart';

class SendFund extends StatefulWidget {
  const SendFund({super.key, required this.recipient});

  final User recipient;

  @override
  State<SendFund> createState() => _SendFundState();
}

class _SendFundState extends State<SendFund> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessageModel> _messages = [];
  ChatMessageModel? _replyTo;
  bool _showEmoji = false;
  final ImagePicker _imagePicker = ImagePicker();
  final ScrollController _scrollController = ScrollController();
  late final ChatDatabase _chatDb;

  // Assume this is the logged-in user
  final String currentUser =
      "Sophia Brown"; // Replace with actual logged-in user

  @override
  void initState() {
    super.initState();
    _chatDb = ChatDatabase.instance;
    _messageController.addListener(() {
      setState(() {});
    });
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final recipientName = "${widget.recipient.firstName} ${widget.recipient.lastName}".trim();
      final messages = await _chatDb.getChatMessages(
        currentUser,
        recipientName,
      );
      setState(() {
        _messages.clear();
        _messages.addAll(messages);
      });
      _scrollToBottom();
    } catch (e) {
      print('Error loading messages: $e');
      // Handle error appropriately
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _handleSendMessage([String? text]) async {
    try {
      final message = text ?? _messageController.text.trim();
      if (message.isEmpty) return;

      final recipientName = "${widget.recipient.firstName} ${widget.recipient.lastName}".trim();
      final chatMessage = ChatMessageModel(
        userFrom: currentUser,
        userTo: recipientName,
        message: message,
        timestamp: DateTime.now(),
        replyToId: _replyTo?.id,
        messageType: MessageType.text.value,
      );

      // Save to local database
      final savedMessage = await _chatDb.create(chatMessage);

      setState(() {
        _messages.add(savedMessage);
        _messageController.clear();
        _replyTo = null;
        if (_showEmoji) {
          _showEmoji = false;
        }
      });

      // Scroll to bottom after message is added
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  void _handleAttachment() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Photo'),
            onTap: () async {
              Navigator.pop(context);
              final XFile? image = await _imagePicker.pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                _addMediaMessage(image.path, MessageType.image);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.videocam),
            title: Text('Video'),
            onTap: () async {
              Navigator.pop(context);
              final XFile? video = await _imagePicker.pickVideo(
                source: ImageSource.gallery,
              );
              if (video != null) {
                _addMediaMessage(video.path, MessageType.video);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_file),
            title: Text('Document'),
            onTap: () async {
              Navigator.pop(context);
              final FilePickerResult? result =
                  await FilePicker.platform.pickFiles(
                type: FileType.any,
                allowMultiple: false,
              );
              if (result != null && result.files.isNotEmpty) {
                _addMediaMessage(result.files.first.path!, MessageType.file);
              }
            },
          ),
        ],
      ),
    );
  }

  void _addMediaMessage(String path, MessageType type) async {
    try {
      final recipientName = "${widget.recipient.firstName} ${widget.recipient.lastName}".trim();
      final chatMessage = ChatMessageModel(
        userFrom: currentUser,
        userTo: recipientName,
        message: path,
        timestamp: DateTime.now(),
        replyToId: _replyTo?.id,
        messageType: type.value,
      );

      // Save to local database
      final savedMessage = await _chatDb.create(chatMessage);

      setState(() {
        _messages.add(savedMessage);
        _replyTo = null;
      });
    } catch (e) {
      print('Error adding media message: $e');
    }
  }

  void _handleReply(ChatMessageModel message) {
    setState(() {
      _replyTo = message;
      FocusScope.of(context).requestFocus();
    });
  }

  void _showCharacterLimitSnackbar() {
    final snackBar = SnackBar(
      content: Text(
        'Message cannot exceed 50 characters',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red[400],
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 100,
        left: 20,
        right: 20,
      ),
      duration: Duration(seconds: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    // Trim the text to 50 characters
    if (_messageController.text.length > 50) {
      _messageController.text = _messageController.text.substring(0, 50);
      _messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: _messageController.text.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.0.w,
                children: [
                  BackNavigator(),
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "${widget.recipient.firstName} ${widget.recipient.lastName}".trim(),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "@${widget.recipient.email}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColors.secondaryFont,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      child: Image.asset(
                        "assets/images/dp.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 16.0.h),
              Text(
                "This chat is encrypted end to end, but lazersync can get information about your payments. ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.neutralFont,
                ),
              )
            ]),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showDate = index == 0 ||
                      !isSameDay(
                          _messages[index - 1].timestamp, message.timestamp);

                  return Column(
                    children: [
                      if (showDate)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            _formatMessageDate(message.timestamp),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      Dismissible(
                        key: Key(message.id.toString()),
                        direction: DismissDirection.startToEnd,
                        onDismissed: null,
                        confirmDismiss: (direction) async {
                          _handleReply(message);
                          return false;
                        },
                        child: ChatBubble(
                          message: message,
                          isFromMe: message.userFrom == currentUser,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Column(
              children: [
                if (_replyTo != null)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.grey[900],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Replying to',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                _replyTo!.message,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16.0,
                          ),
                          onPressed: () => setState(() => _replyTo = null),
                        ),
                      ],
                    ),
                  ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
                  constraints: BoxConstraints(maxHeight: 100.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 215, 196, 243),
                    borderRadius: BorderRadius.circular(42.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _handleAttachment,
                        child: Icon(Icons.attach_file, size: 18.0),
                      ),
                      SizedBox(width: 4.0.w),
                      GestureDetector(
                        onTap: () {
                          setState(() => _showEmoji = !_showEmoji);
                        },
                        child: Icon(
                          _showEmoji ? Icons.keyboard : Icons.emoji_emotions,
                          size: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0.w),
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          maxLength: 50,
                          minLines: 1,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'send message',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                            isDense: true,
                            counterText: '',
                          ),
                          style: TextStyle(fontSize: 14.0),
                          textAlignVertical: TextAlignVertical.center,
                          onSubmitted: _handleSendMessage,
                          onChanged: (text) {
                            if (text.length > 50) {
                              _showCharacterLimitSnackbar();
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: _messageController.text.trim().isEmpty
                            ? null
                            : () => _handleSendMessage(),
                        child: Icon(Icons.send_rounded, size: 18.0),
                      ),
                    ],
                  ),
                ),
                if (_showEmoji)
                  SizedBox(
                    height: 250,
                    child: EmojiPicker(
                      onEmojiSelected: (category, emoji) {
                        setState(() {
                          _messageController.text =
                              _messageController.text + emoji.emoji;
                        });
                      },
                      config: Config(
                        height: 250,
                        checkPlatformCompatibility: true,
                        emojiViewConfig: EmojiViewConfig(
                          columns: 7,
                          emojiSizeMax: 32.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          gridPadding: EdgeInsets.zero,
                          // initCategory: Category.RECENT,
                          // bgColor: const Color(0xFFF2F2F2),
                          loadingIndicator: const SizedBox.shrink(),
                        ),
                        categoryViewConfig: CategoryViewConfig(
                          tabBarHeight: 46,
                          indicatorColor:
                              const Color.fromARGB(255, 129, 73, 226),
                          iconColor: Colors.grey,
                          iconColorSelected:
                              const Color.fromARGB(255, 129, 73, 226),
                          backspaceColor:
                              const Color.fromARGB(255, 129, 73, 226),
                          recentTabBehavior: RecentTabBehavior.RECENT,
                        ),
                        skinToneConfig: const SkinToneConfig(),
                        searchViewConfig: const SearchViewConfig(),
                        bottomActionBarConfig: const BottomActionBarConfig(),
                      ),
                    ),
                  ),
                SizedBox(height: 16.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        style: IconButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 129, 73, 226),
                        ),
                        icon: Icon(
                          Icons.call_split_rounded,
                          color: AppColors.neutralFont,
                        )),
                    ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.initiateSendFunds,
                              arguments: widget.recipient);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 129, 73, 226),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0.w, vertical: 4.0.h),
                        ),
                        child: Row(
                          spacing: 16.0.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "send",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.call_made_rounded,
                              color: AppColors.neutralFont,
                            ),
                          ],
                        )),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 129, 73, 226),
                          padding: EdgeInsets.symmetric(
                              horizontal: 40.0.w, vertical: 4.0.h),
                        ),
                        child: Row(
                          spacing: 16.0.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call_received_rounded,
                              color: AppColors.neutralFont,
                              size: 16.0,
                            ),
                            Text(
                              "Receive",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  String _formatMessageDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));
    final messageDate = DateTime(date.year, date.month, date.day);

    if (messageDate == today) {
      return 'Today';
    } else if (messageDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, y').format(date);
    }
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

enum MessageType {
  text('text'),
  image('image'),
  video('video'),
  file('file');

  final String value;
  const MessageType(this.value);

  static MessageType fromString(String value) {
    return MessageType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => MessageType.text,
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isFromMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isFromMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        constraints: BoxConstraints(maxWidth: 0.7.sw),
        decoration: BoxDecoration(
          color: isFromMe
              ? const Color.fromARGB(255, 129, 73, 226)
              : const Color.fromARGB(255, 33, 11, 111),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
            bottomLeft: Radius.circular(isFromMe ? 16.0 : 0.0),
            bottomRight: Radius.circular(isFromMe ? 0.0 : 16.0),
          ),
        ),
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.replyToId != null)
              FutureBuilder<ChatMessageModel?>(
                future:
                    ChatDatabase.instance.getMessageById(message.replyToId!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return SizedBox.shrink();
                  final replyMessage = snapshot.data!;
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.only(bottom: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          replyMessage.userFrom == message.userFrom
                              ? 'You'
                              : replyMessage.userFrom,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        _buildReplyPreview(replyMessage),
                      ],
                    ),
                  );
                },
              ),
            _buildMessageContent(context),
            Padding(
              padding: EdgeInsets.only(top: 4.0),
              child: Text(
                _formatTime(message.timestamp),
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyPreview(ChatMessageModel replyMessage) {
    final messageType = MessageType.fromString(replyMessage.messageType);

    switch (messageType) {
      case MessageType.text:
        return Text(
          replyMessage.message,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12.sp,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        );
      case MessageType.image:
        return Row(
          children: [
            Icon(Icons.image, color: Colors.white70, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              'Photo',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
          ],
        );
      case MessageType.video:
        return Row(
          children: [
            Icon(Icons.videocam, color: Colors.white70, size: 16.0),
            SizedBox(width: 4.0),
            Text(
              'Video',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
              ),
            ),
          ],
        );
      case MessageType.file:
        return Row(
          children: [
            Icon(Icons.attach_file, color: Colors.white70, size: 16.0),
            SizedBox(width: 4.0),
            Expanded(
              child: Text(
                replyMessage.message.split('/').last,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
    }
  }

  Widget _buildMessageContent(BuildContext context) {
    final messageType = MessageType.fromString(message.messageType);

    switch (messageType) {
      case MessageType.text:
        return Text(
          message.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
          ),
        );
      case MessageType.image:
        return Stack(
          children: [
            GestureDetector(
              onTap: () => _showFullScreenImage(context, message.message),
              child: Image.file(
                File(message.message),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: _buildDownloadButton(message.message),
            ),
          ],
        );
      case MessageType.video:
        return Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _showFullScreenVideo(context, message.message),
              child: Image.file(
                File(message.message),
                fit: BoxFit.cover,
              ),
            ),
            Icon(Icons.play_circle_fill, color: Colors.white, size: 48.0),
            Positioned(
              bottom: 8,
              left: 8,
              child: _buildDownloadButton(message.message),
            ),
          ],
        );
      case MessageType.file:
        return Row(
          children: [
            Icon(Icons.attach_file, color: Colors.white),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                message.message.split('/').last,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
            _buildDownloadButton(message.message),
          ],
        );
    }
  }

  Widget _buildDownloadButton(String filePath) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GestureDetector(
        onTap: () => _downloadFile(filePath),
        child: Icon(Icons.download, color: Colors.white, size: 20),
      ),
    );
  }

  void _downloadFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        // Implement your download logic here
        // You might want to copy the file to a downloads directory
        // or use a plugin like path_provider to get the proper directory
        print('Downloading file: $filePath');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

  void _showFullScreenImage(BuildContext context, String imagePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.download),
                onPressed: () => _downloadFile(imagePath),
              ),
            ],
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.file(File(imagePath)),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreenVideo(BuildContext context, String videoPath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                icon: Icon(Icons.download),
                onPressed: () => _downloadFile(videoPath),
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add your video player widget here
                // You might want to use video_player or better_player package
                Text(
                  'Video Player Placeholder',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm').format(timestamp);
  }
}
