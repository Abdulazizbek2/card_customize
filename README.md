# card_customiz# Card Customization App

Flutter приложение для кастомизации платежных карт с использованием Clean Architecture, Feature-First стру# Card Customization App

Flutter приложение для кастомизации банковских карт с использованием Clean Architecture, BLoC pattern и feature-first структуры.

## Функциональность

### ✅ Реализованные возможности:
- **Фон карты**: Выбор цвета, градиента или изображения из галереи
- **Масштабирование изображения**: Pinch-to-zoom и перетаскивание изображения
- **Эффект размытия**: Настраиваемое размытие фона с ползунком
- **Сохранение**: Отправка данных на сервер через multipart запрос
- **Clean Architecture**: Разделение на слои Domain, Data, Presentation
- **BLoC Pattern**: Управление состоянием через BLoC
- **Feature-first структура**: Организация кода по функциональности

### 🎨 Кастомизация карты:
1. **Фон**:
   - Выбор из предустановленных цветов
   - Создание пользовательских цветов
   - Выбор из предустановленных градиентов
   - Загрузка изображения из галереи

2. **Изображение**:
   - Масштабирование жестами (pinch-to-zoom)
   - Перетаскивание для позиционирования
   - Ползунок для точного масштабирования

3. **Эффекты**:
   - Настраиваемое размытие (0-10)
   - Плавные переходы между режимами

4. **Сохранение**:
   - Отправка всех настроек на сервер
   - Сжатие изображений
   - Multipart upload

## Архитектура

```
lib/
├── core/                          # Базовые компоненты
│   ├── constants/                 # Константы приложения
│   ├── error/                     # Обработка ошибок
│   ├── network/                   # HTTP клиент
│   └── utils/                     # Утилиты
├── features/                      # Функциональности
│   └── card_customization/        # Кастомизация карт
│       ├── data/                  # Слой данных
│       │   ├── datasources/       # Источники данных
│       │   ├── models/            # Модели данных
│       │   └── repositories/      # Реализация репозиториев
│       ├── domain/                # Бизнес-логика
│       │   ├── entities/          # Сущности
│       │   ├── repositories/      # Интерфейсы репозиториев
│       │   └── usecases/          # Use cases
│       └── presentation/          # UI слой
│           ├── bloc/              # BLoC
│           ├── pages/             # Страницы
│           └── widgets/           # Виджеты
├── injection_container.dart       # Dependency Injection
└── main.dart                     # Точка входа
```

## Технологический стек

- **Flutter**: UI фреймворк
- **flutter_bloc**: Управление состоянием
- **get_it**: Dependency Injection
- **dartz**: Functional programming (Either)
- **equatable**: Сравнение объектов
- **image_picker**: Выбор изображений
- **flutter_colorpicker**: Выбор цветов
- **http**: HTTP запросы

## Запуск проекта

1. Убедитесь, что Flutter установлен
2. Установите зависимости:
   ```bash
   flutter pub get
   ```
3. Запустите приложение:
   ```bash
   flutter run
   ```

## Использование

1. **Выбор фона**: Используйте вкладки "Colors" и "Images" для настройки фона карты
2. **Настройка изображения**: Если выбрано изображение, используйте жесты для масштабирования и позиционирования
3. **Применение эффектов**: Во вкладке "Controls" настройте размытие и точное масштабирование
4. **Сохранение**: Нажмите "Save Card" для отправки настроек на сервер

## Особенности реализации

- **Чистая архитектура** с разделением ответственности
- **BLoC pattern** для управления состоянием
- **Dependency Injection** через GetIt
- **Error handling** с использованием Either<Failure, Success>
- **Responsive UI** с адаптивной версткой
- **Gesture handling** для интерактивного управления изображениями pattern.

## Функциональность

### Основные возможности:
- ✅ **Настройка фонового изображения карты**: Пользователь может выбрать изображение из галереи устройства или выбрать из предустановленных изображений
- ✅ **Масштабирование и позиционирование**: Пользователь может масштабировать фоновое изображение с помощью жестов pinch zoom или перетаскивать его внутри карты
- ✅ **Случайное изображение по умолчанию**: По умолчанию выбирается одно из предустановленных изображений случайным образом
- ✅ **Настройка фонового цвета/градиента**: Пользователь может выбрать фоновый цвет или градиент с помощью color picker
- ✅ **Эксклюзивный выбор**: Пользователь может выбрать только фоновое изображение ИЛИ цвет одновременно
- ✅ **Blur overlay**: Возможность настройки размытия с регулируемой степенью
- ✅ **Сохранение**: При нажатии кнопки 'Save' все изменения (изображение/цвет/градиент, степень размытия) отправляются на сервер (mock)
- ✅ **Multipart отправка**: Все данные отправляются multipart методом, изображения сжимаются
- ✅ **BLoC pattern**: Использует BLoC для управления состоянием
- ✅ **Официальные пакеты**: Используются только официальные Flutter пакеты (кроме библиотеки color picker)

## Архитектура

### Clean Architecture + Feature-First Structure

```
lib/
├── core/                           # Общие компоненты
│   ├── constants/                  # Константы приложения
│   ├── error/                      # Обработка ошибок
│   ├── network/                    # Сетевые утилиты
│   └── utils/                      # Утилиты
├── features/                       # Функции приложения
│   └── card_customization/         # Функция кастомизации карт
│       ├── data/                   # Слой данных
│       │   ├── datasources/        # Источники данных
│       │   ├── models/             # Модели данных
│       │   └── repositories/       # Реализация репозиториев
│       ├── domain/                 # Бизнес логика
│       │   ├── entities/           # Сущности
│       │   ├── repositories/       # Абстракции репозиториев
│       │   └── usecases/           # Случаи использования
│       └── presentation/           # Слой представления
│           ├── bloc/               # BLoC управление состоянием
│           ├── pages/              # Страницы
│           └── widgets/            # Виджеты
├── injection_container.dart        # Dependency Injection
└── main.dart                      # Точка входа
```

## Использованные пакеты

### Основные зависимости:
- `flutter_bloc: ^8.0.0` - Управление состоянием
- `equatable: ^2.0.5` - Сравнение объектов
- `image_picker: ^0.8.6` - Выбор изображений
- `image: ^3.3.0` - Обработка изображений
- `flutter_colorpicker: ^1.0.3` - Выбор цвета
- `path_provider: ^2.0.11` - Доступ к файловой системе
- `http: ^0.13.5` - HTTP запросы
- `dio: ^4.0.6` - HTTP клиент
- `get_it: ^7.2.0` - Dependency Injection
- `dartz: ^0.10.1` - Функциональное программирование

## Установка и запуск

1. Убедитесь, что Flutter установлен:
```bash
flutter doctor
```

2. Установите зависимости:
```bash
flutter pub get
```

3. Запустите приложение:
```bash
flutter run
```

## Особенности реализации

### Управление состоянием (BLoC)
- **CardCustomizationBloc** - основной BLoC для управления состоянием кастомизации карты
- События: `InitializeCard`, `PickImageFromGallery`, `SetBackgroundColor`, `UpdateImageScale`, etc.
- Состояния: `Loading`, `Loaded`, `Saving`, `Saved`, `Error`

### Обработка изображений
- Автоматическое сжатие изображений перед отправкой
- Поддержка pinch-to-zoom и drag жестов
- Предустановленные изображения в assets

### Сетевые запросы
- Multipart/form-data для отправки данных
- Mock API endpoint для демонстрации
- Обработка ошибок сети

### UI/UX
- Material Design 3
- Responsive дизайн
- Интуитивные жесты управления
- Живой предварительный просмотр карты

## Структура карты

Карта содержит:
- Номер карты: 1234 5678 9012 3456
- Имя держателя: JOHN DOE
- Срок действия: 12/28
- Настраиваемый фон (изображение/цвет/градиент)
- Настраиваемое размытие

## Разрешения

### Android (android/app/src/main/AndroidManifest.xml)
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.INTERNET" />
```

### iOS (ios/Runner/Info.plist)
```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Приложению требуется доступ к фотобиблиотеке для выбора изображений.</string>
<key>NSCameraUsageDescription</key>
<string>Приложению требуется доступ к камере для съемки фотографий.</string>
```

## Архитектурные принципы

1. **Separation of Concerns** - четкое разделение ответственности между слоями
2. **Dependency Inversion** - зависимости направлены от внешних слоев к внутренним
3. **Single Responsibility** - каждый класс имеет одну ответственность
4. **Open/Closed** - открыт для расширения, закрыт для модификации
5. **Feature-First** - код организован по функциям, а не по типамtter project.


App Screenshoots


![github.com/Abdulazizbek2/card_customize/assets/3.png](https://github.com/Abdulazizbek2/card_customize/blob/main/assets/3.png)

![github.com/Abdulazizbek2/card_customize/assets/1.png](https://github.com/Abdulazizbek2/card_customize/blob/main/assets/1.png)

![github.com/Abdulazizbek2/card_customize/assets/2.png](https://github.com/Abdulazizbek2/card_customize/blob/main/assets/2.png)


## Getting Started

<!-- This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. -->
