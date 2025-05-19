# 📰 my_news_app

A simple Flutter project that utilizes the [NewsAPI.org](https://newsapi.org) to display a list of news articles and their details.

## 🚀 Getting Started

This project demonstrates a modular Flutter application following the **Clean Architecture** principles.

## 📦 Features & Architecture

- **Clean Architecture**
- **Modular Structure**
  - `data`
  - `utils`
  - `design_system`
  - `widgets`
- **State Management:** [Riverpod](https://riverpod.dev)
- **API Calls:** [Retrofit](https://pub.dev/packages/retrofit)
- **Injectable:** [Riverpod](https://pub.dev/packages/injectable)

Each feature is organized into its own `data`, `domain`, and `presenter` layers.

## 🧱 Folder Structure

lib/
├── features/
│ └── news/
│ ├───  data/
│ ├───  domain/
│ └───  presenter/
libraries/
├── design_system/
├── utils/
├── widgets/
├── data/