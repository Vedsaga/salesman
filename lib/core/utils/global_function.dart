import 'package:salesman/core/db/drift/app_database.dart';

class GlobalFunction {
  final List<ModelItemData> itemList;
  final List<ModelClientData> clientList;

  GlobalFunction({required this.itemList, required this.clientList});


  String? getClientName(int clientId) {
    for (var client in clientList) {
      if (client.clientId == clientId) {
        return client.clientName;
      }
    }
    return null;
  }

  String? getClientId(String clientName) {
    for (var client in clientList) {
      if (client.clientName == clientName) {
        return client.clientId.toString();
      }
    }
    return null;
  }

  ModelClientData? getClientDetails(int clientId) {
    for (var client in clientList) {
      if (client.clientId == clientId) {
        return client;
      }
    }
    return null;
  }

  String? getItemName(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item.itemName;
      }
    }
    return null;
  }

  String? getItemId(String itemName) {
    for (var item in itemList) {
      if (item.itemName == itemName) {
        return item.itemId.toString();
      }
    }
    return null;
  }

  double? getItemSellingPricePerUnit(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item.sellingPricePerUnit;
      }
    }
    return null;
  }

  double? getItemBuyingPricePerUnit(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item.buyingPricePerUnit;
      }
    }
    return null;
  }

  String? getItemUnit(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item.unit;
      }
    }
    return null;
  }

  double? getItemAvailable(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item.availableQuantity;
      }
    }
    return null;
  }

  ModelItemData? getItemDetails(int itemId) {
    for (var item in itemList) {
      if (item.itemId == itemId) {
        return item;
      }
    }
    return null;
  }
}
