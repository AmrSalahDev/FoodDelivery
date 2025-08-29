
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

## 📊 App Architecture (Mermaid.js)

```mermaid
flowchart TB
    %% External Dependencies
    subgraph "External Systems" 
        direction TB
        RESTAPI["Restaurant Backend"]:::external
        PaymentAPI["Payment Gateway"]:::external
        MapsAPI["Maps API"]:::external
    end

    %% Core Services
    subgraph "Core Services" 
        direction TB
        AuthService["AuthService"]:::core
        LocationService["LocationService"]:::core
        ToastService["ToastService"]:::core
    end

    %% Domain Layer
    subgraph "Domain Layer" 
        direction TB
        LoginUseCase["LoginUseCase"]:::domain
        RegisterUseCase["RegisterUseCase"]:::domain
    end

    %% Data Layer
    subgraph "Data Layer" 
        direction TB
        LoginRepoImpl["LoginRepoImpl"]:::data
        RegisterRepoImpl["RegisterRepoImpl"]:::data
        HTTPClient["HTTP Client"]:::data
    end

    %% Presentation Layer
    subgraph "Presentation Layer" 
        direction TB
        subgraph OnboardingFeature
            direction TB
            OnboardingScreen["OnBoardingScreen"]:::presentation
        end
        subgraph LoginFeature
            direction TB
            LoginScreen["LoginScreen"]:::presentation
            LoginCubit["LoginCubit"]:::presentation
        end
        subgraph RegisterFeature
            direction TB
            RegisterScreen["RegisterScreen"]:::presentation
            RegisterCubit["RegisterCubit"]:::presentation
        end
        subgraph HomeFeature
            direction TB
            HomeScreen["HomeScreen"]:::presentation
        end
    end

    %% Routing & DI
    subgraph "App Initialization"
        direction TB
        AppEntry["main.dart"]:::core
        DIContainer["DI Container (di.dart, di.config.dart)"]:::core
        AppRouter["AppRouter (go_router)"]:::core
    end

    %% Platform & Engine
    subgraph "Flutter Engine & Platform Channels"
        direction TB
        Platform["Android/iOS/Web/Linux/macOS/Windows"]:::platform
    end

    %% Relationships
    Platform -->|"launches"| AppEntry
    AppEntry -->|"initializes"| DIContainer
    DIContainer --> AuthService
    DIContainer --> LocationService
    DIContainer --> ToastService
    DIContainer --> LoginUseCase
    DIContainer --> RegisterUseCase
    DIContainer --> LoginRepoImpl
    DIContainer --> RegisterRepoImpl
    DIContainer --> AppRouter

    %% Presentation to Domain
    LoginScreen -->|"dispatch event"| LoginCubit
    LoginCubit -->|"executes"| LoginUseCase
    RegisterScreen -->|"dispatch event"| RegisterCubit
    RegisterCubit -->|"executes"| RegisterUseCase

    %% Domain to Data
    LoginUseCase -->|"calls"| LoginRepoImpl
    RegisterUseCase -->|"calls"| RegisterRepoImpl

    %% Data to External & Core Services
    LoginRepoImpl -->|"HTTP calls"| HTTPClient
    RegisterRepoImpl -->|"HTTP calls"| HTTPClient
    HTTPClient --> RESTAPI
    HTTPClient --> PaymentAPI
    LocationService --> MapsAPI

    %% Routing
    AppRouter --> OnboardingScreen
    AppRouter --> LoginScreen
    AppRouter --> RegisterScreen
    AppRouter --> HomeScreen

    %% Toast Notifications
    ToastService --> LoginScreen
    ToastService --> RegisterScreen

    %% Styles
    classDef presentation fill:#ADD8E6,stroke:#333,stroke-width:1px
    classDef domain fill:#90EE90,stroke:#333,stroke-width:1px
    classDef data fill:#FFA500,stroke:#333,stroke-width:1px
    classDef core fill:#D3D3D3,stroke:#333,stroke-width:1px
    classDef external fill:#FF6347,stroke:#333,stroke-width:1px
    classDef platform fill:#D3D3D3,stroke:#333,stroke-width:1px


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
