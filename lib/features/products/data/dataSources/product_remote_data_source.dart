import 'package:http/http.dart' as http;
import 'package:mini_product_showcase_app/core/error/exception.dart';
import 'package:mini_product_showcase_app/core/secrets/secrets.dart';
import 'package:mini_product_showcase_app/features/products/data/models/product_model.dart';
import 'dart:convert';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl(this.client);

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await client.get(
        Uri.parse(Secrets.api),
      );

      if (response.statusCode == 200) {
        final List decoded = jsonDecode(response.body);

        return decoded.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw ServerException(error:  'Failed to load products {Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(error:  e.toString());
    }
  }
}
