import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '/flutter_flow/flutter_flow_util.dart';

const _kCloudFunctionsBaseUrl =
    'https://southamerica-east1-profissions-2746d.cloudfunctions.net';

Future<String?> openrouterGenerateText(
  BuildContext context,
  String prompt,
) async {
  try {
    final resp = await http.post(
      Uri.parse('$_kCloudFunctionsBaseUrl/openrouterGenerateText'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      showSnackbar(
        context,
        'Erro (${resp.statusCode}) ao gerar texto',
      );
      return null;
    }
    final decoded = jsonDecode(resp.body) as Map<String, dynamic>;
    return decoded['text']?.toString();
  } catch (e) {
    showSnackbar(context, e.toString());
    return null;
  }
}

Future<String?> openrouterCountTokens(
  BuildContext context,
  String prompt,
) async {
  try {
    final resp = await http.post(
      Uri.parse('$_kCloudFunctionsBaseUrl/openrouterCountTokens'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'prompt': prompt}),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      showSnackbar(
        context,
        'Erro (${resp.statusCode}) ao contar tokens',
      );
      return null;
    }
    final decoded = jsonDecode(resp.body) as Map<String, dynamic>;
    return decoded['totalTokens']?.toString();
  } catch (e) {
    showSnackbar(context, e.toString());
    return null;
  }
}

Future<Uint8List> _loadImageBytesFromUrl(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    return response.bodyBytes;
  }
  throw Exception('Failed to load image');
}

Future<String?> openrouterTextFromImage(
  BuildContext context,
  String prompt, {
  String? imageNetworkUrl = '',
  FFUploadedFile? uploadImageBytes,
}) async {
  assert(
    imageNetworkUrl != null || uploadImageBytes != null,
    'Either imageNetworkUrl or uploadImageBytes must be provided.',
  );

  try {
    final imageBytes = uploadImageBytes != null
        ? uploadImageBytes.bytes
        : await _loadImageBytesFromUrl(imageNetworkUrl!);

    final payload = <String, dynamic>{
      'prompt': prompt,
      if ((imageNetworkUrl ?? '').isNotEmpty) 'imageUrl': imageNetworkUrl,
      if (uploadImageBytes != null && imageBytes != null)
        'imageBase64': base64Encode(imageBytes),
    };

    final resp = await http.post(
      Uri.parse('$_kCloudFunctionsBaseUrl/openrouterTextFromImage'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payload),
    );
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      showSnackbar(
        context,
        'Erro (${resp.statusCode}) ao processar imagem',
      );
      return null;
    }
    final decoded = jsonDecode(resp.body) as Map<String, dynamic>;
    return decoded['text']?.toString();
  } catch (e) {
    showSnackbar(context, e.toString());
    return null;
  }
}

