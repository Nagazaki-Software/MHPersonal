import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth/firebase_auth/auth_util.dart';

import '../flutter_flow/flutter_flow_util.dart';
import 'schema/util/firestore_util.dart';

import 'schema/users_record.dart';
import 'schema/professor_account_record.dart';
import 'schema/personal_account_record.dart';
import 'schema/rotina_de_treinos_for_alunos_record.dart';
import 'schema/create_treinos_record.dart';
import 'schema/treinos_record.dart';
import 'schema/avaliacoes_fisicas_record.dart';
import 'schema/avaliacao_postural_record.dart';
import 'schema/treino_peitoral_record.dart';
import 'schema/peitoral_treinos_record.dart';
import 'schema/avaliacao_online_record.dart';
import 'schema/meu_progresso_record.dart';
import 'schema/mega_treinos_record.dart';
import 'schema/treinors_record.dart';
import 'schema/treinos_with_video_record.dart';
import 'schema/arquivos_record.dart';
import 'schema/arquivos_do_personal_record.dart';
import 'schema/series_repeticoes_record.dart';
import 'schema/feedback_record.dart';
import 'schema/treinos_criados_record.dart';
import 'schema/seustreinos_record.dart';
import 'schema/treinos_do_professor_record.dart';
import 'schema/evolucao_de_carga_record.dart';
import 'schema/group_record.dart';
import 'schema/treinos_prescritos_record.dart';
import 'schema/series_prescritas_record.dart';
import 'schema/treinos_chat_gpt_record.dart';
import 'schema/avaliacao_personalizada_record.dart';
import 'schema/perguntas_das_avaliacoes_personalizadas_record.dart';
import 'schema/notificacao_record.dart';
import 'schema/pagamentos_record.dart';
import 'schema/recomendados_do_usuario_record.dart';
import 'schema/grupo_de_gerenciamentos_record.dart';
import 'schema/aerobico_record.dart';
import 'schema/treinoaerobico_record.dart';
import 'schema/conversa_record.dart';
import 'schema/in_chat_record.dart';
import 'schema/agendamento_m_h_agendamento_record.dart';
import 'schema/supporte_record.dart';

export 'dart:async' show StreamSubscription;
export 'package:cloud_firestore/cloud_firestore.dart' hide Order;
export 'package:firebase_core/firebase_core.dart';
export 'schema/index.dart';
export 'schema/util/firestore_util.dart';
export 'schema/util/schema_util.dart';

export 'schema/users_record.dart';
export 'schema/professor_account_record.dart';
export 'schema/personal_account_record.dart';
export 'schema/rotina_de_treinos_for_alunos_record.dart';
export 'schema/create_treinos_record.dart';
export 'schema/treinos_record.dart';
export 'schema/avaliacoes_fisicas_record.dart';
export 'schema/avaliacao_postural_record.dart';
export 'schema/treino_peitoral_record.dart';
export 'schema/peitoral_treinos_record.dart';
export 'schema/avaliacao_online_record.dart';
export 'schema/meu_progresso_record.dart';
export 'schema/mega_treinos_record.dart';
export 'schema/treinors_record.dart';
export 'schema/treinos_with_video_record.dart';
export 'schema/arquivos_record.dart';
export 'schema/arquivos_do_personal_record.dart';
export 'schema/series_repeticoes_record.dart';
export 'schema/feedback_record.dart';
export 'schema/treinos_criados_record.dart';
export 'schema/seustreinos_record.dart';
export 'schema/treinos_do_professor_record.dart';
export 'schema/evolucao_de_carga_record.dart';
export 'schema/group_record.dart';
export 'schema/treinos_prescritos_record.dart';
export 'schema/series_prescritas_record.dart';
export 'schema/treinos_chat_gpt_record.dart';
export 'schema/avaliacao_personalizada_record.dart';
export 'schema/perguntas_das_avaliacoes_personalizadas_record.dart';
export 'schema/notificacao_record.dart';
export 'schema/pagamentos_record.dart';
export 'schema/recomendados_do_usuario_record.dart';
export 'schema/grupo_de_gerenciamentos_record.dart';
export 'schema/aerobico_record.dart';
export 'schema/treinoaerobico_record.dart';
export 'schema/conversa_record.dart';
export 'schema/in_chat_record.dart';
export 'schema/agendamento_m_h_agendamento_record.dart';
export 'schema/supporte_record.dart';

/// Functions to query UsersRecords (as a Stream and as a Future).
Future<int> queryUsersRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      UsersRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<UsersRecord>> queryUsersRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      UsersRecord.collection,
      UsersRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<UsersRecord>> queryUsersRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      UsersRecord.collection,
      UsersRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query ProfessorAccountRecords (as a Stream and as a Future).
Future<int> queryProfessorAccountRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      ProfessorAccountRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<ProfessorAccountRecord>> queryProfessorAccountRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ProfessorAccountRecord.collection,
      ProfessorAccountRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<ProfessorAccountRecord>> queryProfessorAccountRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      ProfessorAccountRecord.collection,
      ProfessorAccountRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query PersonalAccountRecords (as a Stream and as a Future).
Future<int> queryPersonalAccountRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      PersonalAccountRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<PersonalAccountRecord>> queryPersonalAccountRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      PersonalAccountRecord.collection(parent),
      PersonalAccountRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<PersonalAccountRecord>> queryPersonalAccountRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      PersonalAccountRecord.collection(parent),
      PersonalAccountRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query RotinaDeTreinosForAlunosRecords (as a Stream and as a Future).
Future<int> queryRotinaDeTreinosForAlunosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      RotinaDeTreinosForAlunosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<RotinaDeTreinosForAlunosRecord>>
    queryRotinaDeTreinosForAlunosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollection(
          RotinaDeTreinosForAlunosRecord.collection(parent),
          RotinaDeTreinosForAlunosRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

Future<List<RotinaDeTreinosForAlunosRecord>>
    queryRotinaDeTreinosForAlunosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollectionOnce(
          RotinaDeTreinosForAlunosRecord.collection(parent),
          RotinaDeTreinosForAlunosRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

/// Functions to query CreateTreinosRecords (as a Stream and as a Future).
Future<int> queryCreateTreinosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      CreateTreinosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<CreateTreinosRecord>> queryCreateTreinosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      CreateTreinosRecord.collection(parent),
      CreateTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<CreateTreinosRecord>> queryCreateTreinosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      CreateTreinosRecord.collection(parent),
      CreateTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosRecords (as a Stream and as a Future).
Future<int> queryTreinosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosRecord>> queryTreinosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosRecord.collection(parent),
      TreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosRecord>> queryTreinosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosRecord.collection(parent),
      TreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AvaliacoesFisicasRecords (as a Stream and as a Future).
Future<int> queryAvaliacoesFisicasRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AvaliacoesFisicasRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AvaliacoesFisicasRecord>> queryAvaliacoesFisicasRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      AvaliacoesFisicasRecord.collection(parent),
      AvaliacoesFisicasRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<AvaliacoesFisicasRecord>> queryAvaliacoesFisicasRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      AvaliacoesFisicasRecord.collection(parent),
      AvaliacoesFisicasRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AvaliacaoPosturalRecords (as a Stream and as a Future).
Future<int> queryAvaliacaoPosturalRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AvaliacaoPosturalRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AvaliacaoPosturalRecord>> queryAvaliacaoPosturalRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      AvaliacaoPosturalRecord.collection(parent),
      AvaliacaoPosturalRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<AvaliacaoPosturalRecord>> queryAvaliacaoPosturalRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      AvaliacaoPosturalRecord.collection(parent),
      AvaliacaoPosturalRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinoPeitoralRecords (as a Stream and as a Future).
Future<int> queryTreinoPeitoralRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinoPeitoralRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinoPeitoralRecord>> queryTreinoPeitoralRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinoPeitoralRecord.collection,
      TreinoPeitoralRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinoPeitoralRecord>> queryTreinoPeitoralRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinoPeitoralRecord.collection,
      TreinoPeitoralRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query PeitoralTreinosRecords (as a Stream and as a Future).
Future<int> queryPeitoralTreinosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      PeitoralTreinosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<PeitoralTreinosRecord>> queryPeitoralTreinosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      PeitoralTreinosRecord.collection(parent),
      PeitoralTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<PeitoralTreinosRecord>> queryPeitoralTreinosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      PeitoralTreinosRecord.collection(parent),
      PeitoralTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AvaliacaoOnlineRecords (as a Stream and as a Future).
Future<int> queryAvaliacaoOnlineRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AvaliacaoOnlineRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AvaliacaoOnlineRecord>> queryAvaliacaoOnlineRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      AvaliacaoOnlineRecord.collection(parent),
      AvaliacaoOnlineRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<AvaliacaoOnlineRecord>> queryAvaliacaoOnlineRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      AvaliacaoOnlineRecord.collection(parent),
      AvaliacaoOnlineRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query MeuProgressoRecords (as a Stream and as a Future).
Future<int> queryMeuProgressoRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      MeuProgressoRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<MeuProgressoRecord>> queryMeuProgressoRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      MeuProgressoRecord.collection(parent),
      MeuProgressoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<MeuProgressoRecord>> queryMeuProgressoRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      MeuProgressoRecord.collection(parent),
      MeuProgressoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query MegaTreinosRecords (as a Stream and as a Future).
Future<int> queryMegaTreinosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      MegaTreinosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<MegaTreinosRecord>> queryMegaTreinosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      MegaTreinosRecord.collection(parent),
      MegaTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<MegaTreinosRecord>> queryMegaTreinosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      MegaTreinosRecord.collection(parent),
      MegaTreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinorsRecords (as a Stream and as a Future).
Future<int> queryTreinorsRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinorsRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinorsRecord>> queryTreinorsRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinorsRecord.collection,
      TreinorsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinorsRecord>> queryTreinorsRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinorsRecord.collection,
      TreinorsRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosWithVideoRecords (as a Stream and as a Future).
Future<int> queryTreinosWithVideoRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosWithVideoRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosWithVideoRecord>> queryTreinosWithVideoRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosWithVideoRecord.collection,
      TreinosWithVideoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosWithVideoRecord>> queryTreinosWithVideoRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosWithVideoRecord.collection,
      TreinosWithVideoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query ArquivosRecords (as a Stream and as a Future).
Future<int> queryArquivosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      ArquivosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<ArquivosRecord>> queryArquivosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ArquivosRecord.collection(parent),
      ArquivosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<ArquivosRecord>> queryArquivosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      ArquivosRecord.collection(parent),
      ArquivosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query ArquivosDoPersonalRecords (as a Stream and as a Future).
Future<int> queryArquivosDoPersonalRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      ArquivosDoPersonalRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<ArquivosDoPersonalRecord>> queryArquivosDoPersonalRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ArquivosDoPersonalRecord.collection(parent),
      ArquivosDoPersonalRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<ArquivosDoPersonalRecord>> queryArquivosDoPersonalRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      ArquivosDoPersonalRecord.collection(parent),
      ArquivosDoPersonalRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query SeriesRepeticoesRecords (as a Stream and as a Future).
Future<int> querySeriesRepeticoesRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      SeriesRepeticoesRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<SeriesRepeticoesRecord>> querySeriesRepeticoesRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      SeriesRepeticoesRecord.collection(parent),
      SeriesRepeticoesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<SeriesRepeticoesRecord>> querySeriesRepeticoesRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      SeriesRepeticoesRecord.collection(parent),
      SeriesRepeticoesRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query FeedbackRecords (as a Stream and as a Future).
Future<int> queryFeedbackRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      FeedbackRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<FeedbackRecord>> queryFeedbackRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      FeedbackRecord.collection(parent),
      FeedbackRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<FeedbackRecord>> queryFeedbackRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      FeedbackRecord.collection(parent),
      FeedbackRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosCriadosRecords (as a Stream and as a Future).
Future<int> queryTreinosCriadosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosCriadosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosCriadosRecord>> queryTreinosCriadosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosCriadosRecord.collection(parent),
      TreinosCriadosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosCriadosRecord>> queryTreinosCriadosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosCriadosRecord.collection(parent),
      TreinosCriadosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query SeustreinosRecords (as a Stream and as a Future).
Future<int> querySeustreinosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      SeustreinosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<SeustreinosRecord>> querySeustreinosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      SeustreinosRecord.collection(parent),
      SeustreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<SeustreinosRecord>> querySeustreinosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      SeustreinosRecord.collection(parent),
      SeustreinosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosDoProfessorRecords (as a Stream and as a Future).
Future<int> queryTreinosDoProfessorRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosDoProfessorRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosDoProfessorRecord>> queryTreinosDoProfessorRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosDoProfessorRecord.collection(parent),
      TreinosDoProfessorRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosDoProfessorRecord>> queryTreinosDoProfessorRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosDoProfessorRecord.collection(parent),
      TreinosDoProfessorRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query EvolucaoDeCargaRecords (as a Stream and as a Future).
Future<int> queryEvolucaoDeCargaRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      EvolucaoDeCargaRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<EvolucaoDeCargaRecord>> queryEvolucaoDeCargaRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      EvolucaoDeCargaRecord.collection(parent),
      EvolucaoDeCargaRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<EvolucaoDeCargaRecord>> queryEvolucaoDeCargaRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      EvolucaoDeCargaRecord.collection(parent),
      EvolucaoDeCargaRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query GroupRecords (as a Stream and as a Future).
Future<int> queryGroupRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      GroupRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<GroupRecord>> queryGroupRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      GroupRecord.collection(parent),
      GroupRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<GroupRecord>> queryGroupRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      GroupRecord.collection(parent),
      GroupRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosPrescritosRecords (as a Stream and as a Future).
Future<int> queryTreinosPrescritosRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosPrescritosRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosPrescritosRecord>> queryTreinosPrescritosRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosPrescritosRecord.collection,
      TreinosPrescritosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosPrescritosRecord>> queryTreinosPrescritosRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosPrescritosRecord.collection,
      TreinosPrescritosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query SeriesPrescritasRecords (as a Stream and as a Future).
Future<int> querySeriesPrescritasRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      SeriesPrescritasRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<SeriesPrescritasRecord>> querySeriesPrescritasRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      SeriesPrescritasRecord.collection,
      SeriesPrescritasRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<SeriesPrescritasRecord>> querySeriesPrescritasRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      SeriesPrescritasRecord.collection,
      SeriesPrescritasRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinosChatGptRecords (as a Stream and as a Future).
Future<int> queryTreinosChatGptRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinosChatGptRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinosChatGptRecord>> queryTreinosChatGptRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinosChatGptRecord.collection,
      TreinosChatGptRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinosChatGptRecord>> queryTreinosChatGptRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinosChatGptRecord.collection,
      TreinosChatGptRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AvaliacaoPersonalizadaRecords (as a Stream and as a Future).
Future<int> queryAvaliacaoPersonalizadaRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AvaliacaoPersonalizadaRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AvaliacaoPersonalizadaRecord>> queryAvaliacaoPersonalizadaRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      AvaliacaoPersonalizadaRecord.collection(parent),
      AvaliacaoPersonalizadaRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<AvaliacaoPersonalizadaRecord>>
    queryAvaliacaoPersonalizadaRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollectionOnce(
          AvaliacaoPersonalizadaRecord.collection(parent),
          AvaliacaoPersonalizadaRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

/// Functions to query PerguntasDasAvaliacoesPersonalizadasRecords (as a Stream and as a Future).
Future<int> queryPerguntasDasAvaliacoesPersonalizadasRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      PerguntasDasAvaliacoesPersonalizadasRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<PerguntasDasAvaliacoesPersonalizadasRecord>>
    queryPerguntasDasAvaliacoesPersonalizadasRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollection(
          PerguntasDasAvaliacoesPersonalizadasRecord.collection(parent),
          PerguntasDasAvaliacoesPersonalizadasRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

Future<List<PerguntasDasAvaliacoesPersonalizadasRecord>>
    queryPerguntasDasAvaliacoesPersonalizadasRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollectionOnce(
          PerguntasDasAvaliacoesPersonalizadasRecord.collection(parent),
          PerguntasDasAvaliacoesPersonalizadasRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

/// Functions to query NotificacaoRecords (as a Stream and as a Future).
Future<int> queryNotificacaoRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      NotificacaoRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<NotificacaoRecord>> queryNotificacaoRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      NotificacaoRecord.collection,
      NotificacaoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<NotificacaoRecord>> queryNotificacaoRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      NotificacaoRecord.collection,
      NotificacaoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query PagamentosRecords (as a Stream and as a Future).
Future<int> queryPagamentosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      PagamentosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<PagamentosRecord>> queryPagamentosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      PagamentosRecord.collection(parent),
      PagamentosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<PagamentosRecord>> queryPagamentosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      PagamentosRecord.collection(parent),
      PagamentosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query RecomendadosDoUsuarioRecords (as a Stream and as a Future).
Future<int> queryRecomendadosDoUsuarioRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      RecomendadosDoUsuarioRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<RecomendadosDoUsuarioRecord>> queryRecomendadosDoUsuarioRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      RecomendadosDoUsuarioRecord.collection(parent),
      RecomendadosDoUsuarioRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<RecomendadosDoUsuarioRecord>> queryRecomendadosDoUsuarioRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      RecomendadosDoUsuarioRecord.collection(parent),
      RecomendadosDoUsuarioRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query GrupoDeGerenciamentosRecords (as a Stream and as a Future).
Future<int> queryGrupoDeGerenciamentosRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      GrupoDeGerenciamentosRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<GrupoDeGerenciamentosRecord>> queryGrupoDeGerenciamentosRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      GrupoDeGerenciamentosRecord.collection(parent),
      GrupoDeGerenciamentosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<GrupoDeGerenciamentosRecord>> queryGrupoDeGerenciamentosRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      GrupoDeGerenciamentosRecord.collection(parent),
      GrupoDeGerenciamentosRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AerobicoRecords (as a Stream and as a Future).
Future<int> queryAerobicoRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AerobicoRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AerobicoRecord>> queryAerobicoRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      AerobicoRecord.collection(parent),
      AerobicoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<AerobicoRecord>> queryAerobicoRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      AerobicoRecord.collection(parent),
      AerobicoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query TreinoaerobicoRecords (as a Stream and as a Future).
Future<int> queryTreinoaerobicoRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      TreinoaerobicoRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<TreinoaerobicoRecord>> queryTreinoaerobicoRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      TreinoaerobicoRecord.collection(parent),
      TreinoaerobicoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<TreinoaerobicoRecord>> queryTreinoaerobicoRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      TreinoaerobicoRecord.collection(parent),
      TreinoaerobicoRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query ConversaRecords (as a Stream and as a Future).
Future<int> queryConversaRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      ConversaRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<ConversaRecord>> queryConversaRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      ConversaRecord.collection,
      ConversaRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<ConversaRecord>> queryConversaRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      ConversaRecord.collection,
      ConversaRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query InChatRecords (as a Stream and as a Future).
Future<int> queryInChatRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      InChatRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<InChatRecord>> queryInChatRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      InChatRecord.collection(parent),
      InChatRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<InChatRecord>> queryInChatRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      InChatRecord.collection(parent),
      InChatRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

/// Functions to query AgendamentoMHAgendamentoRecords (as a Stream and as a Future).
Future<int> queryAgendamentoMHAgendamentoRecordCount({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      AgendamentoMHAgendamentoRecord.collection(parent),
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<AgendamentoMHAgendamentoRecord>>
    queryAgendamentoMHAgendamentoRecord({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollection(
          AgendamentoMHAgendamentoRecord.collection(parent),
          AgendamentoMHAgendamentoRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

Future<List<AgendamentoMHAgendamentoRecord>>
    queryAgendamentoMHAgendamentoRecordOnce({
  DocumentReference? parent,
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
        queryCollectionOnce(
          AgendamentoMHAgendamentoRecord.collection(parent),
          AgendamentoMHAgendamentoRecord.fromSnapshot,
          queryBuilder: queryBuilder,
          limit: limit,
          singleRecord: singleRecord,
        );

/// Functions to query SupporteRecords (as a Stream and as a Future).
Future<int> querySupporteRecordCount({
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) =>
    queryCollectionCount(
      SupporteRecord.collection,
      queryBuilder: queryBuilder,
      limit: limit,
    );

Stream<List<SupporteRecord>> querySupporteRecord({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollection(
      SupporteRecord.collection,
      SupporteRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<List<SupporteRecord>> querySupporteRecordOnce({
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) =>
    queryCollectionOnce(
      SupporteRecord.collection,
      SupporteRecord.fromSnapshot,
      queryBuilder: queryBuilder,
      limit: limit,
      singleRecord: singleRecord,
    );

Future<int> queryCollectionCount(
  Query collection, {
  Query Function(Query)? queryBuilder,
  int limit = -1,
}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0) {
    query = query.limit(limit);
  }

  return query.count().get().catchError((err) {
    print('Error querying $collection: $err');
  }).then((value) => value.count!);
}

Stream<List<T>> queryCollection<T>(
  Query collection,
  RecordBuilder<T> recordBuilder, {
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query
      .snapshots()
      .transform(StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
          QuerySnapshot<Map<String, dynamic>>>.fromHandlers(handleError:
          (err, stack, sink) {
        print('Error querying $collection: $err');
        sink.addError(err, stack);
      }))
      .map((s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList());
}

Future<List<T>> queryCollectionOnce<T>(
  Query collection,
  RecordBuilder<T> recordBuilder, {
  Query Function(Query)? queryBuilder,
  int limit = -1,
  bool singleRecord = false,
}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.get().then((s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList());
}

Filter filterIn(String field, List? list) => (list?.isEmpty ?? true)
    ? Filter(field, whereIn: null)
    : Filter(field, whereIn: list);

Filter filterArrayContainsAny(String field, List? list) =>
    (list?.isEmpty ?? true)
        ? Filter(field, arrayContainsAny: null)
        : Filter(field, arrayContainsAny: list);

extension QueryExtension on Query {
  Query whereIn(String field, List? list) => (list?.isEmpty ?? true)
      ? where(field, whereIn: null)
      : where(field, whereIn: list);

  Query whereNotIn(String field, List? list) => (list?.isEmpty ?? true)
      ? where(field, whereNotIn: null)
      : where(field, whereNotIn: list);

  Query whereArrayContainsAny(String field, List? list) =>
      (list?.isEmpty ?? true)
          ? where(field, arrayContainsAny: null)
          : where(field, arrayContainsAny: list);
}

class FFFirestorePage<T> {
  final List<T> data;
  final Stream<List<T>>? dataStream;
  final QueryDocumentSnapshot? nextPageMarker;

  FFFirestorePage(this.data, this.dataStream, this.nextPageMarker);
}

Future<FFFirestorePage<T>> queryCollectionPage<T>(
  Query collection,
  RecordBuilder<T> recordBuilder, {
  Query Function(Query)? queryBuilder,
  DocumentSnapshot? nextPageMarker,
  required int pageSize,
  required bool isStream,
}) async {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection).limit(pageSize);
  if (nextPageMarker != null) {
    query = query.startAfterDocument(nextPageMarker);
  }
  Stream<QuerySnapshot>? docSnapshotStream;
  QuerySnapshot docSnapshot;
  if (isStream) {
    docSnapshotStream = query.snapshots();
    docSnapshot = await docSnapshotStream.first;
  } else {
    docSnapshot = await query.get();
  }
  final getDocs = (QuerySnapshot s) => s.docs
      .map(
        (d) => safeGet(
          () => recordBuilder(d),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .map((d) => d!)
      .toList();
  final data = getDocs(docSnapshot);
  final dataStream = docSnapshotStream?.map(getDocs);
  final nextPageToken = docSnapshot.docs.isEmpty ? null : docSnapshot.docs.last;
  return FFFirestorePage(data, dataStream, nextPageToken);
}

// Creates a Firestore document representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  final userRecord = UsersRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    currentUserDocument = await UsersRecord.getDocumentOnce(userRecord);
    return;
  }

  final userData = createUsersRecordData(
    email: user.email ??
        FirebaseAuth.instance.currentUser?.email ??
        user.providerData.firstOrNull?.email,
    displayName:
        user.displayName ?? FirebaseAuth.instance.currentUser?.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    phoneNumber: user.phoneNumber,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
  currentUserDocument = UsersRecord.getDocumentFromData(userData, userRecord);
}

Future updateUserDocument({String? email}) async {
  await currentUserDocument?.reference
      .update(createUsersRecordData(email: email));
}
