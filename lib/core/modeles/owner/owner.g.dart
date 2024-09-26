// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Owner> _$ownerSerializer = new _$OwnerSerializer();

class _$OwnerSerializer implements StructuredSerializer<Owner> {
  @override
  final Iterable<Type> types = const [Owner, _$Owner];
  @override
  final String wireName = 'Owner';

  @override
  Iterable<Object?> serialize(Serializers serializers, Owner object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'entrepriseId',
      serializers.serialize(object.entrepriseId,
          specifiedType: const FullType(String)),
      'role',
      serializers.serialize(object.role, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];
    Object? value;
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nom;
    if (value != null) {
      result
        ..add('nom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.prenom;
    if (value != null) {
      result
        ..add('prenom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.adresse;
    if (value != null) {
      result
        ..add('adresse')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.password;
    if (value != null) {
      result
        ..add('password')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.atelierId;
    if (value != null) {
      result
        ..add('atelierId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Owner deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OwnerBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'entrepriseId':
          result.entrepriseId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nom':
          result.nom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'prenom':
          result.prenom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'adresse':
          result.adresse = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'password':
          result.password = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'role':
          result.role = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'atelierId':
          result.atelierId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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

class _$Owner extends Owner {
  @override
  final String entrepriseId;
  @override
  final String? uid;
  @override
  final String? nom;
  @override
  final String? prenom;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? adresse;
  @override
  final String? password;
  @override
  final String role;
  @override
  final String? atelierId;
  @override
  final DateTime createdAt;

  factory _$Owner([void Function(OwnerBuilder)? updates]) =>
      (new OwnerBuilder()..update(updates))._build();

  _$Owner._(
      {required this.entrepriseId,
      this.uid,
      this.nom,
      this.prenom,
      this.email,
      this.phone,
      this.adresse,
      this.password,
      required this.role,
      this.atelierId,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        entrepriseId, r'Owner', 'entrepriseId');
    BuiltValueNullFieldError.checkNotNull(role, r'Owner', 'role');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Owner', 'createdAt');
  }

  @override
  Owner rebuild(void Function(OwnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OwnerBuilder toBuilder() => new OwnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Owner &&
        entrepriseId == other.entrepriseId &&
        uid == other.uid &&
        nom == other.nom &&
        prenom == other.prenom &&
        email == other.email &&
        phone == other.phone &&
        adresse == other.adresse &&
        password == other.password &&
        role == other.role &&
        atelierId == other.atelierId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, entrepriseId.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, nom.hashCode);
    _$hash = $jc(_$hash, prenom.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, adresse.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, atelierId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Owner')
          ..add('entrepriseId', entrepriseId)
          ..add('uid', uid)
          ..add('nom', nom)
          ..add('prenom', prenom)
          ..add('email', email)
          ..add('phone', phone)
          ..add('adresse', adresse)
          ..add('password', password)
          ..add('role', role)
          ..add('atelierId', atelierId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class OwnerBuilder implements Builder<Owner, OwnerBuilder> {
  _$Owner? _$v;

  String? _entrepriseId;
  String? get entrepriseId => _$this._entrepriseId;
  set entrepriseId(String? entrepriseId) => _$this._entrepriseId = entrepriseId;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _nom;
  String? get nom => _$this._nom;
  set nom(String? nom) => _$this._nom = nom;

  String? _prenom;
  String? get prenom => _$this._prenom;
  set prenom(String? prenom) => _$this._prenom = prenom;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _adresse;
  String? get adresse => _$this._adresse;
  set adresse(String? adresse) => _$this._adresse = adresse;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _atelierId;
  String? get atelierId => _$this._atelierId;
  set atelierId(String? atelierId) => _$this._atelierId = atelierId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  OwnerBuilder();

  OwnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _entrepriseId = $v.entrepriseId;
      _uid = $v.uid;
      _nom = $v.nom;
      _prenom = $v.prenom;
      _email = $v.email;
      _phone = $v.phone;
      _adresse = $v.adresse;
      _password = $v.password;
      _role = $v.role;
      _atelierId = $v.atelierId;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Owner other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Owner;
  }

  @override
  void update(void Function(OwnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Owner build() => _build();

  _$Owner _build() {
    final _$result = _$v ??
        new _$Owner._(
            entrepriseId: BuiltValueNullFieldError.checkNotNull(
                entrepriseId, r'Owner', 'entrepriseId'),
            uid: uid,
            nom: nom,
            prenom: prenom,
            email: email,
            phone: phone,
            adresse: adresse,
            password: password,
            role: BuiltValueNullFieldError.checkNotNull(role, r'Owner', 'role'),
            atelierId: atelierId,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Owner', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
