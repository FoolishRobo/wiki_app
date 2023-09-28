import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  Future<bool> isUserConnectedToInternet() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Stream<bool> getStreamOfInternetConnection() {
    return Connectivity().onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.none) {
        return false;
      }
      return true;
    });
  }
}
