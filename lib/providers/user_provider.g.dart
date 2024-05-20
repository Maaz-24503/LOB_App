// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHash() => r'2a0386f747e7fd20d7694aa82fdcc18f2d3aa5a7';

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

/// See also [user].
@ProviderFor(user)
const userProvider = UserFamily();

/// See also [user].
class UserFamily extends Family<AsyncValue<Users>> {
  /// See also [user].
  const UserFamily();

  /// See also [user].
  UserProvider call({
    required String email,
  }) {
    return UserProvider(
      email: email,
    );
  }

  @override
  UserProvider getProviderOverride(
    covariant UserProvider provider,
  ) {
    return call(
      email: provider.email,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProvider';
}

/// See also [user].
class UserProvider extends AutoDisposeFutureProvider<Users> {
  /// See also [user].
  UserProvider({
    required String email,
  }) : this._internal(
          (ref) => user(
            ref as UserRef,
            email: email,
          ),
          from: userProvider,
          name: r'userProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
          dependencies: UserFamily._dependencies,
          allTransitiveDependencies: UserFamily._allTransitiveDependencies,
          email: email,
        );

  UserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
  }) : super.internal();

  final String email;

  @override
  Override overrideWith(
    FutureOr<Users> Function(UserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProvider._internal(
        (ref) => create(ref as UserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Users> createElement() {
    return _UserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProvider && other.email == email;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserRef on AutoDisposeFutureProviderRef<Users> {
  /// The parameter `email` of this provider.
  String get email;
}

class _UserProviderElement extends AutoDisposeFutureProviderElement<Users>
    with UserRef {
  _UserProviderElement(super.provider);

  @override
  String get email => (origin as UserProvider).email;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
