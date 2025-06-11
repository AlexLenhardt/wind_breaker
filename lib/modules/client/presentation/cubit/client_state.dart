import 'package:wind_breaker/modules/client/domain/entities/client.dart';

abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<Client> items;

  ClientLoaded(this.items);
}

class StockError extends ClientState {
  final String message;

  StockError(this.message);
}
