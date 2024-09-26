// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commande.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Commande> _$commandeSerializer = new _$CommandeSerializer();

class _$CommandeSerializer implements StructuredSerializer<Commande> {
  @override
  final Iterable<Type> types = const [Commande, _$Commande];
  @override
  final String wireName = 'Commande';

  @override
  Iterable<Object?> serialize(Serializers serializers, Commande object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'deliveryDate',
      serializers.serialize(object.deliveryDate,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(String)),
    ];
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
    value = object.clientUid;
    if (value != null) {
      result
        ..add('clientUid')
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
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.advance;
    if (value != null) {
      result
        ..add('advance')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
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
  Commande deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommandeBuilder();

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
        case 'clientUid':
          result.clientUid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'details':
          result.details = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'advance':
          result.advance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double?;
          break;
        case 'deliveryDate':
          result.deliveryDate = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$Commande extends Commande {
  @override
  final int? id;
  @override
  final String? uid;
  @override
  final String? clientUid;
  @override
  final String? details;
  @override
  final double? price;
  @override
  final double? advance;
  @override
  final String deliveryDate;
  @override
  final String? status;
  @override
  final String createdAt;
  @override
  final String? updatedAt;
  @override
  final BuiltList<Habit>? habits;

  factory _$Commande([void Function(CommandeBuilder)? updates]) =>
      (new CommandeBuilder()..update(updates))._build();

  _$Commande._(
      {this.id,
      this.uid,
      this.clientUid,
      this.details,
      this.price,
      this.advance,
      required this.deliveryDate,
      this.status,
      required this.createdAt,
      this.updatedAt,
      this.habits})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        deliveryDate, r'Commande', 'deliveryDate');
    BuiltValueNullFieldError.checkNotNull(createdAt, r'Commande', 'createdAt');
  }

  @override
  Commande rebuild(void Function(CommandeBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommandeBuilder toBuilder() => new CommandeBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Commande &&
        id == other.id &&
        uid == other.uid &&
        clientUid == other.clientUid &&
        details == other.details &&
        price == other.price &&
        advance == other.advance &&
        deliveryDate == other.deliveryDate &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        habits == other.habits;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, clientUid.hashCode);
    _$hash = $jc(_$hash, details.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, advance.hashCode);
    _$hash = $jc(_$hash, deliveryDate.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, habits.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Commande')
          ..add('id', id)
          ..add('uid', uid)
          ..add('clientUid', clientUid)
          ..add('details', details)
          ..add('price', price)
          ..add('advance', advance)
          ..add('deliveryDate', deliveryDate)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('habits', habits))
        .toString();
  }
}

class CommandeBuilder implements Builder<Commande, CommandeBuilder> {
  _$Commande? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _clientUid;
  String? get clientUid => _$this._clientUid;
  set clientUid(String? clientUid) => _$this._clientUid = clientUid;

  String? _details;
  String? get details => _$this._details;
  set details(String? details) => _$this._details = details;

  double? _price;
  double? get price => _$this._price;
  set price(double? price) => _$this._price = price;

  double? _advance;
  double? get advance => _$this._advance;
  set advance(double? advance) => _$this._advance = advance;

  String? _deliveryDate;
  String? get deliveryDate => _$this._deliveryDate;
  set deliveryDate(String? deliveryDate) => _$this._deliveryDate = deliveryDate;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  ListBuilder<Habit>? _habits;
  ListBuilder<Habit> get habits => _$this._habits ??= new ListBuilder<Habit>();
  set habits(ListBuilder<Habit>? habits) => _$this._habits = habits;

  CommandeBuilder();

  CommandeBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _uid = $v.uid;
      _clientUid = $v.clientUid;
      _details = $v.details;
      _price = $v.price;
      _advance = $v.advance;
      _deliveryDate = $v.deliveryDate;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _habits = $v.habits?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Commande other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Commande;
  }

  @override
  void update(void Function(CommandeBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Commande build() => _build();

  _$Commande _build() {
    _$Commande _$result;
    try {
      _$result = _$v ??
          new _$Commande._(
              id: id,
              uid: uid,
              clientUid: clientUid,
              details: details,
              price: price,
              advance: advance,
              deliveryDate: BuiltValueNullFieldError.checkNotNull(
                  deliveryDate, r'Commande', 'deliveryDate'),
              status: status,
              createdAt: BuiltValueNullFieldError.checkNotNull(
                  createdAt, r'Commande', 'createdAt'),
              updatedAt: updatedAt,
              habits: _habits?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'habits';
        _habits?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'Commande', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
