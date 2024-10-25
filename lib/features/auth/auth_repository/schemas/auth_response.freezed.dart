// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AuthResult _$AuthResultFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'success':
      return AuthRequestSuccess.fromJson(json);
    case 'failure':
      return AuthRequestFailure.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'AuthResult',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$AuthResult {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)
        success,
    required TResult Function(int statusCode, String message) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult? Function(int statusCode, String message)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult Function(int statusCode, String message)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthRequestSuccess value) success,
    required TResult Function(AuthRequestFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthRequestSuccess value)? success,
    TResult? Function(AuthRequestFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthRequestSuccess value)? success,
    TResult Function(AuthRequestFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this AuthResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthResultCopyWith<$Res> {
  factory $AuthResultCopyWith(
          AuthResult value, $Res Function(AuthResult) then) =
      _$AuthResultCopyWithImpl<$Res, AuthResult>;
}

/// @nodoc
class _$AuthResultCopyWithImpl<$Res, $Val extends AuthResult>
    implements $AuthResultCopyWith<$Res> {
  _$AuthResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthRequestSuccessImplCopyWith<$Res> {
  factory _$$AuthRequestSuccessImplCopyWith(_$AuthRequestSuccessImpl value,
          $Res Function(_$AuthRequestSuccessImpl) then) =
      __$$AuthRequestSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {AuthenticatedUser user,
      @JsonKey(name: 'access_token') String accessToken});

  $AuthenticatedUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$AuthRequestSuccessImplCopyWithImpl<$Res>
    extends _$AuthResultCopyWithImpl<$Res, _$AuthRequestSuccessImpl>
    implements _$$AuthRequestSuccessImplCopyWith<$Res> {
  __$$AuthRequestSuccessImplCopyWithImpl(_$AuthRequestSuccessImpl _value,
      $Res Function(_$AuthRequestSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? accessToken = null,
  }) {
    return _then(_$AuthRequestSuccessImpl(
      null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuthenticatedUser,
      null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuthenticatedUserCopyWith<$Res> get user {
    return $AuthenticatedUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthRequestSuccessImpl implements AuthRequestSuccess {
  const _$AuthRequestSuccessImpl(
      this.user, @JsonKey(name: 'access_token') this.accessToken,
      {final String? $type})
      : $type = $type ?? 'success';

  factory _$AuthRequestSuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthRequestSuccessImplFromJson(json);

  @override
  final AuthenticatedUser user;
  @override
  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthResult.success(user: $user, accessToken: $accessToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRequestSuccessImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, user, accessToken);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRequestSuccessImplCopyWith<_$AuthRequestSuccessImpl> get copyWith =>
      __$$AuthRequestSuccessImplCopyWithImpl<_$AuthRequestSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)
        success,
    required TResult Function(int statusCode, String message) failure,
  }) {
    return success(user, accessToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult? Function(int statusCode, String message)? failure,
  }) {
    return success?.call(user, accessToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult Function(int statusCode, String message)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(user, accessToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthRequestSuccess value) success,
    required TResult Function(AuthRequestFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthRequestSuccess value)? success,
    TResult? Function(AuthRequestFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthRequestSuccess value)? success,
    TResult Function(AuthRequestFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthRequestSuccessImplToJson(
      this,
    );
  }
}

abstract class AuthRequestSuccess implements AuthResult {
  const factory AuthRequestSuccess(final AuthenticatedUser user,
          @JsonKey(name: 'access_token') final String accessToken) =
      _$AuthRequestSuccessImpl;

  factory AuthRequestSuccess.fromJson(Map<String, dynamic> json) =
      _$AuthRequestSuccessImpl.fromJson;

  AuthenticatedUser get user;
  @JsonKey(name: 'access_token')
  String get accessToken;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRequestSuccessImplCopyWith<_$AuthRequestSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthRequestFailureImplCopyWith<$Res> {
  factory _$$AuthRequestFailureImplCopyWith(_$AuthRequestFailureImpl value,
          $Res Function(_$AuthRequestFailureImpl) then) =
      __$$AuthRequestFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, String message});
}

/// @nodoc
class __$$AuthRequestFailureImplCopyWithImpl<$Res>
    extends _$AuthResultCopyWithImpl<$Res, _$AuthRequestFailureImpl>
    implements _$$AuthRequestFailureImplCopyWith<$Res> {
  __$$AuthRequestFailureImplCopyWithImpl(_$AuthRequestFailureImpl _value,
      $Res Function(_$AuthRequestFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? message = null,
  }) {
    return _then(_$AuthRequestFailureImpl(
      null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthRequestFailureImpl implements AuthRequestFailure {
  const _$AuthRequestFailureImpl(this.statusCode, this.message,
      {final String? $type})
      : $type = $type ?? 'failure';

  factory _$AuthRequestFailureImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthRequestFailureImplFromJson(json);

  @override
  final int statusCode;
  @override
  final String message;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'AuthResult.failure(statusCode: $statusCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthRequestFailureImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, statusCode, message);

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthRequestFailureImplCopyWith<_$AuthRequestFailureImpl> get copyWith =>
      __$$AuthRequestFailureImplCopyWithImpl<_$AuthRequestFailureImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)
        success,
    required TResult Function(int statusCode, String message) failure,
  }) {
    return failure(statusCode, message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult? Function(int statusCode, String message)? failure,
  }) {
    return failure?.call(statusCode, message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticatedUser user,
            @JsonKey(name: 'access_token') String accessToken)?
        success,
    TResult Function(int statusCode, String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(statusCode, message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthRequestSuccess value) success,
    required TResult Function(AuthRequestFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthRequestSuccess value)? success,
    TResult? Function(AuthRequestFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthRequestSuccess value)? success,
    TResult Function(AuthRequestFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthRequestFailureImplToJson(
      this,
    );
  }
}

abstract class AuthRequestFailure implements AuthResult {
  const factory AuthRequestFailure(final int statusCode, final String message) =
      _$AuthRequestFailureImpl;

  factory AuthRequestFailure.fromJson(Map<String, dynamic> json) =
      _$AuthRequestFailureImpl.fromJson;

  int get statusCode;
  String get message;

  /// Create a copy of AuthResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthRequestFailureImplCopyWith<_$AuthRequestFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
