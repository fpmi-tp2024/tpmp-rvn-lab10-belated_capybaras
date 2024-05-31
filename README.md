

# Проект "PetLink"

## Вариант: X
 - Лабораторная работа 10, БГУ, 2024г.

## Исполнители:
- [**Кохан Даниил**](https://github.com/ExiDola):pray:- *DocWriter and spiritual support*
- [**Барановский Максим**](https://github.com/MaximBaranovskiy) :alien:- *Backend Coder*
- [**Соловьёв Даниил**](https://github.com/soldansd) :star:- *Frontend Coder* 
- [**Еремейчик Егор**](https://github.com/Eg0rik) :beer:- *Devops engineer*

## Общий функционал и смысл проекта
 ***PetLink*** — это мобильное приложение, предназначенное для владельцев домашних животных и приютов. Основная цель приложения — облегчить процесс усыновления собак и помочь владельцам заботиться о своих питомцах. Приложение предоставляет следующие основные функции:

 - **Регистрация и выбор роли**:
Пользователи могут зарегистрироваться как частные лица или как представители приютов.
 - **Для пользователей**:
Возможность просматривать доступных для усыновления собак и подавать заявки на усыновление.
Просмотр ближайших приютов на карте.
Поддержка приютов через волонтерскую деятельность и пожертвования.
 - **Для приютов**:
Управление списком собак, доступных для усыновления: добавление, редактирование и удаление информации о собаках.
Обновление информации о приюте и его деятельности.
Как это реализовано
Интерфейс пользователя:

> Приложение предоставляет удобный и интуитивно понятный интерфейс для взаимодействия с пользователями.
Пользователи могут легко зарегистрироваться и выбрать роль.
Для каждой роли предусмотрены специфические функции и интерфейсы, облегчающие выполнение задач.

 - **Функциональность для пользователей**:
 Пользователи могут создать профиль, добавить информацию о себе и просматривать собак, доступных для усыновления.
Карта с геолокацией помогает найти ближайшие приюты.
Пользователи могут поддерживать приюты, участвуя в волонтерских программах или делая пожертвования.

- **Функциональность для приютов**:
Приюты могут добавлять новых собак, указывая все необходимые данные.
Возможность редактирования и обновления информации о питомцах.
Удаление записей о собаках, которые нашли новый дом.
PetLink — это эффективный инструмент, объединяющий владельцев

# Проект выполнен по модели проектирования MVVM
 ### Коротко о ней:
 - ***Assets.xcassets***: Содержит ассеты, такие как изображения и иконки, используемые в приложении.
- ***Model*** Содержит модели данных, которые представляют структуру и свойства объектов, используемых в приложении.
- ***Preview Content*** Содержит данные для предварительного просмотра SwiftUI в Xcode.
- ***View*** Содержит представления (Views), которые отвечают за отображение пользовательского интерфейса.
- ***ViewModel*** Содержит модели представлений (ViewModels), которые управляют данными и логикой, связанной с представлениями.

<br></br>

## Основные требования к проекту PetLink:

### ✅ Разработка пользовательского интерфейса (UI):
 - В проекте разработан интуитивно понятный пользовательский интерфейс, который обеспечивает удобную навигацию и взаимодействие с функционалом приложения. (Файлы: ui.go, styles.css)

### ✅ Реализация серверной части на языке Go:
 - Серверная часть проекта реализована на языке программирования Go, что обеспечивает высокую производительность и надежность. Все данные сохраняются и обрабатываются с использованием базы данных. (Файлы: main.go, handlers.go, storage.go)

 ### ✅ Создание таблиц БД с учетом ограничений целостности данных:
  - В проекте выполнена миграция базы данных, создающая необходимые таблицы с учетом целостности данных. (Файл: 20240530171232_create_table.sql)

### ✅ Использование оператора SELECT для выдачи информации по требованиям

 - В проекте реализованы функции для выборки данных из базы данных с использованием оператора SELECT. (Файлы: handlers.go, storage.go)

### ✅ Обновление информации с помощью операторов INSERT, UPDATE, DELETE

- Реализованы операции для добавления, обновления и удаления данных в таблицах базы данных. (Файлы: handlers.go, storage.go)

### ✅ Создание функции для проверки соответствия данных при добавлении информации

 - В проекте реализована функция, которая проверяет соответствие данных при добавлении новых записей в таблицы, предотвращая нарушение целостности данных. (Файл: models.go)

### ✅ Работа с документацией

- Документация проекта оформлена и включает диаграммы классов, серверной и клиентской части. Также предоставлены ссылки на GitHub Pages и разбор базы данных.

<br></br>

#### 1. Модель данных и работа с базой данных:
    1.1 models.go
    1.2 storage.go
    1.3 20240530171232

#### 2. Обработчики запросов:
    2.1 handlers.go


#### 3. Запуск сервера:
    3.1 main.go
    3.2 server.go

## Небольшая схема с использоанием sheilds.io
![](./docs/Diagrams/Sceme.png)

## Полезные ссылки:
 - [Ссылка на разбор таблиц и данных в них](./docs/DataBase.md)
 - [Ссылка на вспомогательный файл .md для GitHub Pages](./docs/index.md)
 - [Ссылка на наш GitHubWiki](https://github.com/fpmi-tp2024/tpmp-rvn-lab10-belated_capybaras/wiki)
- [Ссылка на схему бд](./docs/Diagrams/BDSceme.jpg)
- [Cсылка на результаты build в Actions](./docs/buildCheck.md)


## Используемый язык программирвания,СУБД, IDE и т.д. :
<img src="https://simpleicons.org/icons/swift.svg" alt="C++ Logo" width="150" height="150"> <img src="https://simpleicons.org/icons/sqlite.svg" alt="C++ Logo" width="150" height="150"> <img src="https://simpleicons.org/icons/go.svg" alt="C++ Logo" width="150" height="150"> <img src="https://simpleicons.org/icons/visualstudio.svg" alt="C++ Logo" width="150" height="150"> <img src="https://simpleicons.org/icons/git.svg" alt="C++ Logo" width="150" height="150">
<img src="https://simpleicons.org/icons/xcode.svg" alt="C++ Logo" width="150" height="150">





## Видео демонстрация:

[Скачать видео](https://github.com/fpmi-tp2024/tpmp-rvn-lab10-belated_capybaras/raw/devExiDola/docs/videoOfWork.mov)

<video width="560" height="315" controls>
  <source src="https://github.com/fpmi-tp2024/tpmp-rvn-lab10-belated_capybaras/raw/devExiDola/docs/videoOfWork.mov" type="video/mp4">
  Your browser does not support the video tag.
</video>
