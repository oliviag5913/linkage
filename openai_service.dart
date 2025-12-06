

class OpenAIService {
  final String apiKey = "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"; 

  Future<String> getChatSuggestion(String contextType, String userInterest, String otherInterest) async {
    // contextType: 'topic', 'project', 'summary'
    
    // Placeholder for actual API call
    // In a real app, use https://api.openai.com/v1/chat/completions
    
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    
    if (contextType == 'topic') {
      return "Why not discuss your shared interest in $userInterest? Ask them how they got started.";
    } else if (contextType == 'project') {
      return "Project Idea: Collaborate on a digital scrapbook about $otherInterest.";
    }
    return "Here is a summary of your chat...";
  }
}