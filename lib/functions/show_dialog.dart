part of 'functions.dart';

void showDisconnectDialog(BuildContext context, VoidCallback onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Device Disconnected'),
        content: const Text('The device has been disconnected.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
            child: const Text('OK'),
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
        content: const Text('Are you sure you want to disconnect the device?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onDisconnect();
              Navigator.of(context).pop();
            },
            child: const Text('Disconnect'),
          ),
        ],
      );
    },
  );
}
