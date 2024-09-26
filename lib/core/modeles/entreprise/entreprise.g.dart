// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entreprise.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Entreprise> _$entrepriseSerializer = new _$EntrepriseSerializer();

class _$EntrepriseSerializer implements StructuredSerializer<Entreprise> {
  @override
  final Iterable<Type> types = const [Entreprise, _$Entreprise];
  @override
  final String wireName = 'Entreprise';

  @override
  Iterable<Object?> serialize(Serializers serializers, Entreprise object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'entrepriseName',
      serializers.serialize(object.entrepriseName,
          specifiedType: const FullType(String)),
      'logoUrl',
      serializers.serialize(object.logoUrl,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.hasAbonement;
    if (value != null) {
      result
        ..add('hasAbonement')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.entrepriseAbonementKey;
    if (value != null) {
      result
        ..add('entrepriseAbonementKey')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ownerId;
    if (value != null) {
      result
        ..add('ownerId')
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
  Entreprise deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EntrepriseBuilder();

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
        case 'entrepriseName':
          result.entrepriseName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'logoUrl':
          result.logoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'hasAbonement':
          result.hasAbonement = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'entrepriseAbonementKey':
          result.entrepriseAbonementKey = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'ownerId':
          result.ownerId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'isDeleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
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

class _$Entreprise extends Entreprise {
  @override
  final String uid;
  @override
  final String entrepriseName;
  @override
  final String logoUrl;
  @override
  final String description;
  @override
  final bool? hasAbonement;
  @override
  final String? entrepriseAbonementKey;
  @override
  final String? ownerId;
  @override
  final bool? isDeleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime? modifiedAt;
  @override
  final DateTime? deletedAt;

  factory _$Entreprise([void Function(EntrepriseBuilder)? updates]) =>
      (new EntrepriseBuilder()..update(updates))._build();

  _$Entreprise._(
      {required this.uid,
      required this.entrepriseName,
      required this.logoUrl,
      required this.description,
      this.hasAbonement,
      this.entrepriseAbonementKey,
      this.ownerId,
      this.isDeleted,
      required this.createdAt,
      this.modifiedAt,
      this.deletedAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(uid, r'Entreprise', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        entrepriseName, r'Entreprise', 'entrepriseName');
    BuiltValueNullFieldError.checkNotNull(logoUrl, r'Entreprise', 'logoUrl');
    BuiltValueNullFieldError.checkNotNull(
        description, r'Entreprise', 'description');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'Entreprise', 'createdAt');
  }

  @override
  Entreprise rebuild(void Function(EntrepriseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EntrepriseBuilder toBuilder() => new EntrepriseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Entreprise &&
        uid == other.uid &&
        entrepriseName == other.entrepriseName &&
        logoUrl == other.logoUrl &&
        description == other.description &&
        hasAbonement == other.hasAbonement &&
        entrepriseAbonementKey == other.entrepriseAbonementKey &&
        ownerId == other.ownerId &&
        isDeleted == other.isDeleted &&
        createdAt == other.createdAt &&
        modifiedAt == other.modifiedAt &&
        deletedAt == other.deletedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, entrepriseName.hashCode);
    _$hash = $jc(_$hash, logoUrl.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, hasAbonement.hashCode);
    _$hash = $jc(_$hash, entrepriseAbonementKey.hashCode);
    _$hash = $jc(_$hash, ownerId.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, modifiedAt.hashCode);
    _$hash = $jc(_$hash, deletedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Entreprise')
          ..add('uid', uid)
          ..add('entrepriseName', entrepriseName)
          ..add('logoUrl', logoUrl)
          ..add('description', description)
          ..add('hasAbonement', hasAbonement)
          ..add('entrepriseAbonementKey', entrepriseAbonementKey)
          ..add('ownerId', ownerId)
          ..add('isDeleted', isDeleted)
          ..add('createdAt', createdAt)
          ..add('modifiedAt', modifiedAt)
          ..add('deletedAt', deletedAt))
        .toString();
  }
}

class EntrepriseBuilder implements Builder<Entreprise, EntrepriseBuilder> {
  _$Entreprise? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _entrepriseName;
  String? get entrepriseName => _$this._entrepriseName;
  set entrepriseName(String? entrepriseName) =>
      _$this._entrepriseName = entrepriseName;

  String? _logoUrl;
  String? get logoUrl => _$this._logoUrl;
  set logoUrl(String? logoUrl) => _$this._logoUrl = logoUrl;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _hasAbonement;
  bool? get hasAbonement => _$this._hasAbonement;
  set hasAbonement(bool? hasAbonement) => _$this._hasAbonement = hasAbonement;

  String? _entrepriseAbonementKey;
  String? get entrepriseAbonementKey => _$this._entrepriseAbonementKey;
  set entrepriseAbonementKey(String? entrepriseAbonementKey) =>
      _$this._entrepriseAbonementKey = entrepriseAbonementKey;

  String? _ownerId;
  String? get ownerId => _$this._ownerId;
  set ownerId(String? ownerId) => _$this._ownerId = ownerId;

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

  EntrepriseBuilder();

  EntrepriseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _entrepriseName = $v.entrepriseName;
      _logoUrl = $v.logoUrl;
      _description = $v.description;
      _hasAbonement = $v.hasAbonement;
      _entrepriseAbonementKey = $v.entrepriseAbonementKey;
      _ownerId = $v.ownerId;
      _isDeleted = $v.isDeleted;
      _createdAt = $v.createdAt;
      _modifiedAt = $v.modifiedAt;
      _deletedAt = $v.deletedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Entreprise other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Entreprise;
  }

  @override
  void update(void Function(EntrepriseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Entreprise build() => _build();

  _$Entreprise _build() {
    final _$result = _$v ??
        new _$Entreprise._(
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'Entreprise', 'uid'),
            entrepriseName: BuiltValueNullFieldError.checkNotNull(
                entrepriseName, r'Entreprise', 'entrepriseName'),
            logoUrl: BuiltValueNullFieldError.checkNotNull(
                logoUrl, r'Entreprise', 'logoUrl'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, r'Entreprise', 'description'),
            hasAbonement: hasAbonement,
            entrepriseAbonementKey: entrepriseAbonementKey,
            ownerId: ownerId,
            isDeleted: isDeleted,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Entreprise', 'createdAt'),
            modifiedAt: modifiedAt,
            deletedAt: deletedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
