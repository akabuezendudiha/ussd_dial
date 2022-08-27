import 'dart:convert';

import 'package:ussd_dial/utils/exceptions.dart';

abstract class ApiExceptionMapper {
  static String toErrorMessage(Object error) { 
    String unknownError = 'Unknown error has occurred. Please try again later.';
    if (error is ApiException) { 
      String reason = error.errorDetail.contains('"message"')
          ? json.decode(error.errorDetail)['message']
          : error.errorDetail;
      return reason; 
    } else {
      return unknownError;
    }
  }
}
