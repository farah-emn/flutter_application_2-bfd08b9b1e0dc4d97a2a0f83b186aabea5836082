// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';

// enum ConnectivityStatus {
//   ONLINE,
//   OFFLINE,
// }

// class ConnectivityService {
//   StreamController<ConnectivityStatus> connectivityStatusController =
//       StreamController<ConnectivityStatus>();

//   ConnectivityService()  {
//     Connectivity connectivity = Connectivity();
//     //!--- Here to listen connection status
//     connectivity.onConnectivityChanged.listen((event) {
//       //?--- Here to add new connection status
//       connectivityStatusController.add(getStauts(event));
//     });
//   }

  

//   ConnectivityStatus getStauts(ConnectivityResult result) {
//     switch (result) {
//       case ConnectivityResult.bluetooth:
//         return ConnectivityStatus.ONLINE;
//       case ConnectivityResult.wifi:
//         return ConnectivityStatus.ONLINE;
//       case ConnectivityResult.ethernet:
//         return ConnectivityStatus.ONLINE;
//       case ConnectivityResult.mobile:
//         return ConnectivityStatus.ONLINE;
//       case ConnectivityResult.none:
//         return ConnectivityStatus.OFFLINE;
//       case ConnectivityResult.vpn:
//         return ConnectivityStatus.ONLINE;
//       case ConnectivityResult.other:
//         return ConnectivityStatus.ONLINE;
//     }
//   }
// }
