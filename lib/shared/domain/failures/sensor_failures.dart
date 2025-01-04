sealed class SensorFailure {
  const SensorFailure();
}

final class NoDataFailure extends SensorFailure {
  const NoDataFailure();
}

final class ConnectionFailure extends SensorFailure {
  const ConnectionFailure();
}

final class ServerFailure extends SensorFailure {
  const ServerFailure();
}
