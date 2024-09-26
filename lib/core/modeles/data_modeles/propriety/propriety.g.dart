// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propriety.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Propriety> _$proprietySerializer = new _$ProprietySerializer();

class _$ProprietySerializer implements StructuredSerializer<Propriety> {
  @override
  final Iterable<Type> types = const [Propriety, _$Propriety];
  @override
  final String wireName = 'Propriety';

  @override
  Iterable<Object?> serialize(Serializers serializers, Propriety object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
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
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Propriety deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProprietyBuilder();

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
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Propriety extends Propriety {
  @override
  final String? uid;
  @override
  final String? name;
  @override
  final String? value;

  factory _$Propriety([void Function(ProprietyBuilder)? updates]) =>
      (new ProprietyBuilder()..update(updates))._build();

  _$Propriety._({this.uid, this.name, this.value}) : super._();

  @override
  Propriety rebuild(void Function(ProprietyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProprietyBuilder toBuilder() => new ProprietyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Propriety &&
        uid == other.uid &&
        name == other.name &&
        value == other.value;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Propriety')
          ..add('uid', uid)
          ..add('name', name)
          ..add('value', value))
        .toString();
  }
}

class ProprietyBuilder implements Builder<Propriety, ProprietyBuilder> {
  _$Propriety? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  ProprietyBuilder();

  ProprietyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _name = $v.name;
      _value = $v.value;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Propriety other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Propriety;
  }

  @override
  void update(void Function(ProprietyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Propriety build() => _build();

  _$Propriety _build() {
    final _$result =
        _$v ?? new _$Propriety._(uid: uid, name: name, value: value);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
