// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Mantidos imports que podem ser usados internamente ou pelas funções chamadas
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart'; // Usado em showWebPaymentConfirmationSheet

// Chave publicável (verifique se é a correta)
const stripePublishableKey =
    'pk_live_51R56vnP3w93hGHYvDOl2CMgkHEBGV4JjVxba2i0Wz2txvwhOLv6m5prVChTktAGBkj1cNSNkHhLyZLpyCvG5Rre400XoB47JMe';

Future initializeStripe() async {
  // Garante inicialização única
  if (Stripe.publishableKey.isEmpty) {
    Stripe.publishableKey = stripePublishableKey;
    await Stripe.instance.applySettings();
  }
}

// Classe de resposta (mantida)
class StripeSubscriptionResponse {
  const StripeSubscriptionResponse({this.subscriptionId, this.errorMessage});
  final String? subscriptionId;
  final String? errorMessage;
}

/// Widget principal
class StripeSubscriptionWidget extends StatefulWidget {
  // Parâmetros necessários para a assinatura
  final String emailDoCliente;
  final String customerName;
  final String priceId; // ID do Preço da assinatura
  // ATENÇÃO: Adicione connectedAccountId se sua função backend precisar dele!
  // final String connectedAccountId;
  final double width;
  final double height;
  // Callback de sucesso/falha
  final Future Function(String? subscriptionId)? onSubscriptionSuccess;

  const StripeSubscriptionWidget({
    super.key,
    required this.emailDoCliente,
    required this.customerName,
    required this.priceId,
    required this.width,
    required this.height,
    // required this.connectedAccountId, // Descomente se usar Connect
    this.onSubscriptionSuccess,
    // Removidos width/height que eram do botão
  });

  @override
  State<StripeSubscriptionWidget> createState() =>
      _StripeSubscriptionWidgetState();
}

class _StripeSubscriptionWidgetState extends State<StripeSubscriptionWidget> {
  // Estado para indicar carregamento inicial e processamento
  bool _isProcessing = true;

  @override
  void initState() {
    super.initState();
    // Garante que o Stripe seja inicializado
    initializeStripe();

    // === ESTRUTURA IDÊNTICA À REFERÊNCIA ===
    // Chama o processo de assinatura após o primeiro frame ser construído
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return; // Evita erro se o widget for removido

      // Chama a função principal que lida com backend e UI do Stripe
      // Equivalente ao processStripePayment da referência
      final result = await processSubscriptionConfirmation(context);

      if (!mounted) return; // Verifica novamente após a chamada async

      // Tratamento do resultado (similar à referência)
      if (result.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erro na Assinatura: ${result.errorMessage}'),
              backgroundColor: FlutterFlowTheme.of(context).error),
        );
        // Chama o callback indicando falha (equivalente ao onPaymentSuccess(null))
        widget.onSubscriptionSuccess?.call(null);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Processo de assinatura iniciado!'),
              backgroundColor: FlutterFlowTheme.of(context).success),
        );
        // Chama o callback indicando sucesso com ID (equivalente ao onPaymentSuccess('success'))
        widget.onSubscriptionSuccess?.call(result.subscriptionId);
      }

      // Marca o processamento como concluído para remover o loading indicator
      setState(() {
        _isProcessing = false;
      });
    });
    // === FIM DA ESTRUTURA IDÊNTICA À REFERÊNCIA ===
  }

  // --- Funções internas (lógica da assinatura) ---

  // Chama o backend para criar a Assinatura (AJUSTE A URL E O BODY!)
  Future<Map<String, dynamic>> _createSubscription() async {
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //       VERIFIQUE ESTA URL E O CORPO DA REQUISIÇÃO ABAIXO!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    final url = Uri.parse(
        // Use a URL da sua função de *assinatura* (Normal ou Connect)
        'https://southamerica-east1-profissions-2746d.cloudfunctions.net/createSubscription'); // <--- VERIFIQUE A URL!

    try {
      final response = await http.post(
        Uri.parse('https://southamerica-east1-profissions-2746d.cloudfunctions.net/createInscricao'),
        headers: {'Content-Type': 'application/json'},
        // Ajuste o corpo conforme a função backend espera!
        body: jsonEncode({
          'email': widget.emailDoCliente,
          'name': widget.customerName,
          'priceId': widget.priceId,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // Tratamento de erro do backend (mantido da versão anterior)
        String errorMessage =
            'Erro ao preparar Assinatura: Status ${response.statusCode}';
        try {
          final errorBody = jsonDecode(response.body);
          // Tenta extrair 'error' ou 'details' da resposta
          if (errorBody != null && errorBody['error'] != null) {
            errorMessage += ' - ${errorBody['error']}';
          } else if (errorBody != null && errorBody['details'] != null) {
            errorMessage += ' - ${errorBody['details']}';
          } else {
            errorMessage += ' - ${response.body}';
          }
        } catch (e) {
          errorMessage += ' - ${response.body}';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      throw Exception('Erro de comunicação com backend: ${e.toString()}');
    }
    // Sem setState aqui
  }

  // Processa a confirmação (chama backend e UI Stripe)
  // (Estrutura similar ao processStripePayment da referência)
  Future<StripeSubscriptionResponse> processSubscriptionConfirmation(
    BuildContext context, {
    // Parâmetros opcionais mantidos caso showWebPaymentConfirmationSheet precise
    Color? buttonColor,
    Color? buttonTextColor,
    ThemeMode themeStyle = ThemeMode.system,
  }) async {
    try {
      // 1. Chama backend (equivalente a _createPaymentIntent na referência)
      final response = await _createSubscription();

      // Extrai dados necessários para Stripe (clientSecret é o principal)
      final clientSecret = response['clientSecret'];
      final subscriptionId = response['subscriptionId'];
      final customerId = response['customerId'];
      final ephemeralKey = response['ephemeralKey'];

      // Valida clientSecret (equivalente a validar paymentIntent na referência)
      if (clientSecret == null) {
        // Se backend não retornou 'error', cria uma mensagem genérica
        final backendError = response['error'] ??
            response['details'] ??
            'Client Secret não recebido do backend.';
        return StripeSubscriptionResponse(
            errorMessage: 'Falha ao iniciar pagamento: $backendError');
      }
      if (subscriptionId == null) {
        // Adiciona validação para subscriptionId também
        return StripeSubscriptionResponse(
            errorMessage:
                'Falha ao iniciar pagamento: ID da Assinatura não recebido do backend.');
      }

      // 2. Apresenta UI do Stripe (Web ou Mobile)
      if (kIsWeb) {
        // Chama diálogo Web (equivalente a showWebPaymentSheet na referência)
        // Nota: showWebPaymentConfirmationSheet ainda tem um botão interno.
        // Para ser 100% automático na web, precisaríamos integrar com Stripe Elements JS diretamente,
        // o que é bem mais complexo que usar CardField dentro de um diálogo.
        // Mantendo o diálogo por enquanto.
        return await showWebPaymentConfirmationSheet(
          context,
          subscriptionId: subscriptionId,
          paymentIntentClientSecret: clientSecret,
          buttonColor: buttonColor,
          buttonTextColor: buttonTextColor,
          themeStyle: themeStyle,
        );
      } else {
        // Lógica Mobile (equivalente a init/presentPaymentSheet na referência)
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: 'MH Personal Trainer', // Nome da sua loja
            customerEphemeralKeySecret: ephemeralKey, // Recomendado
            customerId: customerId, // Recomendado
            style: themeStyle,
            allowsDelayedPaymentMethods:
                true, // Para assinaturas e pagamentos posteriores
            /* applePay: const PaymentSheetApplePay(
              merchantCountryCode: 'BR', // Código do país, ex: BR
            ),*/
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'BR',
              testEnv: true, // Defina como false em produção
            ),
          ),
        );

        // Mostra o formulário do Stripe
        await Stripe.instance.presentPaymentSheet();

        // Se chegou aqui sem erro, a interação do usuário com o sheet terminou.
        // Retorna sucesso com o ID da assinatura (backend confirma o pagamento via webhook)
        return StripeSubscriptionResponse(subscriptionId: subscriptionId);
      }
    } on StripeException catch (e) {
      // Tratamento de erro do Stripe (igual à referência, adaptado para SubscriptionResponse)
      if (e.error.code == FailureCode.Canceled) {
        // Retorna objeto vazio ou com mensagem de cancelado? Vamos retornar mensagem.
        return StripeSubscriptionResponse(
            errorMessage: 'Pagamento cancelado pelo usuário.');
      }
      debugPrint('Stripe Error: ${e.error.localizedMessage}');
      return StripeSubscriptionResponse(
          errorMessage:
              e.error.localizedMessage ?? 'Erro no Stripe: ${e.error.code}');
    } catch (e) {
      // Tratamento de erro genérico (igual à referência, adaptado para SubscriptionResponse)
      debugPrint('Erro geral em processSubscriptionConfirmation: $e');
      return StripeSubscriptionResponse(
          errorMessage: 'Erro inesperado: ${e.toString()}');
    }
  }

  // Função do diálogo Web (mantida como estava, pois sua estrutura interna não foi referenciada)
  // Função do diálogo Web (mantida como estava, pois sua estrutura interna não foi referenciada)
  Future<StripeSubscriptionResponse> showWebPaymentConfirmationSheet(
    BuildContext context, {
    required String subscriptionId,
    required String paymentIntentClientSecret,
    Color? buttonColor,
    Color? buttonTextColor,
    ThemeMode? themeStyle,
  }) async {
    final isDarkMode = themeStyle == null
        ? Theme.of(context).brightness == Brightness.dark
        : themeStyle == ThemeMode.dark;

    buttonColor ??= FlutterFlowTheme.of(context).primary;
    buttonTextColor ??= Colors.white;
    final screenWidth = MediaQuery.sizeOf(context).width;
    bool _isDialogLoading = false;

    final result = await showDialog<StripeSubscriptionResponse>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: screenWidth < 480 ? screenWidth * 0.95 : 420,
                  padding: const EdgeInsets.all(24.0),
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 48, 47, 47),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Confirmação da Assinatura',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Outfit',
                              color: isDarkMode
                                  ? const Color(0xFF101213)
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Assinatura MH Personal Trainer',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .copyWith(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text('Tenha mais praticidade com seus alunos',
                                style: FlutterFlowTheme.of(context).bodyMedium),
                            const SizedBox(height: 4),
                            Text(
                                '✨ Benefícios: Treinos com IA, Alunos Ilimitados, Relatórios com IA',
                                style: FlutterFlowTheme.of(context).bodySmall),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      CardField(
                        autofocus: true,
                        onCardChanged: (details) {},
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDarkMode
                              ? const Color.fromARGB(255, 137, 136, 136)
                              : Colors.white,
                          labelText: 'Dados do Cartão',
                          labelStyle:
                              FlutterFlowTheme.of(context).labelMedium.copyWith(
                                    color: isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.grey[700],
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 16),
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                      ),
                      const SizedBox(height: 24.0),
                      FFButtonWidget(
                        onPressed: _isDialogLoading
                            ? null
                            : () async {
                                setDialogState(() => _isDialogLoading = true);
                                try {
                                  final result =
                                      await Stripe.instance.confirmPayment(
                                    paymentIntentClientSecret:
                                        paymentIntentClientSecret,
                                    data: PaymentMethodParams.card(
                                      paymentMethodData: PaymentMethodData(
                                        billingDetails: BillingDetails(
                                          email: widget.emailDoCliente,
                                          name: widget.customerName,
                                        ),
                                      ),
                                    ),
                                  );

                                  if (result.status ==
                                          PaymentIntentsStatus.Succeeded ||
                                      result.status ==
                                          PaymentIntentsStatus.Processing) {
                                    Navigator.pop(
                                      context,
                                      StripeSubscriptionResponse(
                                          subscriptionId: subscriptionId),
                                    );
                                  } else {
                                    String errorMsg =
                                        'Falha no pagamento: ${result.status.toString()}';
                                    if (result.status ==
                                        PaymentIntentsStatus
                                            .RequiresPaymentMethod) {
                                      errorMsg =
                                          'Método de pagamento inválido ou recusado.';
                                    } else if (result.status ==
                                        PaymentIntentsStatus.Canceled) {
                                      errorMsg = 'Pagamento cancelado.';
                                    } else if (result.status ==
                                        PaymentIntentsStatus.RequiresAction) {
                                      errorMsg =
                                          'Ação adicional necessária. Tente novamente.';
                                    }
                                    Navigator.pop(
                                      context,
                                      StripeSubscriptionResponse(
                                          errorMessage: errorMsg),
                                    );
                                  }
                                } on StripeException catch (e) {
                                  Navigator.pop(
                                    context,
                                    StripeSubscriptionResponse(
                                      errorMessage: e.error.localizedMessage ??
                                          'Erro Stripe',
                                    ),
                                  );
                                } catch (e) {
                                  Navigator.pop(
                                    context,
                                    StripeSubscriptionResponse(
                                      errorMessage: 'Erro inesperado: $e',
                                    ),
                                  );
                                } finally {
                                  setDialogState(
                                      () => _isDialogLoading = false);
                                }
                              },
                        text: '💳 Confirmar e Assinar',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 50,
                          color: buttonColor,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Outfit',
                                    color: buttonTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                          elevation: 3,
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        showLoadingIndicator: _isDialogLoading,
                      ),
                      const SizedBox(height: 12.0),
                      TextButton(
                        onPressed: _isDialogLoading
                            ? null
                            : () => Navigator.pop(
                                context,
                                StripeSubscriptionResponse(
                                    errorMessage: 'Assinatura cancelada.')),
                        child: Text(
                          'Cancelar',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                    color: isDarkMode
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    return result ?? StripeSubscriptionResponse(errorMessage: 'Cancelado');
  }

  @override
  Widget build(BuildContext context) {
    // Build method agora só mostra o loading inicial ou um container vazio
    // Estrutura similar ao que a referência faria se não tivesse botão no build
    return Center(
      child: _isProcessing
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            )
          : Container(), // Processo concluído (com sucesso ou erro - feedback via SnackBar)
    );
  }
}
