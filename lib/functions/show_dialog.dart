part of 'functions.dart';

void showDisconnectDialog(BuildContext context, VoidCallback onConfirm) {
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
              onConfirm();
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

void showDisconnectConfirmation(
    BuildContext context, VoidCallback onConfirm, VoidCallback onDisconnect) {
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
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
              onDisconnect();
            },
            child: const Text('Disconnect'),
          ),
        ],
      );
    },
  );
}
