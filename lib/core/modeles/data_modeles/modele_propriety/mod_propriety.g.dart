// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mod_propriety.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ModPropriety> _$modProprietySerializer =
    new _$ModProprietySerializer();

class _$ModProprietySerializer implements StructuredSerializer<ModPropriety> {
  @override
  final Iterable<Type> types = const [ModPropriety, _$ModPropriety];
  @override
  final String wireName = 'ModPropriety';

  @override
  Iterable<Object?> serialize(Serializers serializers, ModPropriety object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'modeleUid',
      serializers.serialize(object.modeleUid,
          specifiedType: const FullType(String)),
      'proprietyUid',
      serializers.serialize(object.proprietyUid,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ModPropriety deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ModProprietyBuilder();

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
        case 'modeleUid':
          result.modeleUid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'proprietyUid':
          result.proprietyUid = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ModPropriety extends ModPropriety {
  @override
  final String uid;
  @override
  final String modeleUid;
  @override
  final String proprietyUid;

  factory _$ModPropriety([void Function(ModProprietyBuilder)? updates]) =>
      (new ModProprietyBuilder()..update(updates))._build();

  _$ModPropriety._(
      {required this.uid, required this.modeleUid, required this.proprietyUid})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(uid, r'ModPropriety', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        modeleUid, r'ModPropriety', 'modeleUid');
    BuiltValueNullFieldError.checkNotNull(
        proprietyUid, r'ModPropriety', 'proprietyUid');
  }

  @override
  ModPropriety rebuild(void Function(ModProprietyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModProprietyBuilder toBuilder() => new ModProprietyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModPropriety &&
        uid == other.uid &&
        modeleUid == other.modeleUid &&
        proprietyUid == other.proprietyUid;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, modeleUid.hashCode);
    _$hash = $jc(_$hash, proprietyUid.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModPropriety')
          ..add('uid', uid)
          ..add('modeleUid', modeleUid)
          ..add('proprietyUid', proprietyUid))
        .toString();
  }
}

class ModProprietyBuilder
    implements Builder<ModPropriety, ModProprietyBuilder> {
  _$ModPropriety? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _modeleUid;
  String? get modeleUid => _$this._modeleUid;
  set modeleUid(String? modeleUid) => _$this._modeleUid = modeleUid;

  String? _proprietyUid;
  String? get proprietyUid => _$this._proprietyUid;
  set proprietyUid(String? proprietyUid) => _$this._proprietyUid = proprietyUid;

  ModProprietyBuilder();

  ModProprietyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _modeleUid = $v.modeleUid;
      _proprietyUid = $v.proprietyUid;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModPropriety other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ModPropriety;
  }

  @override
  void update(void Function(ModProprietyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModPropriety build() => _build();

  _$ModPropriety _build() {
    final _$result = _$v ??
        new _$ModPropriety._(
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'ModPropriety', 'uid'),
            modeleUid: BuiltValueNullFieldError.checkNotNull(
                modeleUid, r'ModPropriety', 'modeleUid'),
            proprietyUid: BuiltValueNullFieldError.checkNotNull(
                proprietyUid, r'ModPropriety', 'proprietyUid'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
