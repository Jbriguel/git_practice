// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Habit> _$habitSerializer = new _$HabitSerializer();

class _$HabitSerializer implements StructuredSerializer<Habit> {
  @override
  final Iterable<Type> types = const [Habit, _$Habit];
  @override
  final String wireName = 'Habit';

  @override
  Iterable<Object?> serialize(Serializers serializers, Habit object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.commandeUid;
    if (value != null) {
      result
        ..add('commandeUid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.modeleUid;
    if (value != null) {
      result
        ..add('modeleUid')
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
    value = object.details;
    if (value != null) {
      result
        ..add('details')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
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
    value = object.proprieties;
    if (value != null) {
      result
        ..add('proprieties')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                BuiltList, const [const FullType(HabitPropriety)])));
    }
    return result;
  }

  @override
  Habit deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new HabitBuilder();

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
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'commandeUid':
          result.commandeUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'modeleUid':
          result.modeleUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'details':
          result.details = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'proprieties':
          result.proprieties.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(HabitPropriety)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$Habit extends Habit {
  @override
  final int? id;
  @override
  final String? uid;
  @override
  final String? commandeUid;
  @override
  final String? modeleUid;
  @override
  final String? name;
  @override
  final String? details;
  @override
  final String? image;
  @override
  final double? price;
  @override
  final String? createdAt;
  @override
  final String? updatedAt;
  @override
  final BuiltList<HabitPropriety>? proprieties;

  factory _$Habit([void Function(HabitBuilder)? updates]) =>
      (new HabitBuilder()..update(updates))._build();

  _$Habit._(
      {this.id,
      this.uid,
      this.commandeUid,
      this.modeleUid,
      this.name,
      this.details,
      this.image,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.proprieties})
      : super._();

  @override
  Habit rebuild(void Function(HabitBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HabitBuilder toBuilder() => new HabitBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Habit &&
        id == other.id &&
        uid == other.uid &&
        commandeUid == other.commandeUid &&
        modeleUid == other.modeleUid &&
        name == other.name &&
        details == other.details &&
        image == other.image &&
        price == other.price &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        proprieties == other.proprieties;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, commandeUid.hashCode);
    _$hash = $jc(_$hash, modeleUid.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, image.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, proprieties.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Habit')
          ..add('id', id)
          ..add('uid', uid)
          ..add('commandeUid', commandeUid)
          ..add('modeleUid', modeleUid)
          ..add('name', name)
          ..add('details', details)
          ..add('image', image)
          ..add('price', price)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('proprieties', proprieties))
        .toString();
  }
}

class HabitBuilder implements Builder<Habit, HabitBuilder> {
  _$Habit? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _commandeUid;
  String? get commandeUid => _$this._commandeUid;
  set commandeUid(String? commandeUid) => _$this._commandeUid = commandeUid;

  String? _modeleUid;
  String? get modeleUid => _$this._modeleUid;
  set modeleUid(String? modeleUid) => _$this._modeleUid = modeleUid;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _details;
  String? get details => _$this._details;
  set details(String? details) => _$this._details = details;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<HabitPropriety>? _proprieties;
  ListBuilder<HabitPropriety> get proprieties =>
      _$this._proprieties ??= new ListBuilder<HabitPropriety>();
  set proprieties(ListBuilder<HabitPropriety>? proprieties) =>
      _$this._proprieties = proprieties;

  HabitBuilder();

  HabitBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _uid = $v.uid;
      _commandeUid = $v.commandeUid;
      _modeleUid = $v.modeleUid;
      _name = $v.name;
      _details = $v.details;
      _image = $v.image;
      _price = $v.price;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _proprieties = $v.proprieties?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Habit other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Habit;
  }

  @override
  void update(void Function(HabitBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Habit build() => _build();

  _$Habit _build() {
    _$Habit _$result;
    try {
      _$result = _$v ??
          new _$Habit._(
              id: id,
              uid: uid,
              commandeUid: commandeUid,
              modeleUid: modeleUid,
              name: name,
              details: details,
              image: image,
              price: price,
              createdAt: createdAt,
              updatedAt: updatedAt,
              proprieties: _proprieties?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'proprieties';
        _proprieties?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Habit', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
