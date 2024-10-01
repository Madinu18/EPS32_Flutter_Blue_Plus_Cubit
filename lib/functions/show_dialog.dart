part of 'functions.dart';

void showDisconnectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Device Disconnected'),
        content: const Text(
            'The device has been disconnected. The stream has been stopped'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(color: Colors.blue),),
          ),
        ],
      );
    },
  );
}

void showDisconnectConfirmation(
    BuildContext context, VoidCallback onDisconnect) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Disconnect'),
        content: const Text(
            'Are you sure you want to disconnect the device? The stream will be stop.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: Colors.blue),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDisconnect();
            },
            child: const Text('Disconnect', style: TextStyle(color: Colors.red),),
          ),
        ],
      );
    },
  );
}

void showLoadingPopup(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
          child: LoadingAnimationWidget.prograssiveDots(
              color: Colors.white, size: 70)));
}

void showFailedToConnectDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Device Disconnected'),
        content: const Text(
            'Failed to connect the Device please try again.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK', style: TextStyle(color: Colors.blue),),
          ),
        ],
      );
    },
  );
}