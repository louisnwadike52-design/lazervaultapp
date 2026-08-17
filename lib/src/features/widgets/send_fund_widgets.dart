part of 'send_fund.dart';

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
