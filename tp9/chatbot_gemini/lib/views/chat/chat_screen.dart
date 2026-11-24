import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../secrets.dart'; // contient apiKey (fichier ignoré par Git)

// ===== Étape 2.2 : constantes de l'API =====

// La clé API est définie dans lib/secrets.dart (non versionné).
// gemini-1.5-pro (utilisé dans l'énoncé) a été retiré par Google :
const String model = 'gemini-2.5-flash';

const String apiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/$model:generateContent?key=$apiKey';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Contrôleur pour le champ de texte
  final TextEditingController _controller = TextEditingController();

  // Liste des messages : chaque message a un texte et un "sender" (user ou bot)
  final List<Map<String, String>> messages = [];

  // Indicateur de chargement (quand le bot répond)
  bool _isLoading = false;

  // ===== Étape 2.3 : appel à l'API Gemini =====
  Future<String> getChatbotResponse(String query) async {
    try {
      // Gemini peut renvoyer 503 (modèle surchargé) : on réessaie jusqu'à 3 fois.
      late http.Response response;
      for (int tentative = 1; tentative <= 3; tentative++) {
        response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': apiKey,
        },
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": query}
              ]
            }
          ]
        }),
      );
        if (response.statusCode != 503) break;
        await Future.delayed(Duration(seconds: 2 * tentative));
      }

      if (response.statusCode == 503) {
        return 'Gemini est très sollicité en ce moment, réessaie dans quelques secondes.';
      }

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final candidates = data['candidates'];
        if (candidates != null &&
            candidates is List &&
            candidates.isNotEmpty &&
            candidates[0]['content'] != null &&
            candidates[0]['content']['parts'] != null &&
            candidates[0]['content']['parts'] is List &&
            candidates[0]['content']['parts'].isNotEmpty &&
            candidates[0]['content']['parts'][0]['text'] != null) {
          return candidates[0]['content']['parts'][0]['text'];
        } else {
          return 'Erreur: format de réponse inattendu.';
        }
      } else {
        debugPrint('Gemini error: ${response.statusCode} - ${response.body}');
        return 'Erreur: ${response.statusCode} lors de l\'appel à l\'API.';
      }
    } catch (e) {
      debugPrint('Exception: $e');
      return 'Erreur réseau ou exception: $e';
    }
  }

  // ===== Étape 3 : envoi du message + appel Gemini =====
  void _sendMessage() async {
    if (_controller.text.trim().isEmpty || _isLoading) return;

    final userText = _controller.text.trim();

    // Ajouter le message utilisateur + activer le chargement
    setState(() {
      messages.add({'text': userText, 'sender': 'user'});
      _isLoading = true;
    });

    _controller.clear();

    // APPEL À L'API GEMINI
    final response = await getChatbotResponse(userText);

    // Ajouter le message du bot + désactiver le chargement
    setState(() {
      messages.add({'text': response, 'sender': 'bot'});
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Chatbot (Gemini)'),
      ),
      body: Column(
        children: [
          // Zone qui affiche la liste des messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isUser = messages[index]['sender'] == 'user';
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      messages[index]['text'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Indicateur "Le bot écrit..." (quand _isLoading = true)
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Le bot écrit...',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),

          // Zone de saisie + bouton envoyer
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Tape ton message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}