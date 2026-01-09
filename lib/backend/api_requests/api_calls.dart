import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start OpenAI ChatGPT Group Code

class OpenAIChatGPTGroup {
  static String getBaseUrl() => 'https://api.openai.com/v1';
  static Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  static SendFullPromptCall sendFullPromptCall = SendFullPromptCall();
}

class SendFullPromptCall {
  Future<ApiCallResponse> call({
    String? apiKey = '',
    dynamic? promptJson,
  }) async {
    final baseUrl = OpenAIChatGPTGroup.getBaseUrl();

    final prompt = _serializeJson(promptJson);
    final ffApiRequestBody = '''
{
  "model": "gpt-3.5-turbo",
  "messages": ${prompt}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Full Prompt',
      apiUrl: '${baseUrl}/chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${apiKey}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? createdTimestamp(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.created''',
      ));
  String? role(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.role''',
      ));
  String? content(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.choices[:].message.content''',
      ));
}

/// End OpenAI ChatGPT Group Code

/// Start bancodedados Group Code

class BancodedadosGroup {
  static String getBaseUrl() =>
      'https://southamerica-east1-profissions-2746d.cloudfunctions.net';
  static Map<String, String> headers = {};
  static CriarSubinscricaoCall criarSubinscricaoCall = CriarSubinscricaoCall();
  static CriarTreinosIaCall criarTreinosIaCall = CriarTreinosIaCall();
  static AvaliacaoPosturalCall avaliacaoPosturalCall = AvaliacaoPosturalCall();
  static VerifyAccountStripeCall verifyAccountStripeCall =
      VerifyAccountStripeCall();
  static SaldoConnectedCall saldoConnectedCall = SaldoConnectedCall();
  static OpenrouterConversaPlanoCall openrouterConversaPlanoCall =
      OpenrouterConversaPlanoCall();
}

class CriarSubinscricaoCall {
  Future<ApiCallResponse> call({
    String? stripeSubscriptionId = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'Criar Subinscricao',
      apiUrl: '${baseUrl}/detalhesDaAssinatura',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'stripeSubscriptionId': stripeSubscriptionId,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? id(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subscription.id''',
      ));
  bool? ativo(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.subscription.items.data[:].plan.active''',
      ));
  String? valor(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subscription.items.data[:].plan.amount_decimal''',
      ));
  String? periodo(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subscription.items.data[:].plan.interval''',
      ));
  String? invoice(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.subscription.latest_invoice''',
      ));
  int? daysquefalta(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.subscription.days_until_due''',
      ));
  dynamic? todospagamentos(dynamic response) => getJsonField(
        response,
        r'''$.subscription.items.data[:].price''',
      );
}

class CriarTreinosIaCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? novoTema = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "userId": "${escapeStringForJson(userId)}",
  "novoTema": "${escapeStringForJson(novoTema)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'criarTreinosIa',
      apiUrl: '${baseUrl}/criarTreinosIa',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? error(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.error''',
      ));
  String? uidTreinos(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.idCreateTreino''',
      ));
  dynamic? treinoCompleto(dynamic response) => getJsonField(
        response,
        r'''$.treinoCompleto''',
      );
}

class AvaliacaoPosturalCall {
  Future<ApiCallResponse> call({
    String? imageUrl = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'avaliacaoPostural',
      apiUrl: '${baseUrl}/avaliarPostural',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'imageUrl': imageUrl,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? avaliacaopostural(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.avaliacao.postura''',
      ));
  String? descricaodapostura(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.avaliacao.descricaoPostura''',
      ));
  String? metricas(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.avaliacao.algumasMetricas''',
      ));
  String? textodetalhado(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.avaliacao.textoDetalhado''',
      ));
}

class VerifyAccountStripeCall {
  Future<ApiCallResponse> call({
    String? documentFront = '',
    String? documentBack = '',
    String? email = '',
    String? firstName = '',
    String? lastName = '',
    String? cpf = '',
    String? dobDay = '',
    String? dobMonth = '',
    String? dobYear = '',
    String? addressLine1 = '',
    String? addressCity = '',
    String? addressState = '',
    String? addressPostalCode = '',
    String? phone = '',
    String? ip = '',
    String? productDescription = '',
    String? routingNumber = '',
    String? accountNumber = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'verify account stripe',
      apiUrl: '${baseUrl}/createAndVerifyStripeAccount',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'cpf': cpf,
        'dobDay': dobDay,
        'dobMonth': dobMonth,
        'dobYear': dobYear,
        'addressLine1': addressLine1,
        'addressCity': addressCity,
        'addressState': addressState,
        'addressPostalCode': addressPostalCode,
        'phone': phone,
        'ip': ip,
        'productDescription': productDescription,
        'document_front': documentFront,
        'document_back': documentBack,
        'routingNumber': routingNumber,
        'accountNumber': accountNumber,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? accountId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.accountId''',
      ));
  bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
}

class SaldoConnectedCall {
  Future<ApiCallResponse> call({
    String? connectedAccountId = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'saldo connected',
      apiUrl: '${baseUrl}/getSaldo',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'connectedAccountId': connectedAccountId,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  int? avaliable(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.balance.available[:].amount''',
      ));
  int? pending(dynamic response) => castToType<int>(getJsonField(
        response,
        r'''$.balance.pending[:].amount''',
      ));
}

class OpenrouterConversaPlanoCall {
  Future<ApiCallResponse> call({
    String? userId = '',
    String? mensagem = '',
  }) async {
    final baseUrl = BancodedadosGroup.getBaseUrl();

    return ApiManager.instance.makeApiCall(
      callName: 'openrouter conversa plano',
      apiUrl: '${baseUrl}/AIparaconversarcomosusers',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'userId': userId,
        'mensagem': mensagem,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? resposta(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.resposta''',
      ));
  String? nomedarotina(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.treinoCompleto.nomeDaRotina''',
      ));
  String? objetivodarotina(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.treinoCompleto.objetivoDaRotina''',
      ));
  List<String>? treinos(dynamic response) => (getJsonField(
        response,
        r'''$.response.treinoCompleto.treino''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  String? uidtreino(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.treinoUid''',
      ));
}

/// End bancodedados Group Code

class OpenrouterGenerateTextCall {
  static Future<ApiCallResponse> call({
    String? prompt = '',
  }) async {
    final ffApiRequestBody = '''
{
  "prompt": "${escapeStringForJson(prompt)}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OpenrouterGenerateText',
      apiUrl:
          'https://southamerica-east1-profissions-2746d.cloudfunctions.net/openrouterGenerateText',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: true,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? textoGerado(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.text''',
      ));
  static List? parts(dynamic response) => getJsonField(
        response,
        r'''$.usage''',
        true,
      ) as List?;
}

class CriarClienteCall {
  static Future<ApiCallResponse> call({
    String? name = '',
    String? cpfCnpj = '',
    String? email = '',
    String? address = '',
    double? addressNumber,
    String? province = '',
    double? postalCode,
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'criarCliente',
      apiUrl: 'https://api.asaas.com/v3/customers',
      callType: ApiCallType.POST,
      headers: {
        'access_token':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTg3MjU6OiRhYWNoXzM5NTg5NmI5LTA3ODgtNGMyMC1hYWI5LWJhNjUwZTU1Y2JkMw==',
      },
      params: {
        'name': name,
        'cpfCnpj': cpfCnpj,
        'email': email,
        'address': address,
        'addressNumber': addressNumber,
        'province': province,
        'postalCode': postalCode,
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetAllClientesCall {
  static Future<ApiCallResponse> call({
    String? cpfCnpj = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'getAllClientes',
      apiUrl: 'https://api.asaas.com/v3/customers',
      callType: ApiCallType.GET,
      headers: {
        'access_token':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTg3MjU6OiRhYWNoXzM5NTg5NmI5LTA3ODgtNGMyMC1hYWI5LWJhNjUwZTU1Y2JkMw==',
      },
      params: {
        'cpfCnpj': cpfCnpj,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class CriarAssinaturaComCartaoDeCreditoCall {
  static Future<ApiCallResponse> call({
    String? customer = '',
    double? value,
    String? nextDueDate = '',
    String? holderName = '',
    double? number,
    double? expiryMonth,
    double? expiryYear,
    double? ccv,
    String? remoteIp = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'criarAssinaturaComCartaoDeCredito',
      apiUrl: 'https://api.asaas.com/v3/subscriptions',
      callType: ApiCallType.POST,
      headers: {
        'access_token':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTg3MjU6OiRhYWNoXzM5NTg5NmI5LTA3ODgtNGMyMC1hYWI5LWJhNjUwZTU1Y2JkMw==',
      },
      params: {
        'customer': customer,
        'billingType': "CREDIT_CARD",
        'value': value,
        'nextDueDate': nextDueDate,
        'cycle': "MONTHLY",
        'holderName': holderName,
        'number': number,
        'expiryMonth': expiryMonth,
        'expiryYear': expiryYear,
        'ccv': ccv,
        'remoteIp': remoteIp,
        'description': "Assinatura MH Personal Trainer (Personal)",
      },
      bodyType: BodyType.X_WWW_FORM_URL_ENCODED,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class GetIPCall {
  static Future<ApiCallResponse> call() async {
    return ApiManager.instance.makeApiCall(
      callName: 'getIP',
      apiUrl: 'https://api.country.is/',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? ip(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.ip''',
      ));
  static String? country(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.country''',
      ));
}

class ListarAssinaturasCall {
  static Future<ApiCallResponse> call({
    String? customer = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'listarAssinaturas',
      apiUrl: 'https://api.asaas.com/v3/subscriptions/',
      callType: ApiCallType.GET,
      headers: {
        'access_token':
            '\$aact_YTU5YTE0M2M2N2I4MTliNzk0YTI5N2U5MzdjNWZmNDQ6OjAwMDAwMDAwMDAwMDA0OTg3MjU6OiRhYWNoXzM5NTg5NmI5LTA3ODgtNGMyMC1hYWI5LWJhNjUwZTU1Y2JkMw==',
      },
      params: {
        'customer': customer,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? nextDate(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.data[:].nextDueDate''',
      ));
}

class PdfMonkeyCall {
  static Future<ApiCallResponse> call({
    String? title = '',
    List<String>? treinosList,
    String? documentTemplateId = '2EBAA80D-80A5-43FB-AB69-A3A8A5D02DA8',
  }) async {
    final treinos = _serializeList(treinosList);

    final ffApiRequestBody = '''
{
  "document": {
    "document_template_id": "2EBAA80D-80A5-43FB-AB69-A3A8A5D02DA8",
    "status": "pending",
    "payload": {
      "treinos": [
        ${treinos}
      ],
      "title": "${escapeStringForJson(title)}"
    },
    "meta": {
      "_filename": "Treinos Semanais.pdf",
      "clientRef": "unique-reference-id"
    }
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'pdfMonkey',
      apiUrl: 'https://api.pdfmonkey.io/api/v1/documents',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer KkKTouGpzFE9gbxE-H_L',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? url(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.document.preview_url''',
      ));
}

class GoogleImagesCall {
  static Future<ApiCallResponse> call({
    String? key = 'AIzaSyBnezv5hxCpD6rZYZSRyGJSdKe4IXiWC1c',
    String? q = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'googleImages',
      apiUrl:
          'https://www.googleapis.com/customsearch/v1?q=${q}&key=${key}&cx=9024e444f58c7431d',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'q': q,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? outherImgs(dynamic response) => (getJsonField(
        response,
        r'''$.items[:].pagemap.cse_image[:].src''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
  static List? imgs(dynamic response) => getJsonField(
        response,
        r'''$.items[:].pagemap.cse_image''',
        true,
      ) as List?;
}

class GooglePlaceCall {
  static Future<ApiCallResponse> call({
    String? latlng = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'google place',
      apiUrl:
          'https://maps.googleapis.com/maps/api/geocode/json?${latlng}&key=AIzaSyCMA7lb33cNJZH4TPFkyNQyiz4YUpDzjlI',
      callType: ApiCallType.GET,
      headers: {},
      params: {
        'latlng': latlng,
      },
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static List<String>? address(dynamic response) => (getJsonField(
        response,
        r'''$.results[:].address_components[:].long_name''',
        true,
      ) as List?)
          ?.withoutNulls
          .map((x) => castToType<String>(x))
          .withoutNulls
          .toList();
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
