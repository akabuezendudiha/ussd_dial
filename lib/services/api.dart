import 'package:ussd_dial/helpers/apiExceptionMapper.dart';
import 'package:ussd_dial/helpers/apiHelper.dart';

class ApiService extends ApiBaseHelper {

  Future<String> loadVoucher(String cellNumber, String voucher) async {
    try {
      Map<String, dynamic> voucherRequest = {
        'cell': cellNumber,
        'voucher': voucher,
      };
      var response = await post(url: 'voucher/recharge', body: voucherRequest);
      return response['message'];
    } on Exception catch (e) {
      print(e);
      return ApiExceptionMapper.toErrorMessage(e);
    }
  }

}
