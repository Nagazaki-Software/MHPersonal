import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/headerweb_widget.dart';
import '/components/naoexistealuno_widget.dart';
import '/components/nenhumtreinodisponivelaluno_widget.dart';
import '/components/pagina_inicial_aluno_widget.dart';
import '/components/pagina_inicial_personal_widget.dart';
import '/components/profile_personal_widget.dart';
import '/components/treinos_populares_chat_g_p_t_widget.dart';
import '/components/upgrade_to_premium_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/personal/card_acoes/card_acoes_widget.dart';
import 'dart:math';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'pagina_inicial_widget.dart' show PaginaInicialWidget;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class PaginaInicialModel extends FlutterFlowModel<PaginaInicialWidget> {
  ///  Local state fields for this page.

  String defaultAI =
      'Ops, eu não consigo te responder algo sobre treino ou saúde.';

  bool abrirFAB = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in PaginaInicial widget.
  CreateTreinosRecord? createTreinosQuerry;
  // Stores action output result for [Firestore Query - Query a collection] action in PaginaInicial widget.
  PersonalAccountRecord? queryPersonal;
  // Stores action output result for [Firestore Query - Query a collection] action in PaginaInicial widget.
  UsersRecord? queryUser;
  // Model for paginaInicialAluno component.
  late PaginaInicialAlunoModel paginaInicialAlunoModel;
  // Model for PaginaInicialPersonal component.
  late PaginaInicialPersonalModel paginaInicialPersonalModel;
  // Model for treinosPopularesChatGPT component.
  late TreinosPopularesChatGPTModel treinosPopularesChatGPTModel;
  // Model for upgradeToPremium component.
  late UpgradeToPremiumModel upgradeToPremiumModel;
  // Model for headerweb component.
  late HeaderwebModel headerwebModel;

  @override
  void initState(BuildContext context) {
    paginaInicialAlunoModel =
        createModel(context, () => PaginaInicialAlunoModel());
    paginaInicialPersonalModel =
        createModel(context, () => PaginaInicialPersonalModel());
    treinosPopularesChatGPTModel =
        createModel(context, () => TreinosPopularesChatGPTModel());
    upgradeToPremiumModel = createModel(context, () => UpgradeToPremiumModel());
    headerwebModel = createModel(context, () => HeaderwebModel());
  }

  @override
  void dispose() {
    paginaInicialAlunoModel.dispose();
    paginaInicialPersonalModel.dispose();
    treinosPopularesChatGPTModel.dispose();
    upgradeToPremiumModel.dispose();
    headerwebModel.dispose();
  }
}
