// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abonnement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Abonnement> _$abonnementSerializer = new _$AbonnementSerializer();

class _$AbonnementSerializer implements StructuredSerializer<Abonnement> {
  @override
  final Iterable<Type> types = const [Abonnement, _$Abonnement];
  @override
  final String wireName = 'Abonnement';

  @override
  Iterable<Object?> serialize(Serializers serializers, Abonnement object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'abonementName',
      serializers.serialize(object.abonementName,
          specifiedType: const FullType(String)),
      'abonnementKey',
      serializers.serialize(object.abonnementKey,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  Abonnement deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AbonnementBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'abonementName':
          result.abonementName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'abonnementKey':
          result.abonnementKey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$Abonnement extends Abonnement {
  @override
  final String uid;
  @override
  final String abonementName;
  @override
  final String abonnementKey;
  @override
  final DateTime createdAt;

  factory _$Abonnement([void Function(AbonnementBuilder)? updates]) =>
      (new AbonnementBuilder()..update(updates))._build();

  _$Abonnement._(
      {required this.uid,
      required this.abonementName,
      required this.abonnementKey,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(uid, r'Abonnement', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        abonementName, r'Abonnement', 'abonementName');
    BuiltValueNullFieldError.checkNotNull(
        abonnementKey, r'Abonnement', 'abonnementKey');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'Abonnement', 'createdAt');
  }

  @override
  Abonnement rebuild(void Function(AbonnementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AbonnementBuilder toBuilder() => new AbonnementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Abonnement &&
        uid == other.uid &&
        abonementName == other.abonementName &&
        abonnementKey == other.abonnementKey &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, abonementName.hashCode);
    _$hash = $jc(_$hash, abonnementKey.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Abonnement')
          ..add('uid', uid)
          ..add('abonementName', abonementName)
          ..add('abonnementKey', abonnementKey)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class AbonnementBuilder implements Builder<Abonnement, AbonnementBuilder> {
  _$Abonnement? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _abonementName;
  String? get abonementName => _$this._abonementName;
  set abonementName(String? abonementName) =>
      _$this._abonementName = abonementName;

  String? _abonnementKey;
  String? get abonnementKey => _$this._abonnementKey;
  set abonnementKey(String? abonnementKey) =>
      _$this._abonnementKey = abonnementKey;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  AbonnementBuilder();

  AbonnementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _abonementName = $v.abonementName;
      _abonnementKey = $v.abonnementKey;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Abonnement other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Abonnement;
  }

  @override
  void update(void Function(AbonnementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Abonnement build() => _build();

  _$Abonnement _build() {
    final _$result = _$v ??
        new _$Abonnement._(
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'Abonnement', 'uid'),
            abonementName: BuiltValueNullFieldError.checkNotNull(
                abonementName, r'Abonnement', 'abonementName'),
            abonnementKey: BuiltValueNullFieldError.checkNotNull(
                abonnementKey, r'Abonnement', 'abonnementKey'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Abonnement', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
