import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/db/interface/crud_model.dart';

abstract class DatabaseCrud<D, M, MP extends DatabaseModel> {
  final DataStore<D> store;
  D get database => store.database!;
  final String tableName;
  DatabaseCrud({required this.tableName, required this.store});
  Future<List<M>?> find([int? limit = 0, int? offset = 0]);
  Future<M?> get(int id);
  Future<M?> create(MP value);
  Future<M?> update(int id, MP value);
  Future<M?> delete();
}
