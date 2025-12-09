import 'dart:async';

class ApiResult {
  final bool success;
  final String? message;
  const ApiResult(this.success, [this.message]);
}

class ApiService {
  static Future<ApiResult> topUp({
    required String phone,
    required String operatorName,
    required int nominal,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final ok = phone.isNotEmpty && nominal > 0;
    return ok
        ? const ApiResult(true, 'Top-up berhasil')
        : const ApiResult(false, 'Top-up gagal');
  }

  static Future<ApiResult> buyDataPackage({
    required String phone,
    required String operatorName,
    required String packageName,
    required int price,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));
    final ok = phone.isNotEmpty && price > 0;
    return ok
        ? const ApiResult(true, 'Pembelian paket berhasil')
        : const ApiResult(false, 'Pembelian paket gagal');
  }
}
