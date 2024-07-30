import 'package:dartz/dartz.dart';
import 'package:traveling/core/data/models/common_response.dart';
import 'package:traveling/core/data/models/token_info.dart';
import 'package:traveling/core/data/network/network_config.dart';
import 'package:traveling/core/enums/request_type.dart';
import 'package:traveling/core/utils/network_util.dart';

class AuthRepository {
  Future<Either<String, TokenInfo>> login({
    required String username,
    required String password,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'auth/login',
        headers: NetworkConfig.getHeaders(type: RequestType.POST),
        body: {
          'username': username,
          'password': password,
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(TokenInfo.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
