import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:cooka/data/image_urls.dart';
import 'package:cooka/models/ingredient.dart';
import 'package:cooka/data/dummy.dart'; // Make sure this import is present

String getRandomImage() {
  // Assuming imageUrls is a list of URLs
  return imageUrls[DateTime.now().millisecondsSinceEpoch % imageUrls.length];
}

bool isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri != null && (uri.hasScheme || uri.hasAuthority);
}

Future<String> uploadImageToBackend(File file, String backendUrl,
    {bool mock = true}) async {
  if (!isValidUrl(backendUrl)) {
    throw ArgumentError('Invalid backend URL: $backendUrl');
  }
  final request = http.MultipartRequest('POST', Uri.parse(backendUrl));
  request.files.add(await http.MultipartFile.fromPath('file', file.path));

  if (mock) {
    // Mock response for testing
    return getRandomImage();
  }

  final response = await request.send();

  if (response.statusCode == 200) {
    final responseBody = await response.stream.bytesToString();
    // Assuming the backend returns the URL as plain text
    return responseBody;
    // If backend returns JSON: return jsonDecode(responseBody)['url'];
  } else {
    throw Exception('Failed to upload image: ${response.statusCode}');
  }
}

Future<Ingredient> insertIngredientToBackend(
  Ingredient ingredient, {
  bool mock = true,
}) async {
  if (mock) {
    // Add to dummyIngredients list
    dummyIngredients.add(ingredient);
    return ingredient;
  }

  // TODO: Implement real backend call here
  throw UnimplementedError('Real backend insert not implemented');
}
