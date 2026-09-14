import 'package:logging/logging.dart';

/// Column name the oracle runner uses for a result set
const oracleViolationsColumn = 'oracleViolations';

enum DbOracleSeverity {
  /// For unacceptable findings
  error(Level.SEVERE),

  /// For results that must be checked manually
  warning(Level.WARNING);

  const DbOracleSeverity(
    this.level,
  );

  final Level level;
}

/// A population-time invariant exclusively used to enforce data ingegrity
///
/// `sql` must be a single SELECT that returns only violations and usable as a
/// subquery: i.e. no trailing semicolon
typedef DbOracle = ({String id, String sql, DbOracleSeverity severity});

/// Thrown when at least one [DbOracleSeverity.error] oracle returns
class DbIntegrityError extends Error {
  DbIntegrityError(
    this.failed,
  );

  final List<String> failed;

  @override
  String toString() => 'Database integrity check failed: ${failed.join(', ')}';
  //
}
