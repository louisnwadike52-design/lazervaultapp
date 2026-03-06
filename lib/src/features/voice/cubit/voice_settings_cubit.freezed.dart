// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voice_settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VoiceSettingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoiceSettingsStateCopyWith<$Res> {
  factory $VoiceSettingsStateCopyWith(
          VoiceSettingsState value, $Res Function(VoiceSettingsState) then) =
      _$VoiceSettingsStateCopyWithImpl<$Res, VoiceSettingsState>;
}

/// @nodoc
class _$VoiceSettingsStateCopyWithImpl<$Res, $Val extends VoiceSettingsState>
    implements $VoiceSettingsStateCopyWith<$Res> {
  _$VoiceSettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl extends _Initial {
  const _$InitialImpl() : super._();

  @override
  String toString() {
    return 'VoiceSettingsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial extends VoiceSettingsState {
  const factory _Initial() = _$InitialImpl;
  const _Initial._() : super._();
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl extends _Loading {
  const _$LoadingImpl() : super._();

  @override
  String toString() {
    return 'VoiceSettingsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading extends VoiceSettingsState {
  const factory _Loading() = _$LoadingImpl;
  const _Loading._() : super._();
}

/// @nodoc
abstract class _$$LanguagesLoadedImplCopyWith<$Res> {
  factory _$$LanguagesLoadedImplCopyWith(_$LanguagesLoadedImpl value,
          $Res Function(_$LanguagesLoadedImpl) then) =
      __$$LanguagesLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<VoiceLanguage> languages,
      List<VoiceOption> voices,
      String? selectedLanguageCode,
      String? selectedVoiceId,
      Map<String, UserVoiceSetting> userSettings,
      bool isLoadingVoices,
      bool isSaving,
      bool isSubmittingSample,
      bool isGeneratingVoice,
      bool isAuthenticating,
      bool useCustomVoice,
      String? customVoiceProvider,
      String? customVoiceUrl,
      double voiceTemperature});
}

/// @nodoc
class __$$LanguagesLoadedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$LanguagesLoadedImpl>
    implements _$$LanguagesLoadedImplCopyWith<$Res> {
  __$$LanguagesLoadedImplCopyWithImpl(
      _$LanguagesLoadedImpl _value, $Res Function(_$LanguagesLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languages = null,
    Object? voices = null,
    Object? selectedLanguageCode = freezed,
    Object? selectedVoiceId = freezed,
    Object? userSettings = null,
    Object? isLoadingVoices = null,
    Object? isSaving = null,
    Object? isSubmittingSample = null,
    Object? isGeneratingVoice = null,
    Object? isAuthenticating = null,
    Object? useCustomVoice = null,
    Object? customVoiceProvider = freezed,
    Object? customVoiceUrl = freezed,
    Object? voiceTemperature = null,
  }) {
    return _then(_$LanguagesLoadedImpl(
      languages: null == languages
          ? _value._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<VoiceLanguage>,
      voices: null == voices
          ? _value._voices
          : voices // ignore: cast_nullable_to_non_nullable
              as List<VoiceOption>,
      selectedLanguageCode: freezed == selectedLanguageCode
          ? _value.selectedLanguageCode
          : selectedLanguageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedVoiceId: freezed == selectedVoiceId
          ? _value.selectedVoiceId
          : selectedVoiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      userSettings: null == userSettings
          ? _value._userSettings
          : userSettings // ignore: cast_nullable_to_non_nullable
              as Map<String, UserVoiceSetting>,
      isLoadingVoices: null == isLoadingVoices
          ? _value.isLoadingVoices
          : isLoadingVoices // ignore: cast_nullable_to_non_nullable
              as bool,
      isSaving: null == isSaving
          ? _value.isSaving
          : isSaving // ignore: cast_nullable_to_non_nullable
              as bool,
      isSubmittingSample: null == isSubmittingSample
          ? _value.isSubmittingSample
          : isSubmittingSample // ignore: cast_nullable_to_non_nullable
              as bool,
      isGeneratingVoice: null == isGeneratingVoice
          ? _value.isGeneratingVoice
          : isGeneratingVoice // ignore: cast_nullable_to_non_nullable
              as bool,
      isAuthenticating: null == isAuthenticating
          ? _value.isAuthenticating
          : isAuthenticating // ignore: cast_nullable_to_non_nullable
              as bool,
      useCustomVoice: null == useCustomVoice
          ? _value.useCustomVoice
          : useCustomVoice // ignore: cast_nullable_to_non_nullable
              as bool,
      customVoiceProvider: freezed == customVoiceProvider
          ? _value.customVoiceProvider
          : customVoiceProvider // ignore: cast_nullable_to_non_nullable
              as String?,
      customVoiceUrl: freezed == customVoiceUrl
          ? _value.customVoiceUrl
          : customVoiceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      voiceTemperature: null == voiceTemperature
          ? _value.voiceTemperature
          : voiceTemperature // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$LanguagesLoadedImpl extends _LanguagesLoaded {
  const _$LanguagesLoadedImpl(
      {required final List<VoiceLanguage> languages,
      final List<VoiceOption> voices = const [],
      this.selectedLanguageCode,
      this.selectedVoiceId,
      final Map<String, UserVoiceSetting> userSettings = const {},
      this.isLoadingVoices = false,
      this.isSaving = false,
      this.isSubmittingSample = false,
      this.isGeneratingVoice = false,
      this.isAuthenticating = false,
      this.useCustomVoice = false,
      this.customVoiceProvider,
      this.customVoiceUrl,
      this.voiceTemperature = 0.7})
      : _languages = languages,
        _voices = voices,
        _userSettings = userSettings,
        super._();

  final List<VoiceLanguage> _languages;
  @override
  List<VoiceLanguage> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  final List<VoiceOption> _voices;
  @override
  @JsonKey()
  List<VoiceOption> get voices {
    if (_voices is EqualUnmodifiableListView) return _voices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_voices);
  }

  @override
  final String? selectedLanguageCode;
  @override
  final String? selectedVoiceId;
  final Map<String, UserVoiceSetting> _userSettings;
  @override
  @JsonKey()
  Map<String, UserVoiceSetting> get userSettings {
    if (_userSettings is EqualUnmodifiableMapView) return _userSettings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_userSettings);
  }

  @override
  @JsonKey()
  final bool isLoadingVoices;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  @JsonKey()
  final bool isSubmittingSample;
  @override
  @JsonKey()
  final bool isGeneratingVoice;
  @override
  @JsonKey()
  final bool isAuthenticating;
  @override
  @JsonKey()
  final bool useCustomVoice;
  @override
  final String? customVoiceProvider;
  @override
  final String? customVoiceUrl;
  @override
  @JsonKey()
  final double voiceTemperature;

  @override
  String toString() {
    return 'VoiceSettingsState.languagesLoaded(languages: $languages, voices: $voices, selectedLanguageCode: $selectedLanguageCode, selectedVoiceId: $selectedVoiceId, userSettings: $userSettings, isLoadingVoices: $isLoadingVoices, isSaving: $isSaving, isSubmittingSample: $isSubmittingSample, isGeneratingVoice: $isGeneratingVoice, isAuthenticating: $isAuthenticating, useCustomVoice: $useCustomVoice, customVoiceProvider: $customVoiceProvider, customVoiceUrl: $customVoiceUrl, voiceTemperature: $voiceTemperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguagesLoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._languages, _languages) &&
            const DeepCollectionEquality().equals(other._voices, _voices) &&
            (identical(other.selectedLanguageCode, selectedLanguageCode) ||
                other.selectedLanguageCode == selectedLanguageCode) &&
            (identical(other.selectedVoiceId, selectedVoiceId) ||
                other.selectedVoiceId == selectedVoiceId) &&
            const DeepCollectionEquality()
                .equals(other._userSettings, _userSettings) &&
            (identical(other.isLoadingVoices, isLoadingVoices) ||
                other.isLoadingVoices == isLoadingVoices) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.isSubmittingSample, isSubmittingSample) ||
                other.isSubmittingSample == isSubmittingSample) &&
            (identical(other.isGeneratingVoice, isGeneratingVoice) ||
                other.isGeneratingVoice == isGeneratingVoice) &&
            (identical(other.isAuthenticating, isAuthenticating) ||
                other.isAuthenticating == isAuthenticating) &&
            (identical(other.useCustomVoice, useCustomVoice) ||
                other.useCustomVoice == useCustomVoice) &&
            (identical(other.customVoiceProvider, customVoiceProvider) ||
                other.customVoiceProvider == customVoiceProvider) &&
            (identical(other.customVoiceUrl, customVoiceUrl) ||
                other.customVoiceUrl == customVoiceUrl) &&
            (identical(other.voiceTemperature, voiceTemperature) ||
                other.voiceTemperature == voiceTemperature));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_languages),
      const DeepCollectionEquality().hash(_voices),
      selectedLanguageCode,
      selectedVoiceId,
      const DeepCollectionEquality().hash(_userSettings),
      isLoadingVoices,
      isSaving,
      isSubmittingSample,
      isGeneratingVoice,
      isAuthenticating,
      useCustomVoice,
      customVoiceProvider,
      customVoiceUrl,
      voiceTemperature);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguagesLoadedImplCopyWith<_$LanguagesLoadedImpl> get copyWith =>
      __$$LanguagesLoadedImplCopyWithImpl<_$LanguagesLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return languagesLoaded(
        languages,
        voices,
        selectedLanguageCode,
        selectedVoiceId,
        userSettings,
        isLoadingVoices,
        isSaving,
        isSubmittingSample,
        isGeneratingVoice,
        isAuthenticating,
        useCustomVoice,
        customVoiceProvider,
        customVoiceUrl,
        voiceTemperature);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return languagesLoaded?.call(
        languages,
        voices,
        selectedLanguageCode,
        selectedVoiceId,
        userSettings,
        isLoadingVoices,
        isSaving,
        isSubmittingSample,
        isGeneratingVoice,
        isAuthenticating,
        useCustomVoice,
        customVoiceProvider,
        customVoiceUrl,
        voiceTemperature);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (languagesLoaded != null) {
      return languagesLoaded(
          languages,
          voices,
          selectedLanguageCode,
          selectedVoiceId,
          userSettings,
          isLoadingVoices,
          isSaving,
          isSubmittingSample,
          isGeneratingVoice,
          isAuthenticating,
          useCustomVoice,
          customVoiceProvider,
          customVoiceUrl,
          voiceTemperature);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return languagesLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return languagesLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (languagesLoaded != null) {
      return languagesLoaded(this);
    }
    return orElse();
  }
}

abstract class _LanguagesLoaded extends VoiceSettingsState {
  const factory _LanguagesLoaded(
      {required final List<VoiceLanguage> languages,
      final List<VoiceOption> voices,
      final String? selectedLanguageCode,
      final String? selectedVoiceId,
      final Map<String, UserVoiceSetting> userSettings,
      final bool isLoadingVoices,
      final bool isSaving,
      final bool isSubmittingSample,
      final bool isGeneratingVoice,
      final bool isAuthenticating,
      final bool useCustomVoice,
      final String? customVoiceProvider,
      final String? customVoiceUrl,
      final double voiceTemperature}) = _$LanguagesLoadedImpl;
  const _LanguagesLoaded._() : super._();

  List<VoiceLanguage> get languages;
  List<VoiceOption> get voices;
  String? get selectedLanguageCode;
  String? get selectedVoiceId;
  Map<String, UserVoiceSetting> get userSettings;
  bool get isLoadingVoices;
  bool get isSaving;
  bool get isSubmittingSample;
  bool get isGeneratingVoice;
  bool get isAuthenticating;
  bool get useCustomVoice;
  String? get customVoiceProvider;
  String? get customVoiceUrl;
  double get voiceTemperature;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LanguagesLoadedImplCopyWith<_$LanguagesLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl extends _Error {
  const _$ErrorImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'VoiceSettingsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error extends VoiceSettingsState {
  const factory _Error({required final String message}) = _$ErrorImpl;
  const _Error._() : super._();

  String get message;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnrollmentInProgressImplCopyWith<$Res> {
  factory _$$EnrollmentInProgressImplCopyWith(_$EnrollmentInProgressImpl value,
          $Res Function(_$EnrollmentInProgressImpl) then) =
      __$$EnrollmentInProgressImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EnrollmentInProgressImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$EnrollmentInProgressImpl>
    implements _$$EnrollmentInProgressImplCopyWith<$Res> {
  __$$EnrollmentInProgressImplCopyWithImpl(_$EnrollmentInProgressImpl _value,
      $Res Function(_$EnrollmentInProgressImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EnrollmentInProgressImpl extends _EnrollmentInProgress {
  const _$EnrollmentInProgressImpl() : super._();

  @override
  String toString() {
    return 'VoiceSettingsState.enrollmentInProgress()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentInProgressImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return enrollmentInProgress();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return enrollmentInProgress?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentInProgress != null) {
      return enrollmentInProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return enrollmentInProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return enrollmentInProgress?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentInProgress != null) {
      return enrollmentInProgress(this);
    }
    return orElse();
  }
}

abstract class _EnrollmentInProgress extends VoiceSettingsState {
  const factory _EnrollmentInProgress() = _$EnrollmentInProgressImpl;
  const _EnrollmentInProgress._() : super._();
}

/// @nodoc
abstract class _$$EnrollmentSessionImplCopyWith<$Res> {
  factory _$$EnrollmentSessionImplCopyWith(_$EnrollmentSessionImpl value,
          $Res Function(_$EnrollmentSessionImpl) then) =
      __$$EnrollmentSessionImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {VoiceEnrollmentSession session,
      int currentStep,
      List<double> qualityScores,
      String? nextPhrase,
      bool isSubmittingSample});
}

/// @nodoc
class __$$EnrollmentSessionImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$EnrollmentSessionImpl>
    implements _$$EnrollmentSessionImplCopyWith<$Res> {
  __$$EnrollmentSessionImplCopyWithImpl(_$EnrollmentSessionImpl _value,
      $Res Function(_$EnrollmentSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? currentStep = null,
    Object? qualityScores = null,
    Object? nextPhrase = freezed,
    Object? isSubmittingSample = null,
  }) {
    return _then(_$EnrollmentSessionImpl(
      session: null == session
          ? _value.session
          : session // ignore: cast_nullable_to_non_nullable
              as VoiceEnrollmentSession,
      currentStep: null == currentStep
          ? _value.currentStep
          : currentStep // ignore: cast_nullable_to_non_nullable
              as int,
      qualityScores: null == qualityScores
          ? _value._qualityScores
          : qualityScores // ignore: cast_nullable_to_non_nullable
              as List<double>,
      nextPhrase: freezed == nextPhrase
          ? _value.nextPhrase
          : nextPhrase // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmittingSample: null == isSubmittingSample
          ? _value.isSubmittingSample
          : isSubmittingSample // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EnrollmentSessionImpl extends _EnrollmentSession {
  const _$EnrollmentSessionImpl(
      {required this.session,
      this.currentStep = 0,
      final List<double> qualityScores = const [],
      this.nextPhrase,
      this.isSubmittingSample = false})
      : _qualityScores = qualityScores,
        super._();

  @override
  final VoiceEnrollmentSession session;
  @override
  @JsonKey()
  final int currentStep;
  final List<double> _qualityScores;
  @override
  @JsonKey()
  List<double> get qualityScores {
    if (_qualityScores is EqualUnmodifiableListView) return _qualityScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualityScores);
  }

  @override
  final String? nextPhrase;
  @override
  @JsonKey()
  final bool isSubmittingSample;

  @override
  String toString() {
    return 'VoiceSettingsState.enrollmentSession(session: $session, currentStep: $currentStep, qualityScores: $qualityScores, nextPhrase: $nextPhrase, isSubmittingSample: $isSubmittingSample)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentSessionImpl &&
            (identical(other.session, session) || other.session == session) &&
            (identical(other.currentStep, currentStep) ||
                other.currentStep == currentStep) &&
            const DeepCollectionEquality()
                .equals(other._qualityScores, _qualityScores) &&
            (identical(other.nextPhrase, nextPhrase) ||
                other.nextPhrase == nextPhrase) &&
            (identical(other.isSubmittingSample, isSubmittingSample) ||
                other.isSubmittingSample == isSubmittingSample));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      session,
      currentStep,
      const DeepCollectionEquality().hash(_qualityScores),
      nextPhrase,
      isSubmittingSample);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrollmentSessionImplCopyWith<_$EnrollmentSessionImpl> get copyWith =>
      __$$EnrollmentSessionImplCopyWithImpl<_$EnrollmentSessionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return enrollmentSession(
        session, currentStep, qualityScores, nextPhrase, isSubmittingSample);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return enrollmentSession?.call(
        session, currentStep, qualityScores, nextPhrase, isSubmittingSample);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentSession != null) {
      return enrollmentSession(
          session, currentStep, qualityScores, nextPhrase, isSubmittingSample);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return enrollmentSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return enrollmentSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentSession != null) {
      return enrollmentSession(this);
    }
    return orElse();
  }
}

abstract class _EnrollmentSession extends VoiceSettingsState {
  const factory _EnrollmentSession(
      {required final VoiceEnrollmentSession session,
      final int currentStep,
      final List<double> qualityScores,
      final String? nextPhrase,
      final bool isSubmittingSample}) = _$EnrollmentSessionImpl;
  const _EnrollmentSession._() : super._();

  VoiceEnrollmentSession get session;
  int get currentStep;
  List<double> get qualityScores;
  String? get nextPhrase;
  bool get isSubmittingSample;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrollmentSessionImplCopyWith<_$EnrollmentSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnrollmentSampleSubmittedImplCopyWith<$Res> {
  factory _$$EnrollmentSampleSubmittedImplCopyWith(
          _$EnrollmentSampleSubmittedImpl value,
          $Res Function(_$EnrollmentSampleSubmittedImpl) then) =
      __$$EnrollmentSampleSubmittedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {VoiceEnrollmentSession enrollmentSession,
      List<double> qualityScores,
      String feedback,
      String? nextPhrase,
      bool isSubmittingSample});
}

/// @nodoc
class __$$EnrollmentSampleSubmittedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res,
        _$EnrollmentSampleSubmittedImpl>
    implements _$$EnrollmentSampleSubmittedImplCopyWith<$Res> {
  __$$EnrollmentSampleSubmittedImplCopyWithImpl(
      _$EnrollmentSampleSubmittedImpl _value,
      $Res Function(_$EnrollmentSampleSubmittedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? enrollmentSession = null,
    Object? qualityScores = null,
    Object? feedback = null,
    Object? nextPhrase = freezed,
    Object? isSubmittingSample = null,
  }) {
    return _then(_$EnrollmentSampleSubmittedImpl(
      enrollmentSession: null == enrollmentSession
          ? _value.enrollmentSession
          : enrollmentSession // ignore: cast_nullable_to_non_nullable
              as VoiceEnrollmentSession,
      qualityScores: null == qualityScores
          ? _value._qualityScores
          : qualityScores // ignore: cast_nullable_to_non_nullable
              as List<double>,
      feedback: null == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as String,
      nextPhrase: freezed == nextPhrase
          ? _value.nextPhrase
          : nextPhrase // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmittingSample: null == isSubmittingSample
          ? _value.isSubmittingSample
          : isSubmittingSample // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EnrollmentSampleSubmittedImpl extends _EnrollmentSampleSubmitted {
  const _$EnrollmentSampleSubmittedImpl(
      {required this.enrollmentSession,
      required final List<double> qualityScores,
      required this.feedback,
      this.nextPhrase,
      this.isSubmittingSample = false})
      : _qualityScores = qualityScores,
        super._();

  @override
  final VoiceEnrollmentSession enrollmentSession;
  final List<double> _qualityScores;
  @override
  List<double> get qualityScores {
    if (_qualityScores is EqualUnmodifiableListView) return _qualityScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualityScores);
  }

  @override
  final String feedback;
  @override
  final String? nextPhrase;
  @override
  @JsonKey()
  final bool isSubmittingSample;

  @override
  String toString() {
    return 'VoiceSettingsState.enrollmentSampleSubmitted(enrollmentSession: $enrollmentSession, qualityScores: $qualityScores, feedback: $feedback, nextPhrase: $nextPhrase, isSubmittingSample: $isSubmittingSample)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentSampleSubmittedImpl &&
            (identical(other.enrollmentSession, enrollmentSession) ||
                other.enrollmentSession == enrollmentSession) &&
            const DeepCollectionEquality()
                .equals(other._qualityScores, _qualityScores) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.nextPhrase, nextPhrase) ||
                other.nextPhrase == nextPhrase) &&
            (identical(other.isSubmittingSample, isSubmittingSample) ||
                other.isSubmittingSample == isSubmittingSample));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      enrollmentSession,
      const DeepCollectionEquality().hash(_qualityScores),
      feedback,
      nextPhrase,
      isSubmittingSample);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrollmentSampleSubmittedImplCopyWith<_$EnrollmentSampleSubmittedImpl>
      get copyWith => __$$EnrollmentSampleSubmittedImplCopyWithImpl<
          _$EnrollmentSampleSubmittedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return enrollmentSampleSubmitted(this.enrollmentSession, qualityScores,
        feedback, nextPhrase, isSubmittingSample);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return enrollmentSampleSubmitted?.call(this.enrollmentSession,
        qualityScores, feedback, nextPhrase, isSubmittingSample);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentSampleSubmitted != null) {
      return enrollmentSampleSubmitted(this.enrollmentSession, qualityScores,
          feedback, nextPhrase, isSubmittingSample);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return enrollmentSampleSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return enrollmentSampleSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentSampleSubmitted != null) {
      return enrollmentSampleSubmitted(this);
    }
    return orElse();
  }
}

abstract class _EnrollmentSampleSubmitted extends VoiceSettingsState {
  const factory _EnrollmentSampleSubmitted(
      {required final VoiceEnrollmentSession enrollmentSession,
      required final List<double> qualityScores,
      required final String feedback,
      final String? nextPhrase,
      final bool isSubmittingSample}) = _$EnrollmentSampleSubmittedImpl;
  const _EnrollmentSampleSubmitted._() : super._();

  VoiceEnrollmentSession get enrollmentSession;
  List<double> get qualityScores;
  String get feedback;
  String? get nextPhrase;
  bool get isSubmittingSample;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrollmentSampleSubmittedImplCopyWith<_$EnrollmentSampleSubmittedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EnrollmentCompletedImplCopyWith<$Res> {
  factory _$$EnrollmentCompletedImplCopyWith(_$EnrollmentCompletedImpl value,
          $Res Function(_$EnrollmentCompletedImpl) then) =
      __$$EnrollmentCompletedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<double> qualityScores,
      double averageQuality,
      bool isGeneratingVoice});
}

/// @nodoc
class __$$EnrollmentCompletedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$EnrollmentCompletedImpl>
    implements _$$EnrollmentCompletedImplCopyWith<$Res> {
  __$$EnrollmentCompletedImplCopyWithImpl(_$EnrollmentCompletedImpl _value,
      $Res Function(_$EnrollmentCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? qualityScores = null,
    Object? averageQuality = null,
    Object? isGeneratingVoice = null,
  }) {
    return _then(_$EnrollmentCompletedImpl(
      qualityScores: null == qualityScores
          ? _value._qualityScores
          : qualityScores // ignore: cast_nullable_to_non_nullable
              as List<double>,
      averageQuality: null == averageQuality
          ? _value.averageQuality
          : averageQuality // ignore: cast_nullable_to_non_nullable
              as double,
      isGeneratingVoice: null == isGeneratingVoice
          ? _value.isGeneratingVoice
          : isGeneratingVoice // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$EnrollmentCompletedImpl extends _EnrollmentCompleted {
  const _$EnrollmentCompletedImpl(
      {required final List<double> qualityScores,
      required this.averageQuality,
      this.isGeneratingVoice = false})
      : _qualityScores = qualityScores,
        super._();

  final List<double> _qualityScores;
  @override
  List<double> get qualityScores {
    if (_qualityScores is EqualUnmodifiableListView) return _qualityScores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_qualityScores);
  }

  @override
  final double averageQuality;
  @override
  @JsonKey()
  final bool isGeneratingVoice;

  @override
  String toString() {
    return 'VoiceSettingsState.enrollmentCompleted(qualityScores: $qualityScores, averageQuality: $averageQuality, isGeneratingVoice: $isGeneratingVoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnrollmentCompletedImpl &&
            const DeepCollectionEquality()
                .equals(other._qualityScores, _qualityScores) &&
            (identical(other.averageQuality, averageQuality) ||
                other.averageQuality == averageQuality) &&
            (identical(other.isGeneratingVoice, isGeneratingVoice) ||
                other.isGeneratingVoice == isGeneratingVoice));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_qualityScores),
      averageQuality,
      isGeneratingVoice);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EnrollmentCompletedImplCopyWith<_$EnrollmentCompletedImpl> get copyWith =>
      __$$EnrollmentCompletedImplCopyWithImpl<_$EnrollmentCompletedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return enrollmentCompleted(
        qualityScores, averageQuality, isGeneratingVoice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return enrollmentCompleted?.call(
        qualityScores, averageQuality, isGeneratingVoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentCompleted != null) {
      return enrollmentCompleted(
          qualityScores, averageQuality, isGeneratingVoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return enrollmentCompleted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return enrollmentCompleted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (enrollmentCompleted != null) {
      return enrollmentCompleted(this);
    }
    return orElse();
  }
}

abstract class _EnrollmentCompleted extends VoiceSettingsState {
  const factory _EnrollmentCompleted(
      {required final List<double> qualityScores,
      required final double averageQuality,
      final bool isGeneratingVoice}) = _$EnrollmentCompletedImpl;
  const _EnrollmentCompleted._() : super._();

  List<double> get qualityScores;
  double get averageQuality;
  bool get isGeneratingVoice;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EnrollmentCompletedImplCopyWith<_$EnrollmentCompletedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CustomVoiceGeneratedImplCopyWith<$Res> {
  factory _$$CustomVoiceGeneratedImplCopyWith(_$CustomVoiceGeneratedImpl value,
          $Res Function(_$CustomVoiceGeneratedImpl) then) =
      __$$CustomVoiceGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? voiceId, String? voiceUrl, int? estimatedEta});
}

/// @nodoc
class __$$CustomVoiceGeneratedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$CustomVoiceGeneratedImpl>
    implements _$$CustomVoiceGeneratedImplCopyWith<$Res> {
  __$$CustomVoiceGeneratedImplCopyWithImpl(_$CustomVoiceGeneratedImpl _value,
      $Res Function(_$CustomVoiceGeneratedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? voiceId = freezed,
    Object? voiceUrl = freezed,
    Object? estimatedEta = freezed,
  }) {
    return _then(_$CustomVoiceGeneratedImpl(
      voiceId: freezed == voiceId
          ? _value.voiceId
          : voiceId // ignore: cast_nullable_to_non_nullable
              as String?,
      voiceUrl: freezed == voiceUrl
          ? _value.voiceUrl
          : voiceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      estimatedEta: freezed == estimatedEta
          ? _value.estimatedEta
          : estimatedEta // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$CustomVoiceGeneratedImpl extends _CustomVoiceGenerated {
  const _$CustomVoiceGeneratedImpl(
      {this.voiceId, this.voiceUrl, this.estimatedEta})
      : super._();

  @override
  final String? voiceId;
  @override
  final String? voiceUrl;
  @override
  final int? estimatedEta;

  @override
  String toString() {
    return 'VoiceSettingsState.customVoiceGenerated(voiceId: $voiceId, voiceUrl: $voiceUrl, estimatedEta: $estimatedEta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomVoiceGeneratedImpl &&
            (identical(other.voiceId, voiceId) || other.voiceId == voiceId) &&
            (identical(other.voiceUrl, voiceUrl) ||
                other.voiceUrl == voiceUrl) &&
            (identical(other.estimatedEta, estimatedEta) ||
                other.estimatedEta == estimatedEta));
  }

  @override
  int get hashCode => Object.hash(runtimeType, voiceId, voiceUrl, estimatedEta);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomVoiceGeneratedImplCopyWith<_$CustomVoiceGeneratedImpl>
      get copyWith =>
          __$$CustomVoiceGeneratedImplCopyWithImpl<_$CustomVoiceGeneratedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return customVoiceGenerated(voiceId, voiceUrl, estimatedEta);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return customVoiceGenerated?.call(voiceId, voiceUrl, estimatedEta);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (customVoiceGenerated != null) {
      return customVoiceGenerated(voiceId, voiceUrl, estimatedEta);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return customVoiceGenerated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return customVoiceGenerated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (customVoiceGenerated != null) {
      return customVoiceGenerated(this);
    }
    return orElse();
  }
}

abstract class _CustomVoiceGenerated extends VoiceSettingsState {
  const factory _CustomVoiceGenerated(
      {final String? voiceId,
      final String? voiceUrl,
      final int? estimatedEta}) = _$CustomVoiceGeneratedImpl;
  const _CustomVoiceGenerated._() : super._();

  String? get voiceId;
  String? get voiceUrl;
  int? get estimatedEta;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomVoiceGeneratedImplCopyWith<_$CustomVoiceGeneratedImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticatedImplCopyWith<$Res> {
  factory _$$AuthenticatedImplCopyWith(
          _$AuthenticatedImpl value, $Res Function(_$AuthenticatedImpl) then) =
      __$$AuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? userId, double confidence});
}

/// @nodoc
class __$$AuthenticatedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$AuthenticatedImpl>
    implements _$$AuthenticatedImplCopyWith<$Res> {
  __$$AuthenticatedImplCopyWithImpl(
      _$AuthenticatedImpl _value, $Res Function(_$AuthenticatedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? confidence = null,
  }) {
    return _then(_$AuthenticatedImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      confidence: null == confidence
          ? _value.confidence
          : confidence // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$AuthenticatedImpl extends _Authenticated {
  const _$AuthenticatedImpl({this.userId, required this.confidence})
      : super._();

  @override
  final String? userId;
  @override
  final double confidence;

  @override
  String toString() {
    return 'VoiceSettingsState.authenticated(userId: $userId, confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticatedImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, confidence);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      __$$AuthenticatedImplCopyWithImpl<_$AuthenticatedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return authenticated(userId, confidence);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return authenticated?.call(userId, confidence);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userId, confidence);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated extends VoiceSettingsState {
  const factory _Authenticated(
      {final String? userId,
      required final double confidence}) = _$AuthenticatedImpl;
  const _Authenticated._() : super._();

  String? get userId;
  double get confidence;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticatedImplCopyWith<_$AuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthenticationFailedImplCopyWith<$Res> {
  factory _$$AuthenticationFailedImplCopyWith(_$AuthenticationFailedImpl value,
          $Res Function(_$AuthenticationFailedImpl) then) =
      __$$AuthenticationFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AuthenticationFailedImplCopyWithImpl<$Res>
    extends _$VoiceSettingsStateCopyWithImpl<$Res, _$AuthenticationFailedImpl>
    implements _$$AuthenticationFailedImplCopyWith<$Res> {
  __$$AuthenticationFailedImplCopyWithImpl(_$AuthenticationFailedImpl _value,
      $Res Function(_$AuthenticationFailedImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AuthenticationFailedImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AuthenticationFailedImpl extends _AuthenticationFailed {
  const _$AuthenticationFailedImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'VoiceSettingsState.authenticationFailed(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthenticationFailedImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthenticationFailedImplCopyWith<_$AuthenticationFailedImpl>
      get copyWith =>
          __$$AuthenticationFailedImplCopyWithImpl<_$AuthenticationFailedImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)
        languagesLoaded,
    required TResult Function(String message) error,
    required TResult Function() enrollmentInProgress,
    required TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSession,
    required TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)
        enrollmentSampleSubmitted,
    required TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)
        enrollmentCompleted,
    required TResult Function(
            String? voiceId, String? voiceUrl, int? estimatedEta)
        customVoiceGenerated,
    required TResult Function(String? userId, double confidence) authenticated,
    required TResult Function(String message) authenticationFailed,
  }) {
    return authenticationFailed(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult? Function(String message)? error,
    TResult? Function()? enrollmentInProgress,
    TResult? Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult? Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult? Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult? Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult? Function(String? userId, double confidence)? authenticated,
    TResult? Function(String message)? authenticationFailed,
  }) {
    return authenticationFailed?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<VoiceLanguage> languages,
            List<VoiceOption> voices,
            String? selectedLanguageCode,
            String? selectedVoiceId,
            Map<String, UserVoiceSetting> userSettings,
            bool isLoadingVoices,
            bool isSaving,
            bool isSubmittingSample,
            bool isGeneratingVoice,
            bool isAuthenticating,
            bool useCustomVoice,
            String? customVoiceProvider,
            String? customVoiceUrl,
            double voiceTemperature)?
        languagesLoaded,
    TResult Function(String message)? error,
    TResult Function()? enrollmentInProgress,
    TResult Function(
            VoiceEnrollmentSession session,
            int currentStep,
            List<double> qualityScores,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSession,
    TResult Function(
            VoiceEnrollmentSession enrollmentSession,
            List<double> qualityScores,
            String feedback,
            String? nextPhrase,
            bool isSubmittingSample)?
        enrollmentSampleSubmitted,
    TResult Function(List<double> qualityScores, double averageQuality,
            bool isGeneratingVoice)?
        enrollmentCompleted,
    TResult Function(String? voiceId, String? voiceUrl, int? estimatedEta)?
        customVoiceGenerated,
    TResult Function(String? userId, double confidence)? authenticated,
    TResult Function(String message)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticationFailed != null) {
      return authenticationFailed(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_LanguagesLoaded value) languagesLoaded,
    required TResult Function(_Error value) error,
    required TResult Function(_EnrollmentInProgress value) enrollmentInProgress,
    required TResult Function(_EnrollmentSession value) enrollmentSession,
    required TResult Function(_EnrollmentSampleSubmitted value)
        enrollmentSampleSubmitted,
    required TResult Function(_EnrollmentCompleted value) enrollmentCompleted,
    required TResult Function(_CustomVoiceGenerated value) customVoiceGenerated,
    required TResult Function(_Authenticated value) authenticated,
    required TResult Function(_AuthenticationFailed value) authenticationFailed,
  }) {
    return authenticationFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_LanguagesLoaded value)? languagesLoaded,
    TResult? Function(_Error value)? error,
    TResult? Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult? Function(_EnrollmentSession value)? enrollmentSession,
    TResult? Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult? Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult? Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult? Function(_Authenticated value)? authenticated,
    TResult? Function(_AuthenticationFailed value)? authenticationFailed,
  }) {
    return authenticationFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_LanguagesLoaded value)? languagesLoaded,
    TResult Function(_Error value)? error,
    TResult Function(_EnrollmentInProgress value)? enrollmentInProgress,
    TResult Function(_EnrollmentSession value)? enrollmentSession,
    TResult Function(_EnrollmentSampleSubmitted value)?
        enrollmentSampleSubmitted,
    TResult Function(_EnrollmentCompleted value)? enrollmentCompleted,
    TResult Function(_CustomVoiceGenerated value)? customVoiceGenerated,
    TResult Function(_Authenticated value)? authenticated,
    TResult Function(_AuthenticationFailed value)? authenticationFailed,
    required TResult orElse(),
  }) {
    if (authenticationFailed != null) {
      return authenticationFailed(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationFailed extends VoiceSettingsState {
  const factory _AuthenticationFailed({required final String message}) =
      _$AuthenticationFailedImpl;
  const _AuthenticationFailed._() : super._();

  String get message;

  /// Create a copy of VoiceSettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthenticationFailedImplCopyWith<_$AuthenticationFailedImpl>
      get copyWith => throw _privateConstructorUsedError;
}
