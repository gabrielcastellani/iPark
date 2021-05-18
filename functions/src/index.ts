import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import {
  CieloConstructor,
  Cielo,
  TransactionCreditCardRequestModel,
  EnumBrands,
  CancelTransactionRequestModel,
  CaptureRequestModel} from "cielo";

admin.initializeApp(functions.config().firebase);

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

const merchantId = functions.config().cielo.merchantid;
const merchantKey = functions.config().cielo.merchantkey;

const cieloParams: CieloConstructor = {
  merchantId: merchantId,
  merchantKey: merchantKey,
  sandbox: true,
  debug: true,
};

const cielo = new Cielo(cieloParams);

export const authorizeCC = functions.https.onCall(async (data, context) => {
  if (data === null) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "menssage": "Dados não informados",
      },
    };
  }

  if (!context.auth) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "menssage": "Nenhum usuário logado",
      },
    };
  }

  // const userId = context.auth?.uid;
  // const snapshot = await admin.firestore()
  // .collection('profiles').where('id', "==", userId).get();
  // const userData = snapshot.docs[0];

  console.log("Iniciando autoriazação");

  let brand: EnumBrands;
  switch (data.creditCard.brand) {
    case "VISA":
      brand = EnumBrands.VISA;
      break;
    case "MASTERCARD":
      brand = EnumBrands.MASTER;
      break;
    default:
      return {
        "success": false,
        "error": {
          "code": -1,
          "menssage": "Cartão não suportado",
        },
      };
  }

  const saleData: TransactionCreditCardRequestModel = {
    merchantOrderId: data.merchantOrderId,
    customer: {
      name: "Gabriel Castellani",
      identity: "08285548970",
      identityType: "CPF",
      email: "gabrielcastellanioliveira@gmail.com",
      deliveryAddress: {
        street: "Rua Joaquim Moser",
        number: "285",
        complement: "Casa",
        zipCode: "89042040",
        city: "Blumenau",
        state: "Santa Catarina",
        country: "BRA",
        district: "",
      },
    },
    payment: {
      currency: "BRL",
      country: "BRA",
      amount: data.amount,
      installments: data.installments,
      softDescriptor: data.softDescriptor.substring(0, 13),
      type: data.paymentType,
      capture: false,
      creditCard: {
        cardNumber: data.creditCard.cardNumber,
        holder: data.creditCard.holder,
        expirationDate: data.creditCard.expirationDate,
        securityCode: data.creditCard.securityCode,
        brand: brand,
      },
    },
  };

  try {
    const transaction = await cielo.creditCard.transaction(saleData);

    if (transaction.payment.status === 1) {
      return {
        "success": true,
        "paymentId": transaction.payment.paymentId,
      };
    } else {
      let message = "";
      switch (transaction.payment.returnCode) {
        case "5":
          message = "Não Autorizada";
          break;
        case "57":
          message = "Cartão expirado";
          break;
        case "78":
          message = "Cartão bloqueado";
          break;
        case "99":
          message = "Timeout";
          break;
        case "77":
          message = "Cartão cancelado";
          break;
        case "70":
          message = "Problemas com o cartão de crédito";
          break;
        default:
          message = transaction.payment.returnMessage;
          break;
      }

      return {
        "success": false,
        "status": transaction.payment.status,
        "error": {
          "code": transaction.payment.returnCode,
          "message": message,
        },
      };
    }
  } catch (error) {
    return {
      "success": false,
      "error": {
        "code": error.response[0].Code,
        "message": error.response[0].Message,
      },
    };
  }
});

export const captureCC = functions.https.onCall(async (data, context) => {
  if (data === null) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Dados não informados",
      },
    };
  }

  if (!context.auth) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Nenhum usuário logado",
      },
    };
  }

  const captureParams: CaptureRequestModel = {
    paymentId: data.payId,
  };

  try {
    const capture = await cielo
        .creditCard
        .captureSaleTransaction(captureParams);

    if (capture.status === 2) {
      return {"success": true};
    } else {
      return {
        "success": false,
        "status": capture.status,
        "error": {
          "code": capture.returnCode,
          "message": capture.returnMessage,
        },
      };
    }
  } catch (error) {
    return {
      "success": false,
      "error": {
        "code": error.response[0].Code,
        "message": error.response[0].message,
      },
    };
  }
});

export const cancelCC = functions.https.onCall(async (data, context) => {
  if (data === null) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Dados não informados",
      },
    };
  }

  if (!context.auth) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Nenhum usuário logado",
      },
    };
  }

  const cancelParams: CancelTransactionRequestModel = {
    paymentId: data.payId,
  };

  try {
    const cancel = await cielo.creditCard.cancelTransaction(cancelParams);

    if (cancel.status === 10 || cancel.status === 11) {
      return {"success": true};
    } else {
      return {
        "success": false,
        "status": cancel.status,
        "error": {
          "code": cancel.returnCode,
          "message": cancel.returnMessage,
        },
      };
    }
  } catch (error) {
    return {
      "success": false,
      "error": {
        "code": error.response[0].Code,
        "message": error.response[0].message,
      },
    };
  }
});
