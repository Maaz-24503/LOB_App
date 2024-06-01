// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teamsHash() => r'2001de3826122fceddf6a091efef0081f8bced1c';

/// See also [Teams].
@ProviderFor(Teams)
final teamsProvider =
    AutoDisposeAsyncNotifierProvider<Teams, List<Team>>.internal(
  Teams.new,
  name: r'teamsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$teamsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Teams = AutoDisposeAsyncNotifier<List<Team>>;
String _$rostersHash() => r'6724b0d6ecf9f8fe15ac819fcc3ba08bf958705f';

/// See also [Rosters].
@ProviderFor(Rosters)
final rostersProvider =
    AutoDisposeAsyncNotifierProvider<Rosters, List<Roster>>.internal(
  Rosters.new,
  name: r'rostersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rostersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Rosters = AutoDisposeAsyncNotifier<List<Roster>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
