import 'package:get/get.dart';

class InvoiceController extends GetxController {
  @override
  onInit() {
    productsDropDownValue.value = invoiceProductList[0]['name'].toString();
    contactDropdown.value = contactList[0]['name'].toString();
    updateNewProduct();
  }

  var contactDropdown = ''.obs;

  var contactIndex = 0.obs;

  var contactSelected = false.obs;

  updateContactIndex() {
    for (var i = 0; i < contactList.length; i++) {
      if (contactDropdown.value == contactList[i]['name']) {
        contactIndex.value = i;
      }
    }
  }

  var userInfo = {
    "companyName": "Company1",
    "email": 'company1@dummyemail.com',
    "phone": '123456789',
    "address": 'address 1',
    "country": 'United Kingdom'
  }.obs;

  var contactList = [
    {
      "name": "Person 1",
      "email": "person@gmail.com",
      "phone": "0987654321",
      "address": "Palam galli 16"
    },
    {
      "name": "Person1 Returns",
      "email": "person1@gmail.com",
      "phone": "0987654321",
      "address": "Palam galli 16"
    },
  ].obs;

  var invoiceList = [
    {
      "name": "Person1",
      "amount": 30,
      "invoiceNumber": "STA-0001",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Person1",
      "amount": 40,
      "invoiceNumber": "STA-0002",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Person1",
      "amount": 50,
      "invoiceNumber": "STA-0003",
      "due": "due 7 days ago",
      "status": "unpaid",
    },
    {
      "name": "Person1",
      "amount": 50,
      "invoiceNumber": "STA-0006",
      "due": "due 7 days ago",
      "status": "paid",
    },
    {
      "name": "Person1",
      "amount": 100,
      "invoiceNumber": "STA-0004",
      "due": "due 7 days ago",
      "status": "draft",
    },
    {
      "name": "Person1",
      "amount": 80,
      "invoiceNumber": "STA-0005",
      "due": "due 7 days ago",
      "status": "draft",
    },
  ].obs;

  var invoiceProductList = [
    {
      "name": "Product 1",
      "amount": 80,
      "description":
          "This is the Description of the product and related Information",
    },
    {
      "name": "Product 2",
      "amount": 100,
      "description":
          "This is the Description of the product and related Information",
    },
  ].obs;

  var searchInvoice = [].obs;

  var productsDropDownValue = ''.obs;
  var productUnitPrice = 0.00;

  ////////  Create Invoice Temp Variables  /////////
  ///
  Map newInvoice = {
    "invoiceNumber": '',
    "posoNumber": '',
    'issueDate': '',
    'dueDate': '',
    'products': []
  }.obs;

  var issueDate = ''.obs;
  var dueDate = ''.obs;

  Map newProductMap = {}.obs;

  var newProductQuantity = 1.obs;

  var subTotal = 0.0.obs;

  var discount = 0.0.obs;

  var percentDollar = true.obs;

  addQuantity() {
    newProductQuantity++;
    updateNewProduct();
  }

  reduceQuantity() {
    if (newProductQuantity == 1) {
    } else {
      newProductQuantity - 1;
      updateNewProduct();
    }
  }

  calculateSubtotal() {
    double temp = 0;
    for (var i = 0; i < newInvoice['products'].length; i++) {
      temp = temp + newInvoice['products'][i]['total'];
    }
    subTotal.value = temp;
  }

  removeProduct(int index) {
    List tempList = newInvoice['products'];
    tempList.removeAt(index);
    newInvoice['products'] = tempList;
    if (tempList.length == 0) {
      discount.value = 0.0;
    }
  }

  updateNewProduct() {
    String productName = productsDropDownValue.toString();
    newProductMap = {
      'productName': productName,
      'unitPrice': calculateProductAmount(),
      'quantity': newProductQuantity,
      'total': calculateTotal(int.parse(newProductQuantity.toString()))
    };
  }

  addProductToInvoice() {
    var temp = newInvoice['products'];
    temp.add(newProductMap);
    newInvoice['products'] = temp;
  }

  calculateTotal(int quantity) {
    for (int i = 0; i < invoiceProductList.length; i++) {
      if (productsDropDownValue == invoiceProductList[i]['name']) {
        return calculateProductAmount() * quantity;
      }
    }
  }

  calculateProductAmount() {
    for (int i = 0; i < invoiceProductList.length; i++) {
      if (productsDropDownValue == invoiceProductList[i]['name']) {
        return invoiceProductList[i]['amount'];
      }
    }
  }

  ////////////////////////////////////////////////

  searchInvoiceFunction(String query) {
    if (query == '') {
      searchInvoice.value = invoiceList;
    } else {
      searchInvoice.value = [];
      for (int i = 0; i < invoiceList.length; i++) {
        if (invoiceList[i]['invoiceNumber']
                .toString()
                .contains(query.toLowerCase()) ||
            invoiceList[i]['invoiceNumber']
                .toString()
                .contains(query.toUpperCase()) ||
            invoiceList[i]['name'].toString().contains(query.toLowerCase()) ||
            invoiceList[i]['name'].toString().contains(query.toUpperCase())) {
          searchInvoice.add(invoiceList[i]);
        }
      }
    }
  }

  var searchInvoiceProduct = [].obs;

  searchInvoiceProductFunction(String query) {
    if (query == '') {
      searchInvoiceProduct.value = invoiceProductList;
    } else {
      searchInvoiceProduct.value = [];
      for (int i = 0; i < invoiceProductList.length; i++) {
        if (invoiceProductList[i]['description']
                .toString()
                .contains(query.toLowerCase()) ||
            invoiceProductList[i]['description']
                .toString()
                .contains(query.toUpperCase()) ||
            invoiceProductList[i]['name']
                .toString()
                .contains(query.toLowerCase()) ||
            invoiceProductList[i]['name']
                .toString()
                .contains(query.toUpperCase())) {
          searchInvoiceProduct.add(invoiceProductList[i]);
        }
      }
    }
  }

  addInvoice() {
    invoiceList.add({
      "name": "Person1",
      "amount": 30,
      "invoiceNumber": "STA-0001",
      "due": "due 7 days ago",
      "status": "unpaid",
    });
  }

  addProduct() {
    invoiceProductList.add({
      "name": "Product 2",
      "amount": 100,
      "description":
          "This is the Description of the product and related Information",
    });
  }
}
