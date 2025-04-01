class Message {
  final String role; // 'user' or 'assistant'
  final String text;

  Message({required this.role, required this.text});

  /// Convert message to API format
  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'text': text,
    };
  }

  /// Create Message instance from API response
  factory Message.fromApiResponse(Map<String, dynamic> response) {
    return Message(
      role: 'assistant',
      text: response['parts'][0]['text'] ?? '',
    );
  }

  /// Create Message instance from Map for local storage
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      role: map['role'] ?? 'user',
      text: map['text'] ?? '',
    );
  }
}
