
class CommonResponse<T> {
  int? statusCode;
  late String message;
  T? data;

 // CommonResponse(this.data, this.message, this.statusCode);

  CommonResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];

    if (getStatus) {
      data = json['response'];
    } else {
      if (json['response']['message'].toString().isNotEmpty) {
        message = json['response']['message'];
      } else {
        switch (statusCode) {
          case 400:
            message = '400 bad request';
            break;

          default:
            message = 'Something went wrong';
            break;
        }
      }
    }
  }

  bool get getStatus => statusCode.toString().startsWith('2');

  // bool getStatus() {
  //   return statusCode.toString().startsWith('2');
  // }

//   CommonResponse getCommonRespons(Map<String, dynamic> json) {
//     return CommonResponse(
//         json['response'], json['response']['message'], json['statusCode']);
//   }
}
