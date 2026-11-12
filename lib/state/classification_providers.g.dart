// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classificationsEnabledHash() =>
    r'3baf40061e4cf566845c751dd1a0c819185b8ec0';

/// See also [ClassificationsEnabled].
@ProviderFor(ClassificationsEnabled)
final classificationsEnabledProvider =
    AutoDisposeNotifierProvider<ClassificationsEnabled, bool>.internal(
      ClassificationsEnabled.new,
      name: r'classificationsEnabledProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$classificationsEnabledHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassificationsEnabled = AutoDisposeNotifier<bool>;
String _$classificationEngineHash() =>
    r'47bcbe5eb096c1996b0f1751e44fbce0eb35e4c2';

/// See also [ClassificationEngine].
@ProviderFor(ClassificationEngine)
final classificationEngineProvider =
    AutoDisposeAsyncNotifierProvider<
      ClassificationEngine,
      PositionClassification?
    >.internal(
      ClassificationEngine.new,
      name: r'classificationEngineProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$classificationEngineHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassificationEngine =
    AutoDisposeAsyncNotifier<PositionClassification?>;
String _$latestClassificationHash() =>
    r'797c849ebe743456d1a98b15fc8cc355a514e23f';

/// See also [LatestClassification].
@ProviderFor(LatestClassification)
final latestClassificationProvider =
    AutoDisposeNotifierProvider<
      LatestClassification,
      PositionClassification?
    >.internal(
      LatestClassification.new,
      name: r'latestClassificationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$latestClassificationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LatestClassification = AutoDisposeNotifier<PositionClassification?>;
String _$classificationHistoryHash() =>
    r'173650e959095f014cf7eacc7ecd0d6f6a1a7d7c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ClassificationHistory
    extends BuildlessAutoDisposeAsyncNotifier<List<PositionClassification>> {
  late final String patientId;
  late final String sessionId;

  FutureOr<List<PositionClassification>> build(
    String patientId,
    String sessionId,
  );
}

/// See also [ClassificationHistory].
@ProviderFor(ClassificationHistory)
const classificationHistoryProvider = ClassificationHistoryFamily();

/// See also [ClassificationHistory].
class ClassificationHistoryFamily
    extends Family<AsyncValue<List<PositionClassification>>> {
  /// See also [ClassificationHistory].
  const ClassificationHistoryFamily();

  /// See also [ClassificationHistory].
  ClassificationHistoryProvider call(String patientId, String sessionId) {
    return ClassificationHistoryProvider(patientId, sessionId);
  }

  @override
  ClassificationHistoryProvider getProviderOverride(
    covariant ClassificationHistoryProvider provider,
  ) {
    return call(provider.patientId, provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'classificationHistoryProvider';
}

/// See also [ClassificationHistory].
class ClassificationHistoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ClassificationHistory,
          List<PositionClassification>
        > {
  /// See also [ClassificationHistory].
  ClassificationHistoryProvider(String patientId, String sessionId)
    : this._internal(
        () => ClassificationHistory()
          ..patientId = patientId
          ..sessionId = sessionId,
        from: classificationHistoryProvider,
        name: r'classificationHistoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$classificationHistoryHash,
        dependencies: ClassificationHistoryFamily._dependencies,
        allTransitiveDependencies:
            ClassificationHistoryFamily._allTransitiveDependencies,
        patientId: patientId,
        sessionId: sessionId,
      );

  ClassificationHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
    required this.sessionId,
  }) : super.internal();

  final String patientId;
  final String sessionId;

  @override
  FutureOr<List<PositionClassification>> runNotifierBuild(
    covariant ClassificationHistory notifier,
  ) {
    return notifier.build(patientId, sessionId);
  }

  @override
  Override overrideWith(ClassificationHistory Function() create) {
    return ProviderOverride(
      origin: this,
      override: ClassificationHistoryProvider._internal(
        () => create()
          ..patientId = patientId
          ..sessionId = sessionId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ClassificationHistory,
    List<PositionClassification>
  >
  createElement() {
    return _ClassificationHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ClassificationHistoryProvider &&
        other.patientId == patientId &&
        other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ClassificationHistoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<PositionClassification>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _ClassificationHistoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ClassificationHistory,
          List<PositionClassification>
        >
    with ClassificationHistoryRef {
  _ClassificationHistoryProviderElement(super.provider);

  @override
  String get patientId => (origin as ClassificationHistoryProvider).patientId;
  @override
  String get sessionId => (origin as ClassificationHistoryProvider).sessionId;
}

String _$baselineFrameHash() => r'd8f80c8f5d84606053c8a73b11cf85bfd8e3de53';

/// See also [BaselineFrame].
@ProviderFor(BaselineFrame)
final baselineFrameProvider =
    NotifierProvider<BaselineFrame, List<double>?>.internal(
      BaselineFrame.new,
      name: r'baselineFrameProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$baselineFrameHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BaselineFrame = Notifier<List<double>?>;
String _$calibrationRunningHash() =>
    r'b338cabbb2db18f035ece707c716bff30fb34059';

/// See also [CalibrationRunning].
@ProviderFor(CalibrationRunning)
final calibrationRunningProvider =
    NotifierProvider<CalibrationRunning, bool>.internal(
      CalibrationRunning.new,
      name: r'calibrationRunningProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$calibrationRunningHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CalibrationRunning = Notifier<bool>;
String _$calibrationCountdownHash() =>
    r'63d9b9b331ed77f6bcdd1dc3f2a5d933cd05d479';

/// See also [CalibrationCountdown].
@ProviderFor(CalibrationCountdown)
final calibrationCountdownProvider =
    NotifierProvider<CalibrationCountdown, int>.internal(
      CalibrationCountdown.new,
      name: r'calibrationCountdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$calibrationCountdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CalibrationCountdown = Notifier<int>;
String _$calibrationFramesHash() => r'73865447698fa7032cde65763425a4ee2999a9d4';

/// See also [CalibrationFrames].
@ProviderFor(CalibrationFrames)
final calibrationFramesProvider =
    NotifierProvider<CalibrationFrames, List<List<double>>>.internal(
      CalibrationFrames.new,
      name: r'calibrationFramesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$calibrationFramesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CalibrationFrames = Notifier<List<List<double>>>;
String _$classificationRunningHash() =>
    r'2a20fe567962a079cba24849e7bacff1c01ac625';

/// See also [ClassificationRunning].
@ProviderFor(ClassificationRunning)
final classificationRunningProvider =
    NotifierProvider<ClassificationRunning, bool>.internal(
      ClassificationRunning.new,
      name: r'classificationRunningProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$classificationRunningHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassificationRunning = Notifier<bool>;
String _$classificationCountdownHash() =>
    r'd2f41f32f1b771142ccdbb664a320d44f7cb3768';

/// See also [ClassificationCountdown].
@ProviderFor(ClassificationCountdown)
final classificationCountdownProvider =
    NotifierProvider<ClassificationCountdown, int>.internal(
      ClassificationCountdown.new,
      name: r'classificationCountdownProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$classificationCountdownHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassificationCountdown = Notifier<int>;
String _$classificationFramesHash() =>
    r'a93877883429fe7e41021cddf47c3e528703fdbc';

/// See also [ClassificationFrames].
@ProviderFor(ClassificationFrames)
final classificationFramesProvider =
    NotifierProvider<ClassificationFrames, List<List<double>>>.internal(
      ClassificationFrames.new,
      name: r'classificationFramesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$classificationFramesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ClassificationFrames = Notifier<List<List<double>>>;
String _$currentFrameHash() => r'7ecf7c5b64fd34925bd5a31ce4ac5aa13b5872d7';

/// See also [CurrentFrame].
@ProviderFor(CurrentFrame)
final currentFrameProvider =
    NotifierProvider<CurrentFrame, List<double>?>.internal(
      CurrentFrame.new,
      name: r'currentFrameProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentFrameHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentFrame = Notifier<List<double>?>;
String _$frameHistoryHash() => r'ccdfa618ef158c3ab06f6f7c479f0cf11c94474a';

/// See also [FrameHistory].
@ProviderFor(FrameHistory)
final frameHistoryProvider =
    NotifierProvider<FrameHistory, List<List<double>>>.internal(
      FrameHistory.new,
      name: r'frameHistoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$frameHistoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FrameHistory = Notifier<List<List<double>>>;
String _$normalisedFrameHash() => r'f4c7b50f9c6876d76a3ca7c3d836736cf5d29b97';

/// See also [NormalisedFrame].
@ProviderFor(NormalisedFrame)
final normalisedFrameProvider =
    NotifierProvider<NormalisedFrame, List<double>?>.internal(
      NormalisedFrame.new,
      name: r'normalisedFrameProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$normalisedFrameHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NormalisedFrame = Notifier<List<double>?>;
String _$predictionResultHash() => r'b97197784b0d1812ebf2b4362609ba66b54aaf26';

/// See also [PredictionResult].
@ProviderFor(PredictionResult)
final predictionResultProvider =
    NotifierProvider<PredictionResult, String?>.internal(
      PredictionResult.new,
      name: r'predictionResultProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$predictionResultHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PredictionResult = Notifier<String?>;
String _$predictionConfidenceHash() =>
    r'1763c475f9958541a4a9f2cd33054064beb4add6';

/// See also [PredictionConfidence].
@ProviderFor(PredictionConfidence)
final predictionConfidenceProvider =
    NotifierProvider<PredictionConfidence, double?>.internal(
      PredictionConfidence.new,
      name: r'predictionConfidenceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$predictionConfidenceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PredictionConfidence = Notifier<double?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
