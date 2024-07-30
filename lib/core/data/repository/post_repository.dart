import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:traveling/core/data/models/common_response.dart';
import 'package:traveling/core/data/models/post_model.dart';
import 'package:traveling/core/data/models/post_photo_model.dart';
import 'package:traveling/core/data/network/network_config.dart';
import 'package:traveling/core/enums/request_type.dart';
import 'package:traveling/core/utils/network_util.dart';

class PostRepository {
  PostRepository();
  Future<Either<String, List<PostModel>>> getAllPost() async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.GET,
          route: 'Posts',
          headers: NetworkConfig.getHeaders(
            type: RequestType.GET,
            needAuth: true,
            extraHeaders: {"timeZone": "+03", "language": "ar"},
          )).then((value) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          List<PostModel> result = [];

          commonResponse.data!.forEach(
            (element) {
              result.add(PostModel.fromJson(element));
            },
          );

          //! return Right(commonResponse.data!
          // !    .map<PostModel>((item) => PostModel.fromJson(item))
          // !    .toList());

          return Right(result);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PostPhotoModel>>> getAllPostPhoto({
    required int postId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'albums/${postId}/photos',
      ).then((value) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          List<PostPhotoModel> result = [];

          commonResponse.data!.forEach(
            (element) {
              result.add(PostPhotoModel.fromJson(element));
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

  Future<Either<String, PostModel>> createPost({
    required String title,
    required String body,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'posts',
        body: {
          "title": title,
          "body": body,
          "userId": '1',
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(PostModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, PostModel>> updatePost(
      {required String title, required String body, required int id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PUT,
        headers: NetworkConfig.getHeaders(
            type: RequestType.POST, extraHeaders: {"key1": "value1"}),
        route: 'posts/${id}',
        body: {
          "title": title,
          "body": body,
          "userId": '1',
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(PostModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deletePost({required int id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        route: 'posts/${id}',
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
