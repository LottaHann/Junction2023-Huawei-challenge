import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventsRecord extends FirestoreRecord {
  EventsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "date_time" field.
  DateTime? _dateTime;
  DateTime? get dateTime => _dateTime;
  bool hasDateTime() => _dateTime != null;

  // "event_type" field.
  String? _eventType;
  String get eventType => _eventType ?? '';
  bool hasEventType() => _eventType != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "leaderboard" field.
  List<DocumentReference>? _leaderboard;
  List<DocumentReference> get leaderboard => _leaderboard ?? const [];
  bool hasLeaderboard() => _leaderboard != null;

  // "participants_or_waiting" field.
  int? _participantsOrWaiting;
  int get participantsOrWaiting => _participantsOrWaiting ?? 0;
  bool hasParticipantsOrWaiting() => _participantsOrWaiting != null;

  // "form_video" field.
  String? _formVideo;
  String get formVideo => _formVideo ?? '';
  bool hasFormVideo() => _formVideo != null;

  void _initializeFields() {
    _dateTime = snapshotData['date_time'] as DateTime?;
    _eventType = snapshotData['event_type'] as String?;
    _status = snapshotData['status'] as String?;
    _leaderboard = getDataList(snapshotData['leaderboard']);
    _participantsOrWaiting =
        castToType<int>(snapshotData['participants_or_waiting']);
    _formVideo = snapshotData['form_video'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventsRecord.fromSnapshot(s));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventsRecord.fromSnapshot(s));

  static EventsRecord fromSnapshot(DocumentSnapshot snapshot) => EventsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventsRecordData({
  DateTime? dateTime,
  String? eventType,
  String? status,
  int? participantsOrWaiting,
  String? formVideo,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'date_time': dateTime,
      'event_type': eventType,
      'status': status,
      'participants_or_waiting': participantsOrWaiting,
      'form_video': formVideo,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventsRecordDocumentEquality implements Equality<EventsRecord> {
  const EventsRecordDocumentEquality();

  @override
  bool equals(EventsRecord? e1, EventsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.dateTime == e2?.dateTime &&
        e1?.eventType == e2?.eventType &&
        e1?.status == e2?.status &&
        listEquality.equals(e1?.leaderboard, e2?.leaderboard) &&
        e1?.participantsOrWaiting == e2?.participantsOrWaiting &&
        e1?.formVideo == e2?.formVideo;
  }

  @override
  int hash(EventsRecord? e) => const ListEquality().hash([
        e?.dateTime,
        e?.eventType,
        e?.status,
        e?.leaderboard,
        e?.participantsOrWaiting,
        e?.formVideo
      ]);

  @override
  bool isValidKey(Object? o) => o is EventsRecord;
}
