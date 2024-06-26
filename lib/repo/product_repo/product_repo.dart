import 'package:inventory_management_app/core/db/const/sql_table_const.dart';
import 'package:inventory_management_app/core/db/database_interface.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/repo/product_repo/product_entity.dart';
import 'package:sqflite/sqflite.dart';

class SqlProductRepo extends sqliteRepo<Product, ProductParams> {
  SqlProductRepo(DataStore<Database> store)
      : super.SqliteRepo(store, Product.fromJson, productTb);
  @override
  // TODO: implement refQuery
  String get refQuery {
    return '''
        select "$tableName".*,"$categoriesTb".name as category_name,
        "$categoriesTb"."created_at" as category_created_at,"$categoriesTb"."updated_at" as category_updated_at
        from "$tableName" 
        join "$categoriesTb" on "$categoriesTb"."id"="$tableName"."category_id" 
    ''';
  }
}
