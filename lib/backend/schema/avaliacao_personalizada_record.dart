import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AvaliacaoPersonalizadaRecord extends FirestoreRecord {
  AvaliacaoPersonalizadaRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nomeDaAvaliacao" field.
  String? _nomeDaAvaliacao;
  String get nomeDaAvaliacao => _nomeDaAvaliacao ?? '';
  bool hasNomeDaAvaliacao() => _nomeDaAvaliacao != null;

  // "observacao" field.
  String? _observacao;
  String get observacao => _observacao ?? '';
  bool hasObservacao() => _observacao != null;

  // "categoriaDaAvaliacao" field.
  String? _categoriaDaAvaliacao;
  String get categoriaDaAvaliacao => _categoriaDaAvaliacao ?? '';
  bool hasCategoriaDaAvaliacao() => _categoriaDaAvaliacao != null;

  // "dataDaAvaliacao" field.
  DateTime? _dataDaAvaliacao;
  DateTime? get dataDaAvaliacao => _dataDaAvaliacao;
  bool hasDataDaAvaliacao() => _dataDaAvaliacao != null;

  // "terminou" field.
  bool? _terminou;
  bool get terminou => _terminou ?? false;
  bool hasTerminou() => _terminou != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _nomeDaAvaliacao = snapshotData['nomeDaAvaliacao'] as String?;
    _observacao = snapshotData['observacao'] as String?;
    _categoriaDaAvaliacao = snapshotData['categoriaDaAvaliacao'] as String?;
    final dataDaAvaliacaoValue = snapshotData['dataDaAvaliacao'];
    if (dataDaAvaliacaoValue is DateTime) {
      _dataDaAvaliacao = dataDaAvaliacaoValue;
    } else if (dataDaAvaliacaoValue is Timestamp) {
      _dataDaAvaliacao = dataDaAvaliacaoValue.toDate();
    } else if (dataDaAvaliacaoValue is String) {
      _dataDaAvaliacao = DateTime.tryParse(dataDaAvaliacaoValue);
    } else {
      _dataDaAvaliacao = null;
    }

    final terminouValue = snapshotData['terminou'];
    if (terminouValue is bool) {
      _terminou = terminouValue;
    } else if (terminouValue is num) {
      _terminou = terminouValue != 0;
    } else if (terminouValue is String) {
      final v = terminouValue.trim().toLowerCase();
      _terminou = v == 'true' || v == '1' || v == 'sim' || v == 'yes';
    } else {
      _terminou = null;
    }
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('avaliacaoPersonalizada')
          : FirebaseFirestore.instance
              .collectionGroup('avaliacaoPersonalizada');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('avaliacaoPersonalizada').doc(id);

  static Stream<AvaliacaoPersonalizadaRecord> getDocument(
          DocumentReference ref) =>
      ref.snapshots().map((s) => AvaliacaoPersonalizadaRecord.fromSnapshot(s));

  static Future<AvaliacaoPersonalizadaRecord> getDocumentOnce(
          DocumentReference ref) =>
      ref.get().then((s) => AvaliacaoPersonalizadaRecord.fromSnapshot(s));

  static AvaliacaoPersonalizadaRecord fromSnapshot(DocumentSnapshot snapshot) =>
      AvaliacaoPersonalizadaRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AvaliacaoPersonalizadaRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AvaliacaoPersonalizadaRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AvaliacaoPersonalizadaRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AvaliacaoPersonalizadaRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAvaliacaoPersonalizadaRecordData({
  String? nomeDaAvaliacao,
  String? observacao,
  String? categoriaDaAvaliacao,
  DateTime? dataDaAvaliacao,
  bool? terminou,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nomeDaAvaliacao': nomeDaAvaliacao,
      'observacao': observacao,
      'categoriaDaAvaliacao': categoriaDaAvaliacao,
      'dataDaAvaliacao': dataDaAvaliacao,
      'terminou': terminou,
    }.withoutNulls,
  );

  return firestoreData;
}

class AvaliacaoPersonalizadaRecordDocumentEquality
    implements Equality<AvaliacaoPersonalizadaRecord> {
  const AvaliacaoPersonalizadaRecordDocumentEquality();

  @override
  bool equals(
      AvaliacaoPersonalizadaRecord? e1, AvaliacaoPersonalizadaRecord? e2) {
    return e1?.nomeDaAvaliacao == e2?.nomeDaAvaliacao &&
        e1?.observacao == e2?.observacao &&
        e1?.categoriaDaAvaliacao == e2?.categoriaDaAvaliacao &&
        e1?.dataDaAvaliacao == e2?.dataDaAvaliacao &&
        e1?.terminou == e2?.terminou;
  }

  @override
  int hash(AvaliacaoPersonalizadaRecord? e) => const ListEquality().hash([
        e?.nomeDaAvaliacao,
        e?.observacao,
        e?.categoriaDaAvaliacao,
        e?.dataDaAvaliacao,
        e?.terminou
      ]);

  @override
  bool isValidKey(Object? o) => o is AvaliacaoPersonalizadaRecord;
}
