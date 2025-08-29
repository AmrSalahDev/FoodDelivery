
## ✨ Badges

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android-blue.svg?style=for-the-badge)
![State Management: Bloc](https://img.shields.io/badge/State%20Management-Bloc-purple.svg?style=for-the-badge)

---

## 🍔 Food Delivery App

A modern Food Delivery App built with Flutter. The app provides an intuitive UI and seamless experience for browsing restaurants, selecting meals, and placing orders.
---

## 📑 Table of Contents
- [✨ Badges](#-badges)
- [🍔 Food Delivery App](#-food-delivery-app)
- [🚀 Features](#-features)
- [🚀 Getting Started](#-getting-started)
- [📦 Dependencies Used](#-dependencies-used)
- [🎨 Figma Design](#-figma-design)
- [📸 Screenshots](#-screenshots)
- [🎥 Demo](#-demo)
- [🛠️ Contributions](#️-contributions)
- [📜 License](#-license)

---

## 🚀 Features

- 📱 **Beautiful UI** with responsive design  
- 🍕 **Browse Restaurants & Menus** with images and categories  
- 🛒 **Cart Management** – add, remove, and update items  
- 💳 **Checkout & Payment Flow** (dummy integration for demo)  
- 🔔 **Order Tracking** with live updates  
- 👤 **User Authentication** (Sign up & login)  
- 🌙 **Dark/Light Theme Support**

---

## 📊 App Architecture

![App Architecture](screenshots/diagram.png)

---

### 🚀 Getting Started

To run this app locally:

```bash
git clone https://github.com/AmrSalahDev/FoodDelivery.git
cd FoodDelivery
flutter pub get
flutter run
```

---

## 📦 Dependencies Used  

Below is a list of packages used in this Flutter project along with their versions:  

### 🚀 Core  
- `flutter` – Flutter SDK  
- `cupertino_icons: ^1.0.8` – iOS-style icons  

### 📦 State Management  
- `flutter_bloc: ^9.1.1` – Bloc/Cubit pattern for managing app state  
- `equatable: ^2.0.7` – Simplifies equality comparisons  

### 🎨 UI & Animations  
- `go_transitions: ^0.8.2` – Smooth navigation animations  
- `carousel_slider: ^5.1.1` – Create product/image sliders  
- `toastification: ^3.0.3` – Beautiful toast notifications  

### 🔄 Routing  
- `go_router: ^16.1.0` – Declarative navigation & routing  

### ⚡ Utilities & Helpers  
- `uuid: ^4.5.1` – Generate unique IDs  
- `faker: ^2.2.0` – Generate fake/dummy data for testing  

### 📱 Native Features  
- `flutter_native_splash: ^2.4.6` – Configure a native splash screen  

---


### 🎨 Figma Design

Here’s the app UI design created in Figma:

[![Figma Design](screenshots/figma_thumbnail.png)](https://www.figma.com/community/file/1436702392024339380/grabber-grocrey-app)

📌 Click the image to view the live Figma prototype.



---

### 📸 Screenshots

<p float="left">
  <img src="screenshots/splash_screen.png" width="45%"/>
  <img src="screenshots/home_screen.png" width="45%"/>
  <img src="screenshots/cart_screen.png" width="45%"/>
  <img src="screenshots/payment_screen.png" width="45%"/>
  <img src="screenshots/checkout_screen.png" width="45%"/>
  <img src="screenshots/order_track_screen.png" width="45%"/>
</p>


---

### 🛠️ Contributions

Feel free to fork the repo, open issues, or submit PRs to improve the app!
