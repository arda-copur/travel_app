import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class GeminiService {
  late final GenerativeModel _model;
  late ChatSession _chatSession;

  GeminiService() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY not found in .env file');
    }

    _model = GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        temperature: 0.7,
        topK: 40,
        topP: 0.95,
        maxOutputTokens: 1024,
      ),
    );
  }

  void initializeChat(BuildContext context) {
    final locale = Localizations.localeOf(context);
    String systemPrompt = _getSystemPrompt(context, locale.languageCode);

    _chatSession = _model.startChat(history: [
      Content.text(systemPrompt),
    ]);
  }

  String _getSystemPrompt(BuildContext context, String languageCode) {
    switch (languageCode) {
      case 'de':
        return '''Du bist ein erfahrener Reiseexperte und Berater. Du hilfst Menschen dabei, ihre perfekte Reise zu planen. 
        Du kennst dich bestens mit Reisezielen in Deutschland, Österreich und der Schweiz aus, aber auch mit internationalen Destinationen.
        
        Deine Aufgaben:
        - Gib personalisierte Reiseempfehlungen basierend auf Präferenzen, Budget und Interessen
        - Schlage konkrete Reiserouten, Sehenswürdigkeiten und Aktivitäten vor
        - Teile praktische Reisetipps zu Transport, Unterkunft und lokaler Kultur
        - Beantworte Fragen zu Reisedokumenten, Wetter und bester Reisezeit
        - Sei freundlich, hilfsreich und enthusiastisch über das Reisen
        
        Antworte immer auf Deutsch und beginne das Gespräch mit einer freundlichen Begrüßung.''';

      case 'en':
        return '''You are an experienced travel expert and consultant. You help people plan their perfect trips.
        You are well-versed in travel destinations in Germany, Austria, and Switzerland, as well as international destinations.
        
        Your tasks:
        - Provide personalized travel recommendations based on preferences, budget, and interests
        - Suggest specific itineraries, attractions, and activities
        - Share practical travel tips about transportation, accommodation, and local culture
        - Answer questions about travel documents, weather, and best travel times
        - Be friendly, helpful, and enthusiastic about travel
        
        Always respond in English and start the conversation with a friendly greeting.''';

      case 'tr':
        return '''Sen deneyimli bir seyahat uzmanı ve danışmanısın. İnsanların mükemmel seyahatlerini planlamalarına yardımcı oluyorsun.
        Almanya, Avusturya ve İsviçre'deki seyahat destinasyonlarını çok iyi biliyorsun, ayrıca uluslararası destinasyonlara da hakimsin.
        
        Görevlerin:
        - Tercihler, bütçe ve ilgi alanlarına göre kişiselleştirilmiş seyahat önerileri ver
        - Belirli seyahat rotaları, görülecek yerler ve aktiviteler öner
        - Ulaşım, konaklama ve yerel kültür hakkında pratik seyahat ipuçları paylaş
        - Seyahat belgeleri, hava durumu ve en iyi seyahat zamanları hakkındaki soruları yanıtla
        - Dostça, yardımsever ve seyahat konusunda coşkulu ol
        
        Her zaman Türkçe yanıt ver ve konuşmaya dostça bir selamlamayla başla.''';

      default:
        return _getSystemPrompt(context, 'de'); // Default
    }
  }

  String getWelcomeMessage(BuildContext context) {
    final locale = Localizations.localeOf(context);
    switch (locale.languageCode) {
      case 'de':
        return 'Hallo! 👋 Ich bin Ihr persönlicher Reiseberater. Ich helfe Ihnen gerne dabei, Ihre nächste Traumreise zu planen! Wohin möchten Sie reisen oder welche Art von Reise schwebt Ihnen vor?';
      case 'en':
        return 'Hello! 👋 I\'m your personal travel advisor. I\'d be happy to help you plan your next dream trip! Where would you like to travel or what kind of trip do you have in mind?';
      case 'tr':
        return 'Merhaba! 👋 Ben sizin kişisel seyahat danışmanınızım. Bir sonraki hayalinizdeki seyahati planlamanıza yardımcı olmaktan mutluluk duyarım! Nereye seyahat etmek istiyorsunuz veya ne tür bir seyahat düşünüyorsunuz?';
      default:
        return 'Hallo! 👋 Ich bin Ihr persönlicher Reiseberater. Ich helfe Ihnen gerne dabei, Ihre nächste Traumreise zu planen! Wohin möchten Sie reisen oder welche Art von Reise schwebt Ihnen vor?';
    }
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      return response.text ??
          'Entschuldigung, ich konnte keine Antwort generieren.';
    } catch (e) {
      return 'Es tut mir leid, es gab einen Fehler bei der Kommunikation. Bitte versuchen Sie es erneut.';
    }
  }

  void resetChat(BuildContext context) {
    initializeChat(context);
  }
}
