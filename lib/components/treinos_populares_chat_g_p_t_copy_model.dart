import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'treinos_populares_chat_g_p_t_copy_widget.dart'
    show TreinosPopularesChatGPTCopyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TreinosPopularesChatGPTCopyModel
    extends FlutterFlowModel<TreinosPopularesChatGPTCopyWidget> {
  ///  Local state fields for this component.

  RecomendacoesStruct? data;
  void updateDataStruct(Function(RecomendacoesStruct) updateFn) {
    updateFn(data ??= RecomendacoesStruct());
  }

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Firestore Query - Query a collection] action in treinosPopularesChatGPTCopy widget.
  List<TreinorsRecord>? queryTreinors;
  // Stores action output result for [OpenRouter - Generate Text] action in treinosPopularesChatGPTCopy widget.
  String? apiResult9eo;
  // Stores action output result for [OpenRouter - Generate Text] action in treinosPopularesChatGPTCopy widget.
  String? apiResult9eo2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
