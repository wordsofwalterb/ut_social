// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'student.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Student _$StudentFromJson(Map<String, dynamic> json) {
  return _Student.fromJson(json);
}

/// @nodoc
class _$StudentTearOff {
  const _$StudentTearOff();

// ignore: unused_element
  _Student call(
      {@required String id,
      @required String fullName,
      List<String> channels = const [],
      String bio,
      String firstName,
      String lastName,
      String coverPhotoUrl,
      String email,
      String avatarUrl,
      bool notificationsEnabled = false,
      int reportCount,
      bool isTester = false}) {
    return _Student(
      id: id,
      fullName: fullName,
      channels: channels,
      bio: bio,
      firstName: firstName,
      lastName: lastName,
      coverPhotoUrl: coverPhotoUrl,
      email: email,
      avatarUrl: avatarUrl,
      notificationsEnabled: notificationsEnabled,
      reportCount: reportCount,
      isTester: isTester,
    );
  }

// ignore: unused_element
  Student fromJson(Map<String, Object> json) {
    return Student.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Student = _$StudentTearOff();

/// @nodoc
mixin _$Student {
  String get id;
  String get fullName;
  List<String> get channels;
  String get bio;
  String get firstName;
  String get lastName;
  String get coverPhotoUrl;
  String get email;
  String get avatarUrl;
  bool get notificationsEnabled;
  int get reportCount;
  bool get isTester;

  Map<String, dynamic> toJson();
  $StudentCopyWith<Student> get copyWith;
}

/// @nodoc
abstract class $StudentCopyWith<$Res> {
  factory $StudentCopyWith(Student value, $Res Function(Student) then) =
      _$StudentCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String fullName,
      List<String> channels,
      String bio,
      String firstName,
      String lastName,
      String coverPhotoUrl,
      String email,
      String avatarUrl,
      bool notificationsEnabled,
      int reportCount,
      bool isTester});
}

/// @nodoc
class _$StudentCopyWithImpl<$Res> implements $StudentCopyWith<$Res> {
  _$StudentCopyWithImpl(this._value, this._then);

  final Student _value;
  // ignore: unused_field
  final $Res Function(Student) _then;

  @override
  $Res call({
    Object id = freezed,
    Object fullName = freezed,
    Object channels = freezed,
    Object bio = freezed,
    Object firstName = freezed,
    Object lastName = freezed,
    Object coverPhotoUrl = freezed,
    Object email = freezed,
    Object avatarUrl = freezed,
    Object notificationsEnabled = freezed,
    Object reportCount = freezed,
    Object isTester = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      fullName: fullName == freezed ? _value.fullName : fullName as String,
      channels:
          channels == freezed ? _value.channels : channels as List<String>,
      bio: bio == freezed ? _value.bio : bio as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      lastName: lastName == freezed ? _value.lastName : lastName as String,
      coverPhotoUrl: coverPhotoUrl == freezed
          ? _value.coverPhotoUrl
          : coverPhotoUrl as String,
      email: email == freezed ? _value.email : email as String,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      notificationsEnabled: notificationsEnabled == freezed
          ? _value.notificationsEnabled
          : notificationsEnabled as bool,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      isTester: isTester == freezed ? _value.isTester : isTester as bool,
    ));
  }
}

/// @nodoc
abstract class _$StudentCopyWith<$Res> implements $StudentCopyWith<$Res> {
  factory _$StudentCopyWith(_Student value, $Res Function(_Student) then) =
      __$StudentCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String fullName,
      List<String> channels,
      String bio,
      String firstName,
      String lastName,
      String coverPhotoUrl,
      String email,
      String avatarUrl,
      bool notificationsEnabled,
      int reportCount,
      bool isTester});
}

/// @nodoc
class __$StudentCopyWithImpl<$Res> extends _$StudentCopyWithImpl<$Res>
    implements _$StudentCopyWith<$Res> {
  __$StudentCopyWithImpl(_Student _value, $Res Function(_Student) _then)
      : super(_value, (v) => _then(v as _Student));

  @override
  _Student get _value => super._value as _Student;

  @override
  $Res call({
    Object id = freezed,
    Object fullName = freezed,
    Object channels = freezed,
    Object bio = freezed,
    Object firstName = freezed,
    Object lastName = freezed,
    Object coverPhotoUrl = freezed,
    Object email = freezed,
    Object avatarUrl = freezed,
    Object notificationsEnabled = freezed,
    Object reportCount = freezed,
    Object isTester = freezed,
  }) {
    return _then(_Student(
      id: id == freezed ? _value.id : id as String,
      fullName: fullName == freezed ? _value.fullName : fullName as String,
      channels:
          channels == freezed ? _value.channels : channels as List<String>,
      bio: bio == freezed ? _value.bio : bio as String,
      firstName: firstName == freezed ? _value.firstName : firstName as String,
      lastName: lastName == freezed ? _value.lastName : lastName as String,
      coverPhotoUrl: coverPhotoUrl == freezed
          ? _value.coverPhotoUrl
          : coverPhotoUrl as String,
      email: email == freezed ? _value.email : email as String,
      avatarUrl: avatarUrl == freezed ? _value.avatarUrl : avatarUrl as String,
      notificationsEnabled: notificationsEnabled == freezed
          ? _value.notificationsEnabled
          : notificationsEnabled as bool,
      reportCount:
          reportCount == freezed ? _value.reportCount : reportCount as int,
      isTester: isTester == freezed ? _value.isTester : isTester as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Student with DiagnosticableTreeMixin implements _Student {
  const _$_Student(
      {@required this.id,
      @required this.fullName,
      this.channels = const [],
      this.bio,
      this.firstName,
      this.lastName,
      this.coverPhotoUrl,
      this.email,
      this.avatarUrl,
      this.notificationsEnabled = false,
      this.reportCount,
      this.isTester = false})
      : assert(id != null),
        assert(fullName != null),
        assert(channels != null),
        assert(notificationsEnabled != null),
        assert(isTester != null);

  factory _$_Student.fromJson(Map<String, dynamic> json) =>
      _$_$_StudentFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @JsonKey(defaultValue: const [])
  @override
  final List<String> channels;
  @override
  final String bio;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String coverPhotoUrl;
  @override
  final String email;
  @override
  final String avatarUrl;
  @JsonKey(defaultValue: false)
  @override
  final bool notificationsEnabled;
  @override
  final int reportCount;
  @JsonKey(defaultValue: false)
  @override
  final bool isTester;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Student(id: $id, fullName: $fullName, channels: $channels, bio: $bio, firstName: $firstName, lastName: $lastName, coverPhotoUrl: $coverPhotoUrl, email: $email, avatarUrl: $avatarUrl, notificationsEnabled: $notificationsEnabled, reportCount: $reportCount, isTester: $isTester)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Student'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('fullName', fullName))
      ..add(DiagnosticsProperty('channels', channels))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('firstName', firstName))
      ..add(DiagnosticsProperty('lastName', lastName))
      ..add(DiagnosticsProperty('coverPhotoUrl', coverPhotoUrl))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('avatarUrl', avatarUrl))
      ..add(DiagnosticsProperty('notificationsEnabled', notificationsEnabled))
      ..add(DiagnosticsProperty('reportCount', reportCount))
      ..add(DiagnosticsProperty('isTester', isTester));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Student &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.channels, channels) ||
                const DeepCollectionEquality()
                    .equals(other.channels, channels)) &&
            (identical(other.bio, bio) ||
                const DeepCollectionEquality().equals(other.bio, bio)) &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.coverPhotoUrl, coverPhotoUrl) ||
                const DeepCollectionEquality()
                    .equals(other.coverPhotoUrl, coverPhotoUrl)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                const DeepCollectionEquality().equals(
                    other.notificationsEnabled, notificationsEnabled)) &&
            (identical(other.reportCount, reportCount) ||
                const DeepCollectionEquality()
                    .equals(other.reportCount, reportCount)) &&
            (identical(other.isTester, isTester) ||
                const DeepCollectionEquality()
                    .equals(other.isTester, isTester)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(channels) ^
      const DeepCollectionEquality().hash(bio) ^
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(coverPhotoUrl) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(notificationsEnabled) ^
      const DeepCollectionEquality().hash(reportCount) ^
      const DeepCollectionEquality().hash(isTester);

  @override
  _$StudentCopyWith<_Student> get copyWith =>
      __$StudentCopyWithImpl<_Student>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_StudentToJson(this);
  }
}

abstract class _Student implements Student {
  const factory _Student(
      {@required String id,
      @required String fullName,
      List<String> channels,
      String bio,
      String firstName,
      String lastName,
      String coverPhotoUrl,
      String email,
      String avatarUrl,
      bool notificationsEnabled,
      int reportCount,
      bool isTester}) = _$_Student;

  factory _Student.fromJson(Map<String, dynamic> json) = _$_Student.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  List<String> get channels;
  @override
  String get bio;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String get coverPhotoUrl;
  @override
  String get email;
  @override
  String get avatarUrl;
  @override
  bool get notificationsEnabled;
  @override
  int get reportCount;
  @override
  bool get isTester;
  @override
  _$StudentCopyWith<_Student> get copyWith;
}
