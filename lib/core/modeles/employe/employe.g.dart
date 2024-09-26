// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employe.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Employe> _$employeSerializer = new _$EmployeSerializer();

class _$EmployeSerializer implements StructuredSerializer<Employe> {
  @override
  final Iterable<Type> types = const [Employe, _$Employe];
  @override
  final String wireName = 'Employe';

  @override
  Iterable<Object?> serialize(Serializers serializers, Employe object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'atelierId',
      serializers.serialize(object.atelierId,
          specifiedType: const FullType(String)),
      'atelierIdentify',
      serializers.serialize(object.atelierIdentify,
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
    value = object.entrepriseId;
    if (value != null) {
      result
        ..add('entrepriseId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Employe deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new EmployeBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'atelierId':
          result.atelierId = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'atelierIdentify':
          result.atelierIdentify = serializers.deserialize(value,
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
        case 'entrepriseId':
          result.entrepriseId = serializers.deserialize(value,
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

class _$Employe extends Employe {
  @override
  final String atelierId;
  @override
  final String atelierIdentify;
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
  final String? entrepriseId;
  @override
  final DateTime createdAt;

  factory _$Employe([void Function(EmployeBuilder)? updates]) =>
      (new EmployeBuilder()..update(updates))._build();

  _$Employe._(
      {required this.atelierId,
      required this.atelierIdentify,
      this.uid,
      this.nom,
      this.prenom,
      this.email,
      this.phone,
      this.adresse,
      this.password,
      required this.role,
      this.entrepriseId,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(atelierId, r'Employe', 'atelierId');
    BuiltValueNullFieldError.checkNotNull(
        atelierIdentify, r'Employe', 'atelierIdentify');
    BuiltValueNullFieldError.checkNotNull(role, r'Employe', 'role');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Employe', 'createdAt');
  }

  @override
  Employe rebuild(void Function(EmployeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EmployeBuilder toBuilder() => new EmployeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Employe &&
        atelierId == other.atelierId &&
        atelierIdentify == other.atelierIdentify &&
        uid == other.uid &&
        nom == other.nom &&
        prenom == other.prenom &&
        email == other.email &&
        phone == other.phone &&
        adresse == other.adresse &&
        password == other.password &&
        role == other.role &&
        entrepriseId == other.entrepriseId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, atelierId.hashCode);
    _$hash = $jc(_$hash, atelierIdentify.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, nom.hashCode);
    _$hash = $jc(_$hash, prenom.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, adresse.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, entrepriseId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Employe')
          ..add('atelierId', atelierId)
          ..add('atelierIdentify', atelierIdentify)
          ..add('uid', uid)
          ..add('nom', nom)
          ..add('prenom', prenom)
          ..add('email', email)
          ..add('phone', phone)
          ..add('adresse', adresse)
          ..add('password', password)
          ..add('role', role)
          ..add('entrepriseId', entrepriseId)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class EmployeBuilder implements Builder<Employe, EmployeBuilder> {
  _$Employe? _$v;

  String? _atelierId;
  String? get atelierId => _$this._atelierId;
  set atelierId(String? atelierId) => _$this._atelierId = atelierId;

  String? _atelierIdentify;
  String? get atelierIdentify => _$this._atelierIdentify;
  set atelierIdentify(String? atelierIdentify) =>
      _$this._atelierIdentify = atelierIdentify;

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

  String? _entrepriseId;
  String? get entrepriseId => _$this._entrepriseId;
  set entrepriseId(String? entrepriseId) => _$this._entrepriseId = entrepriseId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  EmployeBuilder();

  EmployeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _atelierId = $v.atelierId;
      _atelierIdentify = $v.atelierIdentify;
      _uid = $v.uid;
      _nom = $v.nom;
      _prenom = $v.prenom;
      _email = $v.email;
      _phone = $v.phone;
      _adresse = $v.adresse;
      _password = $v.password;
      _role = $v.role;
      _entrepriseId = $v.entrepriseId;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Employe other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Employe;
  }

  @override
  void update(void Function(EmployeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Employe build() => _build();

  _$Employe _build() {
    final _$result = _$v ??
        new _$Employe._(
            atelierId: BuiltValueNullFieldError.checkNotNull(
                atelierId, r'Employe', 'atelierId'),
            atelierIdentify: BuiltValueNullFieldError.checkNotNull(
                atelierIdentify, r'Employe', 'atelierIdentify'),
            uid: uid,
            nom: nom,
            prenom: prenom,
            email: email,
            phone: phone,
            adresse: adresse,
            password: password,
            role:
                BuiltValueNullFieldError.checkNotNull(role, r'Employe', 'role'),
            entrepriseId: entrepriseId,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Employe', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
