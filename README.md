# 📰 my_news_app

A simple Flutter project that utilizes the [NewsAPI.org](https://newsapi.org) to display a list of news articles and their details.

Api is in thhis format
https://newsapi.org/v2/everything?q=microsoft&from=???&to=???&sortBy=
??? &page=1&pageSize=20&apiKey=YOUR_API_KEY

## 🚀 Getting Started

This project demonstrates a modular Flutter application following the **Clean Architecture** principles.

The format of list items follow this sequence:
1. Microsoft
2. Apple
3. Google
4. Tesla
5. Microsoft
6. Apple
7. and so on

## 🗐 Offline mode
To support offline mode, the app uses the **Repository Pattern**.

- **Stored in a local database** for offline access.
- **Fetched from the local DB first** when the network is unavailable.
- **Synced with the API** when the connection is available.

## 📦 Features & Architecture

- **Clean Architecture**
- **Modular Structure**
  - `data`
  - `utils`
  - `design_system`
  - `widgets`
- **State Management:** [Riverpod](https://riverpod.dev)
- **API Calls:** [Retrofit](https://pub.dev/packages/retrofit)
- **DI:** [Injectable](https://pub.dev/packages/injectable)
- **Database:** [Floor](https://pub.dev/packages/floor)

Each feature is organized into its own `data`, `domain`, and `presenter` layers.

## 🧱 Folder Structure

    lib/
    ├── features/
    │ └── news/
    │ ├───  data/
    │ ├───  domain/
    │ └───  presenter/
    libraries/
    ├── design_system/      # Assets files, colors, texts ...
    ├── utils/              # Tools and utilities
    ├── widgets/            # custom widgets
    ├── data/               # base data assentials