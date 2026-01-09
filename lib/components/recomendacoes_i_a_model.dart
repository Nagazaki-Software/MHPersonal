import '/auth/firebase_auth/auth_util.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'recomendacoes_i_a_widget.dart' show RecomendacoesIAWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecomendacoesIAModel extends FlutterFlowModel<RecomendacoesIAWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [OpenRouter - Generate Text] action in recomendacoesIA widget.
  String? aiText;
  // Stores action output result for [OpenRouter - Generate Text] action in Container widget.
  String? aiResponse;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
