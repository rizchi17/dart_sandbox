/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:todo_api_client/src/protocol/todo_class.dart' as _i3;
import 'protocol.dart' as _i4;

/// {@category Endpoint}
class EndpointExample extends _i1.EndpointRef {
  EndpointExample(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'example';

  _i2.Future<String> hello(String name) => caller.callServerEndpoint<String>(
        'example',
        'hello',
        {'name': name},
      );
}

/// {@category Endpoint}
class EndpointTodo extends _i1.EndpointRef {
  EndpointTodo(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'todo';

  _i2.Future<List<_i3.Todo>> getAllTodos() =>
      caller.callServerEndpoint<List<_i3.Todo>>(
        'todo',
        'getAllTodos',
        {},
      );

  _i2.Future<void> addTodo({required String text}) =>
      caller.callServerEndpoint<void>(
        'todo',
        'addTodo',
        {'text': text},
      );

  _i2.Future<void> updateTodo({
    required _i3.Todo todo,
    required int index,
  }) =>
      caller.callServerEndpoint<void>(
        'todo',
        'updateTodo',
        {
          'todo': todo,
          'index': index,
        },
      );

  _i2.Future<void> deleteTodo({required int index}) =>
      caller.callServerEndpoint<void>(
        'todo',
        'deleteTodo',
        {'index': index},
      );
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i4.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    example = EndpointExample(this);
    todo = EndpointTodo(this);
  }

  late final EndpointExample example;

  late final EndpointTodo todo;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'example': example,
        'todo': todo,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {};
}
