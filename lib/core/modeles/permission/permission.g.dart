// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Permission> _$permissionSerializer = new _$PermissionSerializer();

class _$PermissionSerializer implements StructuredSerializer<Permission> {
  @override
  final Iterable<Type> types = const [Permission, _$Permission];
  @override
  final String wireName = 'Permission';

  @override
  Iterable<Object?> serialize(Serializers serializers, Permission object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'uid',
      serializers.serialize(object.uid, specifiedType: const FullType(String)),
      'permissionName',
      serializers.serialize(object.permissionName,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
    ];

    return result;
  }

  @override
  Permission deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PermissionBuilder();

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
        case 'permissionName':
          result.permissionName = serializers.deserialize(value,
              specifiedType: const FullType(String))! as String;
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

class _$Permission extends Permission {
  @override
  final String uid;
  @override
  final String permissionName;
  @override
  final DateTime createdAt;

  factory _$Permission([void Function(PermissionBuilder)? updates]) =>
      (new PermissionBuilder()..update(updates))._build();

  _$Permission._(
      {required this.uid,
      required this.permissionName,
      required this.createdAt})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(uid, r'Permission', 'uid');
    BuiltValueNullFieldError.checkNotNull(
        permissionName, r'Permission', 'permissionName');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, r'Permission', 'createdAt');
  }

  @override
  Permission rebuild(void Function(PermissionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PermissionBuilder toBuilder() => new PermissionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Permission &&
        uid == other.uid &&
        permissionName == other.permissionName &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, uid.hashCode);
    _$hash = $jc(_$hash, permissionName.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Permission')
          ..add('uid', uid)
          ..add('permissionName', permissionName)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class PermissionBuilder implements Builder<Permission, PermissionBuilder> {
  _$Permission? _$v;

  String? _uid;
  String? get uid => _$this._uid;
  set uid(String? uid) => _$this._uid = uid;

  String? _permissionName;
  String? get permissionName => _$this._permissionName;
  set permissionName(String? permissionName) =>
      _$this._permissionName = permissionName;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  PermissionBuilder();

  PermissionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _uid = $v.uid;
      _permissionName = $v.permissionName;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Permission other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Permission;
  }

  @override
  void update(void Function(PermissionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Permission build() => _build();

  _$Permission _build() {
    final _$result = _$v ??
        new _$Permission._(
            uid: BuiltValueNullFieldError.checkNotNull(
                uid, r'Permission', 'uid'),
            permissionName: BuiltValueNullFieldError.checkNotNull(
                permissionName, r'Permission', 'permissionName'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'Permission', 'createdAt'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
