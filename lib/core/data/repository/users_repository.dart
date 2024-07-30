import 'package:dartz/dartz.dart';
import 'package:traveling/core/data/models/common_response.dart';
import 'package:traveling/core/data/models/user_info.dart';
import 'package:traveling/core/enums/request_type.dart';
import 'package:traveling/core/utils/network_util.dart';




class UserRepository {
  Future<Either<String, List<UserInfo>>> getAllUser() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'users',
      ).then((value) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          List<UserInfo> result = [];

          commonResponse.data!.forEach(
            (element) {
              result.add(UserInfo.fromJson(element));
            },
          );
          return Right(result);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
