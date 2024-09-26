// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_propriety.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<HabitPropriety> _$habitProprietySerializer =
    new _$HabitProprietySerializer();

class _$HabitProprietySerializer
    implements StructuredSerializer<HabitPropriety> {
  @override
  final Iterable<Type> types = const [HabitPropriety, _$HabitPropriety];
  @override
  final String wireName = 'HabitPropriety';

  @override
  Iterable<Object?> serialize(Serializers serializers, HabitPropriety object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.habitUid;
    if (value != null) {
      result
        ..add('habitUid')
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
    value = object.createdAt;
    if (value != null) {
      result
        ..add('createdAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updatedAt')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  HabitPropriety deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitProprietyBuilder();

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
        case 'habitUid':
          result.habitUid = serializers.deserialize(value,
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
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$HabitPropriety extends HabitPropriety {
  @override
  final int? id;
  @override
  final String? habitUid;
  @override
  final String? name;
  @override
  final String? value;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;

  factory _$HabitPropriety([void Function(HabitProprietyBuilder)? updates]) =>
      (new HabitProprietyBuilder()..update(updates))._build();

  _$HabitPropriety._(
      {this.id,
      this.habitUid,
      this.name,
      this.value,
      this.createdAt,
      this.updatedAt})
      : super._();

  @override
  HabitPropriety rebuild(void Function(HabitProprietyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitProprietyBuilder toBuilder() =>
      new HabitProprietyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HabitPropriety &&
        id == other.id &&
        habitUid == other.habitUid &&
        name == other.name &&
        value == other.value &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, habitUid.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'HabitPropriety')
          ..add('id', id)
          ..add('habitUid', habitUid)
          ..add('name', name)
          ..add('value', value)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class HabitProprietyBuilder
    implements Builder<HabitPropriety, HabitProprietyBuilder> {
  _$HabitPropriety? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _habitUid;
  String? get habitUid => _$this._habitUid;
  set habitUid(String? habitUid) => _$this._habitUid = habitUid;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  HabitProprietyBuilder();

  HabitProprietyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _habitUid = $v.habitUid;
      _name = $v.name;
      _value = $v.value;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HabitPropriety other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HabitPropriety;
  }

  @override
  void update(void Function(HabitProprietyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  HabitPropriety build() => _build();

  _$HabitPropriety _build() {
    final _$result = _$v ??
        new _$HabitPropriety._(
            id: id,
            habitUid: habitUid,
            name: name,
            value: value,
            createdAt: createdAt,
            updatedAt: updatedAt);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
