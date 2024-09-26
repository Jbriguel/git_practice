// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Client> _$clientSerializer = new _$ClientSerializer();

class _$ClientSerializer implements StructuredSerializer<Client> {
  @override
  final Iterable<Type> types = const [Client, _$Client];
  @override
  final String wireName = 'Client';

  @override
  Iterable<Object?> serialize(Serializers serializers, Client object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
      'isDeleted',
      serializers.serialize(object.isDeleted,
          specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photoUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.iconName;
    if (value != null) {
      result
        ..add('iconName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nomComplet;
    if (value != null) {
      result
        ..add('nomComplet')
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
    value = object.email;
    if (value != null) {
      result
        ..add('email')
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
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.informationsSuppelementaires;
    if (value != null) {
      result
        ..add('informationsSuppelementaires')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.mesures;
    if (value != null) {
      result
        ..add('mesures')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltList, const [
              const FullType(BuiltMap,
                  const [const FullType(String), const FullType(dynamic)])
            ])));
    }
    return result;
  }

  @override
  Client deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ClientBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'photoUrl':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'iconName':
          result.iconName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nomComplet':
          result.nomComplet = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'adresse':
          result.adresse = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'informationsSuppelementaires':
          result.informationsSuppelementaires = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'mesures':
          result.mesures.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltList, const [
                const FullType(BuiltMap,
                    const [const FullType(String), const FullType(dynamic)])
              ]))! as BuiltList<Object?>);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime))! as DateTime;
          break;
        case 'isDeleted':
          result.isDeleted = serializers.deserialize(value,
              specifiedType: const FullType(int))! as int;
          break;
      }
    }

    return result.build();
  }
}

class _$Client extends Client {
  @override
  final int? id;
  @override
  final String? photoUrl;
  @override
  final String? iconName;
  @override
  final String? nomComplet;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final String? adresse;
  @override
  final String? uid;
  @override
  final String? informationsSuppelementaires;
  @override
  final BuiltList<BuiltMap<String, dynamic>>? mesures;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final int isDeleted;

  factory _$Client([void Function(ClientBuilder)? updates]) =>
      (new ClientBuilder()..update(updates))._build();

  _$Client._(
      {this.id,
      this.photoUrl,
      this.iconName,
      this.nomComplet,
      this.phone,
      this.email,
      this.adresse,
      this.uid,
      this.informationsSuppelementaires,
      this.mesures,
      required this.createdAt,
      required this.updatedAt,
      required this.isDeleted})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Client', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(updatedAt, r'Client', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(isDeleted, r'Client', 'isDeleted');
  }

  @override
  Client rebuild(void Function(ClientBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClientBuilder toBuilder() => new ClientBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Client &&
        id == other.id &&
        photoUrl == other.photoUrl &&
        iconName == other.iconName &&
        nomComplet == other.nomComplet &&
        phone == other.phone &&
        email == other.email &&
        adresse == other.adresse &&
        uid == other.uid &&
        informationsSuppelementaires == other.informationsSuppelementaires &&
        mesures == other.mesures &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        isDeleted == other.isDeleted;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, photoUrl.hashCode);
    _$hash = $jc(_$hash, iconName.hashCode);
    _$hash = $jc(_$hash, nomComplet.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, adresse.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, informationsSuppelementaires.hashCode);
    _$hash = $jc(_$hash, mesures.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, isDeleted.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Client')
          ..add('id', id)
          ..add('photoUrl', photoUrl)
          ..add('iconName', iconName)
          ..add('nomComplet', nomComplet)
          ..add('phone', phone)
          ..add('email', email)
          ..add('adresse', adresse)
          ..add('uid', uid)
          ..add('informationsSuppelementaires', informationsSuppelementaires)
          ..add('mesures', mesures)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('isDeleted', isDeleted))
        .toString();
  }
}

class ClientBuilder implements Builder<Client, ClientBuilder> {
  _$Client? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _photoUrl;
  String? get photoUrl => _$this._photoUrl;
  set photoUrl(String? photoUrl) => _$this._photoUrl = photoUrl;

  String? _iconName;
  String? get iconName => _$this._iconName;
  set iconName(String? iconName) => _$this._iconName = iconName;

  String? _nomComplet;
  String? get nomComplet => _$this._nomComplet;
  set nomComplet(String? nomComplet) => _$this._nomComplet = nomComplet;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _adresse;
  String? get adresse => _$this._adresse;
  set adresse(String? adresse) => _$this._adresse = adresse;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _informationsSuppelementaires;
  String? get informationsSuppelementaires =>
      _$this._informationsSuppelementaires;
  set informationsSuppelementaires(String? informationsSuppelementaires) =>
      _$this._informationsSuppelementaires = informationsSuppelementaires;

  ListBuilder<BuiltMap<String, dynamic>>? _mesures;
  ListBuilder<BuiltMap<String, dynamic>> get mesures =>
      _$this._mesures ??= new ListBuilder<BuiltMap<String, dynamic>>();
  set mesures(ListBuilder<BuiltMap<String, dynamic>>? mesures) =>
      _$this._mesures = mesures;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  int? _isDeleted;
  int? get isDeleted => _$this._isDeleted;
  set isDeleted(int? isDeleted) => _$this._isDeleted = isDeleted;

  ClientBuilder();

  ClientBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _photoUrl = $v.photoUrl;
      _iconName = $v.iconName;
      _nomComplet = $v.nomComplet;
      _phone = $v.phone;
      _email = $v.email;
      _adresse = $v.adresse;
      _uid = $v.uid;
      _informationsSuppelementaires = $v.informationsSuppelementaires;
      _mesures = $v.mesures?.toBuilder();
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _isDeleted = $v.isDeleted;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Client other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Client;
  }

  @override
  void update(void Function(ClientBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Client build() => _build();

  _$Client _build() {
    _$Client _$result;
    try {
      _$result = _$v ??
          new _$Client._(
              id: id,
              photoUrl: photoUrl,
              iconName: iconName,
              nomComplet: nomComplet,
              phone: phone,
              email: email,
              adresse: adresse,
              uid: uid,
              informationsSuppelementaires: informationsSuppelementaires,
              mesures: _mesures?.build(),
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'Client', 'createdAt'),
              updatedAt: BuiltValueNullFieldError.checkNotNull(
                  updatedAt, r'Client', 'updatedAt'),
              isDeleted: BuiltValueNullFieldError.checkNotNull(
                  isDeleted, r'Client', 'isDeleted'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mesures';
        _mesures?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Client', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
