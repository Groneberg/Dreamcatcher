class ImportResult {
  final int importedCount;
  final int skippedCount;
  final String? errorMessage;
  final bool isSuccess;

  const ImportResult.success({
    required this.importedCount,
    this.skippedCount = 0,
  })  : isSuccess = true,
        errorMessage = null;

  const ImportResult.failure(this.errorMessage)
      : isSuccess = false,
        importedCount = 0,
        skippedCount = 0;

  const ImportResult.cancelled()
      : isSuccess = false,
        importedCount = 0,
        skippedCount = 0,
        errorMessage = null;
}