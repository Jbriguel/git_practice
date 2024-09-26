// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modele.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Modele> _$modeleSerializer = new _$ModeleSerializer();

class _$ModeleSerializer implements StructuredSerializer<Modele> {
  @override
  final Iterable<Type> types = const [Modele, _$Modele];
  @override
  final String wireName = 'Modele';

  @override
  Iterable<Object?> serialize(Serializers serializers, Modele object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
      'proprieties',
      serializers.serialize(object.proprieties,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Propriety)])),
    ];
    Object? value;
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imgPath;
    if (value != null) {
      result
        ..add('imgPath')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.genderType;
    if (value != null) {
      result
        ..add('genderType')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.creatorId;
    if (value != null) {
      result
        ..add('creatorId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.modifiedAt;
    if (value != null) {
      result
        ..add('modifiedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Modele deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ModeleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'imgPath':
          result.imgPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'genderType':
          result.genderType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'creatorId':
          result.creatorId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'modifiedAt':
          result.modifiedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'proprieties':
          result.proprieties.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(Propriety)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Modele extends Modele {
  @override
  final String? uid;
  @override
  final String? imgPath;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? genderType;
  @override
  final String? creatorId;
  @override
  final String createdAt;
  @override
  final String? modifiedAt;
  @override
  final BuiltList<Propriety> proprieties;

  factory _$Modele([void Function(ModeleBuilder)? updates]) =>
      (new ModeleBuilder()..update(updates))._build();

  _$Modele._(
      {this.uid,
      this.imgPath,
      this.name,
      this.description,
      this.genderType,
      this.creatorId,
      required this.createdAt,
      this.modifiedAt,
      required this.proprieties})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Modele', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        proprieties, r'Modele', 'proprieties');
  }

  @override
  Modele rebuild(void Function(ModeleBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModeleBuilder toBuilder() => new ModeleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Modele &&
        uid == other.uid &&
        imgPath == other.imgPath &&
        name == other.name &&
        description == other.description &&
        genderType == other.genderType &&
        creatorId == other.creatorId &&
        createdAt == other.createdAt &&
        modifiedAt == other.modifiedAt &&
        proprieties == other.proprieties;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, imgPath.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, genderType.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, modifiedAt.hashCode);
    _$hash = $jc(_$hash, proprieties.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class ModeleBuilder implements Builder<Modele, ModeleBuilder> {
  _$Modele? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _imgPath;
  String? get imgPath => _$this._imgPath;
  set imgPath(String? imgPath) => _$this._imgPath = imgPath;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _genderType;
  String? get genderType => _$this._genderType;
  set genderType(String? genderType) => _$this._genderType = genderType;

  String? _creatorId;
  String? get creatorId => _$this._creatorId;
  set creatorId(String? creatorId) => _$this._creatorId = creatorId;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _modifiedAt;
  String? get modifiedAt => _$this._modifiedAt;
  set modifiedAt(String? modifiedAt) => _$this._modifiedAt = modifiedAt;

  ListBuilder<Propriety>? _proprieties;
  ListBuilder<Propriety> get proprieties =>
      _$this._proprieties ??= new ListBuilder<Propriety>();
  set proprieties(ListBuilder<Propriety>? proprieties) =>
      _$this._proprieties = proprieties;

  ModeleBuilder();

  ModeleBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _imgPath = $v.imgPath;
      _name = $v.name;
      _description = $v.description;
      _genderType = $v.genderType;
      _creatorId = $v.creatorId;
      _createdAt = $v.createdAt;
      _modifiedAt = $v.modifiedAt;
      _proprieties = $v.proprieties.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Modele other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Modele;
  }

  @override
  void update(void Function(ModeleBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Modele build() => _build();

  _$Modele _build() {
    _$Modele _$result;
    try {
      _$result = _$v ??
          new _$Modele._(
              uid: uid,
              imgPath: imgPath,
              name: name,
              description: description,
              genderType: genderType,
              creatorId: creatorId,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'Modele', 'createdAt'),
              modifiedAt: modifiedAt,
              proprieties: proprieties.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'proprieties';
        proprieties.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Modele', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
