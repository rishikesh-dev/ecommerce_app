# 🛍️ E-Commerce App

A modern **Flutter e-commerce application** built with clean architecture, BLoC state management, and Firebase.  
The app provides a full shopping experience with cart, checkout, payment integration, and category-based browsing.

---

## ✨ Features

- 📱 **Cross-platform**: Runs on Android & iOS with a single Flutter codebase.
- 🛒 **Product Management**: Browse products by categories.
- 🔍 **Search**: Search products instantly with BLoC-powered search.
- 🛍️ **Cart**: Add, update, and remove products from cart.
- 🚚 **Checkout**:
  - Address management (add, update, default).
  - Order summary and total calculation.
- 💳 **Payments**:
  - Cash on Delivery (COD).
  - Razorpay integration for online payments.
- 🔔 **Push Notifications** with Firebase Cloud Messaging (FCM).
- ⚡ **State Management**: Powered by `flutter_bloc`.
- ☁️ **Backend**: Firebase Authentication & Firestore.

---

## 🏗️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [Bloc](https://pub.dev/packages/flutter_bloc)
- **Backend**: [Firebase Auth](https://firebase.google.com/docs/auth), [Cloud Firestore](https://firebase.google.com/docs/firestore)
- **Payments**: [Razorpay](https://razorpay.com/docs/payments/payment-gateway/flutter-integration/standard/)
- **Push Notifications**: [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging)

---

## 📸 Screenshots

| Home | Search | Cart | Checkout |
|------|--------|------|----------|
| ![](screenshots/home.png) | ![](screenshots/search.png) | ![](screenshots/cart.png) | ![](screenshots/checkout.png) |

*(Add your own screenshots in the `/screenshots` folder and update paths.)*

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/rishikesh-dev/ecommerce_app.git
cd ecommerce_app
