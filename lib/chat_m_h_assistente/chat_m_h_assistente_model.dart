import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/components/perfil_do_mh_assistente_widget.dart';
import '/components/recomendacoes_i_a_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'chat_m_h_assistente_widget.dart' show ChatMHAssistenteWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ChatMHAssistenteModel extends FlutterFlowModel<ChatMHAssistenteWidget> {
  ///  Local state fields for this page.

  String? exercicio;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in chatMHAssistente widget.
  List<TreinorsRecord>? queryTreinors;
  // Stores action output result for [Firestore Query - Query a collection] action in chatMHAssistente widget.
  CreateTreinosRecord? queryCreatetREINOS;
  // Stores action output result for [OpenRouter - Generate Text] action in chatMHAssistente widget.
  String? primeiraCV;
  // State field(s) for Column widget.
  ScrollController? columnController;
  // Model for recomendacoesIA component.
  late RecomendacoesIAModel recomendacoesIAModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (openrouter conversa plano)] action in TextField widget.
  ApiCallResponse? chatGPT;
  // Stores action output result for [Backend Call - API (openrouter conversa plano)] action in Icon widget.
  ApiCallResponse? chatGPTCopy;

  @override
  void initState(BuildContext context) {
    columnController = ScrollController();
    recomendacoesIAModel = createModel(context, () => RecomendacoesIAModel());
  }

  @override
  void dispose() {
    columnController?.dispose();
    recomendacoesIAModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
