import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class NetworkStatusSnackbar extends StatefulWidget {
  const NetworkStatusSnackbar({super.key});

  @override
  _NetworkStatusSnackbarState createState() => _NetworkStatusSnackbarState();
}

class _NetworkStatusSnackbarState extends State<NetworkStatusSnackbar> {
  @override
  void initState() {
    super.initState();
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        // Show snackbar when there is no network connection
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No Internet Connection'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This widget doesn't render anything
    return SizedBox.shrink();
  }
}
