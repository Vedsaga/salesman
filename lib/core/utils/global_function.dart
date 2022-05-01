// Project imports:
import 'package:salesman/core/db/drift/app_database.dart';

class GlobalFunction {
  final List<ModelItemData> itemList;
  final List<ModelClientData> clientList;

  GlobalFunction({ this.itemList = const [],  this.clientList = const []});


  String? getClientName(int clientId) {
    for (final client in clientList) {
      if (client.clientId == clientId) {
        return client.clientName;
      }
    }
    return null;
  }

  String? getClientId(String clientName) {
    for (final client in clientList) {
      if (client.clientName == clientName) {
        return client.clientId.toString();
      }
    }
    return null;
  }

  ModelClientData? getClientDetails(int clientId) {
    for (final client in clientList) {
      if (client.clientId == clientId) {
        return client;
      }
    }
    return null;
  }

  String? getItemName(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item.itemName;
      }
    }
    return null;
  }

  String? getItemId(String itemName) {
    for (final item in itemList) {
      if (item.itemName == itemName) {
        return item.itemId.toString();
      }
    }
    return null;
  }

  double? getItemSellingPricePerUnit(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item.sellingPricePerUnit;
      }
    }
    return null;
  }

  double? getItemBuyingPricePerUnit(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item.buyingPricePerUnit;
      }
    }
    return null;
  }

  String? getItemUnit(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item.unit;
      }
    }
    return null;
  }

  double? getItemAvailable(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item.availableQuantity;
      }
    }
    return null;
  }

  ModelItemData? getItemDetails(int itemId) {
    for (final item in itemList) {
      if (item.itemId == itemId) {
        return item;
      }
    }
    return null;
  }

  String computeTime(int remainingTime) {
    if (remainingTime > 0) {
      if (remainingTime > 604800) {
        return '${remainingTime ~/ 604800}w ${remainingTime % 604800 ~/ 86400}d ago';
      } else if (remainingTime > 86400) {
        return '${remainingTime ~/ 86400}d ${remainingTime % 86400 ~/ 3600}h ago';
      } else if (remainingTime > 3600) {
        return '${remainingTime ~/ 3600}h ${remainingTime % 3600 ~/ 60}m ago';
      } else if (remainingTime > 60) {
        return '${remainingTime ~/ 60}m ${remainingTime % 60}s ago';
      } else {
        return '${remainingTime}s ago';
      }
    } else {
      // if remainingTime > -60 then it is in the future.
      if (remainingTime > -60) {
        return 'in ${-remainingTime}s';
      } else if (remainingTime > -3600) {
        return 'in ${-remainingTime ~/ 60}m';
      } else if (remainingTime > -86400) {
        return 'in ${-remainingTime ~/ 3600}h';
      } else if (remainingTime > -604800) {
        return 'in ${-remainingTime ~/ 86400}d';
      } else {
        return 'in ${-remainingTime ~/ 604800}w';
      }
    }
  }
}
