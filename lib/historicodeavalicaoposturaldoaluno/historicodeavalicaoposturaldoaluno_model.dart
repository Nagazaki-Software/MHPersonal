import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/openrouter/openrouter.dart';
import '/components/feitopelomh_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'historicodeavalicaoposturaldoaluno_widget.dart'
    show HistoricodeavalicaoposturaldoalunoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HistoricodeavalicaoposturaldoalunoModel
    extends FlutterFlowModel<HistoricodeavalicaoposturaldoalunoWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [OpenRouter - Generate Text] action in historicodeavalicaoposturaldoaluno widget.
  String? avPostural;
  // Model for feitopelomh component.
  late FeitopelomhModel feitopelomhModel;

  @override
  void initState(BuildContext context) {
    feitopelomhModel = createModel(context, () => FeitopelomhModel());
  }

  @override
  void dispose() {
    feitopelomhModel.dispose();
  }
}
