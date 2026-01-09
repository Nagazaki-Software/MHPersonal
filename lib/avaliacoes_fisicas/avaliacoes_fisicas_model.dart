import '/auth/firebase_auth/auth_util.dart';
import '/avaliacao_in_personal/create_protocolo/create_protocolo_widget.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/components/feitopelomh_widget.dart';
import '/components/headerweb_widget.dart';
import '/components/voce_ainda_nao_add_avaliacao_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_charts.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import '/index.dart';
import 'avaliacoes_fisicas_widget.dart' show AvaliacoesFisicasWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AvaliacoesFisicasModel extends FlutterFlowModel<AvaliacoesFisicasWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in avaliacoesFisicas widget.
  List<AvaliacoesFisicasRecord>? queryAvFisicas;
  // Stores action output result for [Firestore Query - Query a collection] action in avaliacoesFisicas widget.
  AvaliacoesFisicasRecord? queryavfisica;
  // Stores action output result for [OpenRouter - Generate Text] action in avaliacoesFisicas widget.
  String? gemii;
  // Model for feitopelomh component.
  late FeitopelomhModel feitopelomhModel1;
  // Model for feitopelomh component.
  late FeitopelomhModel feitopelomhModel2;
  // Model for headerweb component.
  late HeaderwebModel headerwebModel;

  @override
  void initState(BuildContext context) {
    feitopelomhModel1 = createModel(context, () => FeitopelomhModel());
    feitopelomhModel2 = createModel(context, () => FeitopelomhModel());
    headerwebModel = createModel(context, () => HeaderwebModel());
  }

  @override
  void dispose() {
    feitopelomhModel1.dispose();
    feitopelomhModel2.dispose();
    headerwebModel.dispose();
  }
}
