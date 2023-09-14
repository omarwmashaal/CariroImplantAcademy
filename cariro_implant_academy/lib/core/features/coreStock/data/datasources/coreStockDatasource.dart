import '../../../../Http/httpRepo.dart';
import '../../../../constants/remoteConstants.dart';
import '../../../../error/exception.dart';
import '../../../../useCases/useCases.dart';

abstract class CoreStockDatasource{
  Future<NoParams> consumeItemById(int id,int count);
  Future<NoParams> consumeItemByName(String name,int count);
}

class CoreStockDatasourceImpl implements CoreStockDatasource{
  final HttpRepo httpRepo;
  CoreStockDatasourceImpl({required this.httpRepo});
  @override
  Future<NoParams> consumeItemById(int id, int count)async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$stockController/ConsumeItem?id=$id&count=$count");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    return NoParams();
  }

  @override
  Future<NoParams> consumeItemByName(String name, int count) async {
    late StandardHttpResponse response;
    try {
      response = await httpRepo.post(host: "$serverHost/$stockController/ConsumeItemByName?name=$name&count=$count");
    } catch (e) {
      throw mapException(e);
    }
    if (response.statusCode != 200) throw getHttpException(statusCode: response.statusCode);
    return NoParams();
  }

}