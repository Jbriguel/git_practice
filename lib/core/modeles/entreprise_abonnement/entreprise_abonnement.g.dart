// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entreprise_abonnement.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<EntrepriseAbonnement> _$entrepriseAbonnementSerializer =
    new _$EntrepriseAbonnementSerializer();

class _$EntrepriseAbonnementSerializer
    implements StructuredSerializer<EntrepriseAbonnement> {
  @override
  final Iterable<Type> types = const [
    EntrepriseAbonnement,
    _$EntrepriseAbonnement
  ];
  @override
  final String wireName = 'EntrepriseAbonnement';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, EntrepriseAbonnement object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'permissions',
      serializers.serialize(object.permissions,
          specifiedType:
              const FullType(List, const [const FullType(Permission)])),
      'entrepriseAbonementKey',
      serializers.serialize(object.entrepriseAbonementKey,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'expiredAt',
      serializers.serialize(object.expiredAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  EntrepriseAbonnement deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EntrepriseAbonnementBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'permissions':
          result.permissions = serializers.deserialize(value,
                  specifiedType:
                      const FullType(List, const [const FullType(Permission)]))!
              as List<Permission>;
          break;
        case 'entrepriseAbonementKey':
          result.entrepriseAbonementKey = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'expiredAt':
          result.expiredAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
      }
    }

    return result.build();
  }
}

class _$EntrepriseAbonnement extends EntrepriseAbonnement {
  @override
  final List<Permission> permissions;
  @override
  final String entrepriseAbonementKey;
  @override
  final DateTime createdAt;
  @override
  final DateTime expiredAt;

  factory _$EntrepriseAbonnement(
          [void Function(EntrepriseAbonnementBuilder)? updates]) =>
      (new EntrepriseAbonnementBuilder()..update(updates))._build();

  _$EntrepriseAbonnement._(
      {required this.permissions,
      required this.entrepriseAbonementKey,
      required this.createdAt,
      required this.expiredAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        permissions, r'EntrepriseAbonnement', 'permissions');
    BuiltValueNullFieldError.checkNotNull(entrepriseAbonementKey,
        r'EntrepriseAbonnement', 'entrepriseAbonementKey');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'EntrepriseAbonnement', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        expiredAt, r'EntrepriseAbonnement', 'expiredAt');
  }

  @override
  EntrepriseAbonnement rebuild(
          void Function(EntrepriseAbonnementBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EntrepriseAbonnementBuilder toBuilder() =>
      new EntrepriseAbonnementBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EntrepriseAbonnement &&
        permissions == other.permissions &&
        entrepriseAbonementKey == other.entrepriseAbonementKey &&
        createdAt == other.createdAt &&
        expiredAt == other.expiredAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jc(_$hash, entrepriseAbonementKey.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, expiredAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EntrepriseAbonnement')
          ..add('permissions', permissions)
          ..add('entrepriseAbonementKey', entrepriseAbonementKey)
          ..add('createdAt', createdAt)
          ..add('expiredAt', expiredAt))
        .toString();
  }
}

class EntrepriseAbonnementBuilder
    implements Builder<EntrepriseAbonnement, EntrepriseAbonnementBuilder> {
  _$EntrepriseAbonnement? _$v;

  List<Permission>? _permissions;
  List<Permission>? get permissions => _$this._permissions;
  set permissions(List<Permission>? permissions) =>
      _$this._permissions = permissions;

  String? _entrepriseAbonementKey;
  String? get entrepriseAbonementKey => _$this._entrepriseAbonementKey;
  set entrepriseAbonementKey(String? entrepriseAbonementKey) =>
      _$this._entrepriseAbonementKey = entrepriseAbonementKey;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _expiredAt;
  DateTime? get expiredAt => _$this._expiredAt;
  set expiredAt(DateTime? expiredAt) => _$this._expiredAt = expiredAt;

  EntrepriseAbonnementBuilder();

  EntrepriseAbonnementBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _permissions = $v.permissions;
      _entrepriseAbonementKey = $v.entrepriseAbonementKey;
      _createdAt = $v.createdAt;
      _expiredAt = $v.expiredAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EntrepriseAbonnement other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$EntrepriseAbonnement;
  }

  @override
  void update(void Function(EntrepriseAbonnementBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EntrepriseAbonnement build() => _build();

  _$EntrepriseAbonnement _build() {
    final _$result = _$v ??
        new _$EntrepriseAbonnement._(
            permissions: BuiltValueNullFieldError.checkNotNull(
                permissions, r'EntrepriseAbonnement', 'permissions'),
            entrepriseAbonementKey: BuiltValueNullFieldError.checkNotNull(
                entrepriseAbonementKey,
                r'EntrepriseAbonnement',
                'entrepriseAbonementKey'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'EntrepriseAbonnement', 'createdAt'),
            expiredAt: BuiltValueNullFieldError.checkNotNull(
                expiredAt, r'EntrepriseAbonnement', 'expiredAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
