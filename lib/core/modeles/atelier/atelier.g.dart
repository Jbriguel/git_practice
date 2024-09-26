// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'atelier.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Atelier> _$atelierSerializer = new _$AtelierSerializer();

class _$AtelierSerializer implements StructuredSerializer<Atelier> {
  @override
  final Iterable<Type> types = const [Atelier, _$Atelier];
  @override
  final String wireName = 'Atelier';

  @override
  Iterable<Object?> serialize(Serializers serializers, Atelier object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'entrepriseId',
      serializers.serialize(object.entrepriseId,
          specifiedType: const FullType(String)),
      'ownerId',
      serializers.serialize(object.ownerId,
          specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'identify',
      serializers.serialize(object.identify,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.adresse;
    if (value != null) {
      result
        ..add('adresse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.isDeleted;
    if (value != null) {
      result
        ..add('isDeleted')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.modifiedAt;
    if (value != null) {
      result
        ..add('modifiedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.deletedAt;
    if (value != null) {
      result
        ..add('deletedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    return result;
  }

  @override
  Atelier deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AtelierBuilder();

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
        case 'entrepriseId':
          result.entrepriseId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'ownerId':
          result.ownerId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'identify':
          result.identify = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'adresse':
          result.adresse = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isDeleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'modifiedAt':
          result.modifiedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
        case 'deletedAt':
          result.deletedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime?;
          break;
      }
    }

    return result.build();
  }
}

class _$Atelier extends Atelier {
  @override
  final String uid;
  @override
  final String entrepriseId;
  @override
  final String ownerId;
  @override
  final String name;
  @override
  final String identify;
  @override
  final String? adresse;
  @override
  final bool? isDeleted;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? modifiedAt;
  @override
  final DateTime? deletedAt;

  factory _$Atelier([void Function(AtelierBuilder)? updates]) =>
      (new AtelierBuilder()..update(updates))._build();

  _$Atelier._(
      {required this.uid,
      required this.entrepriseId,
      required this.ownerId,
      required this.name,
      required this.identify,
      this.adresse,
      this.isDeleted,
      this.createdAt,
      this.modifiedAt,
      this.deletedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(uid, r'Atelier', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        entrepriseId, r'Atelier', 'entrepriseId');
    BuiltValueNullFieldError.checkNotNull(ownerId, r'Atelier', 'ownerId');
    BuiltValueNullFieldError.checkNotNull(name, r'Atelier', 'name');
    BuiltValueNullFieldError.checkNotNull(identify, r'Atelier', 'identify');
  }

  @override
  Atelier rebuild(void Function(AtelierBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AtelierBuilder toBuilder() => new AtelierBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Atelier &&
        uid == other.uid &&
        entrepriseId == other.entrepriseId &&
        ownerId == other.ownerId &&
        name == other.name &&
        identify == other.identify &&
        adresse == other.adresse &&
        isDeleted == other.isDeleted &&
        createdAt == other.createdAt &&
        modifiedAt == other.modifiedAt &&
        deletedAt == other.deletedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, entrepriseId.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, identify.hashCode);
    _$hash = $jc(_$hash, adresse.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, modifiedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Atelier')
          ..add('uid', uid)
          ..add('entrepriseId', entrepriseId)
          ..add('ownerId', ownerId)
          ..add('name', name)
          ..add('identify', identify)
          ..add('adresse', adresse)
          ..add('isDeleted', isDeleted)
          ..add('createdAt', createdAt)
          ..add('modifiedAt', modifiedAt)
          ..add('deletedAt', deletedAt))
        .toString();
  }
}

class AtelierBuilder implements Builder<Atelier, AtelierBuilder> {
  _$Atelier? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _entrepriseId;
  String? get entrepriseId => _$this._entrepriseId;
  set entrepriseId(String? entrepriseId) => _$this._entrepriseId = entrepriseId;

  String? _ownerId;
  String? get ownerId => _$this._ownerId;
  set ownerId(String? ownerId) => _$this._ownerId = ownerId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _identify;
  String? get identify => _$this._identify;
  set identify(String? identify) => _$this._identify = identify;

  String? _adresse;
  String? get adresse => _$this._adresse;
  set adresse(String? adresse) => _$this._adresse = adresse;

  bool? _isDeleted;
  bool? get isDeleted => _$this._isDeleted;
  set isDeleted(bool? isDeleted) => _$this._isDeleted = isDeleted;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _modifiedAt;
  DateTime? get modifiedAt => _$this._modifiedAt;
  set modifiedAt(DateTime? modifiedAt) => _$this._modifiedAt = modifiedAt;

  DateTime? _deletedAt;
  DateTime? get deletedAt => _$this._deletedAt;
  set deletedAt(DateTime? deletedAt) => _$this._deletedAt = deletedAt;

  AtelierBuilder();

  AtelierBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _entrepriseId = $v.entrepriseId;
      _ownerId = $v.ownerId;
      _name = $v.name;
      _identify = $v.identify;
      _adresse = $v.adresse;
      _isDeleted = $v.isDeleted;
      _createdAt = $v.createdAt;
      _modifiedAt = $v.modifiedAt;
      _deletedAt = $v.deletedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Atelier other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Atelier;
  }

  @override
  void update(void Function(AtelierBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Atelier build() => _build();

  _$Atelier _build() {
    final _$result = _$v ??
        new _$Atelier._(
            uid: BuiltValueNullFieldError.checkNotNull(uid, r'Atelier', 'uid'),
            entrepriseId: BuiltValueNullFieldError.checkNotNull(
                entrepriseId, r'Atelier', 'entrepriseId'),
            ownerId: BuiltValueNullFieldError.checkNotNull(
                ownerId, r'Atelier', 'ownerId'),
            name:
                BuiltValueNullFieldError.checkNotNull(name, r'Atelier', 'name'),
            identify: BuiltValueNullFieldError.checkNotNull(
                identify, r'Atelier', 'identify'),
            adresse: adresse,
            isDeleted: isDeleted,
            createdAt: createdAt,
            modifiedAt: modifiedAt,
            deletedAt: deletedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
