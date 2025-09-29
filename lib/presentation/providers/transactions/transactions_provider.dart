import 'package:flutter/foundation.dart';

import '../../../app/services/auth/auth_service.dart';
import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/repositories/transaction_repository.dart';
import '../../../domain/usecases/params/base_params.dart';
import '../../../domain/usecases/transaction_usecases.dart';

class TransactionsProvider extends ChangeNotifier {
  final TransactionRepository transactionRepository;

  TransactionsProvider({required this.transactionRepository});

  List<TransactionEntity>? allTransactions;

  bool isLoadingMore = false;

  Future<void> getAllTransactions({
    int? offset,
    String? contains,
    String? customerName,
  }) async {
    if (offset != null) {
      isLoadingMore = true;
      notifyListeners();
    }

    // tentukan apa yang diisi ke param
    final String filterParam = customerName ?? AuthService().getAuthData()!.uid;

    var params = BaseParams<String>(
      param: filterParam,   // <-- selalu isi, tidak null
      offset: offset,
      contains: contains,
    );

    var res = await GetUserTransactionsUsecase(transactionRepository).call(params);

    if (res.isSuccess) {
      if (offset == null) {
        allTransactions = res.data ?? [];
      } else {
        allTransactions?.addAll(res.data ?? []);
      }
    } else {
      throw res.error?.message ?? 'Failed to load data';
    }

    isLoadingMore = false;
    notifyListeners();
  }

}
