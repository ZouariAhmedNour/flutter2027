// La clé API Gemini n'est PAS écrite dans le code.
// Elle est lue au lancement depuis env.json (fichier ignoré par Git) :
//   flutter run --dart-define-from-file=env.json
const String apiKey = String.fromEnvironment('GEMINI_API_KEY');
