# Cinemapedia

Cinemapedia es una aplicación desarrollada en **Flutter** cuyo objetivo principal es explorar y visualizar información de películas.
El proyecto fue construido aplicando arquitectura limpia por capas, con énfasis en organización del código, separación de responsabilidades y escalabilidad.

Más allá de la funcionalidad, este proyecto sirve como práctica sólida de arquitectura, gestión de estado y navegación declarativa en Flutter.

## 🧠 Arquitectura

La aplicación sigue una **arquitectura limpia por capas**, separando claramente las responsabilidades:

- **Presentation**: Contiene la UI, widgets, pantallas y lógica de interacción con el usuario.

- **Infrastructure**: Implementaciones concretas de acceso a datos, APIs externas, base de datos local y servicios.

- **Data**: Modelos, datasources y repositorios que definen cómo fluye la información dentro de la app.

Esta estructura permite:

- Mejor mantenibilidad

- Código más testeable

- Facilidad para escalar o cambiar implementaciones

## 🔄 Gestión de estado

Se utiliza **Riverpod** como manejador de estado principal, lo que permite:

- Estado predecible y desacoplado de la UI

- Mejor control del ciclo de vida

Facilidad para testing y refactorización

## 🧭 Navegación

La navegación se implementa con **go_router**, usando un enfoque declarativo para:

- Manejar rutas de forma clara

- Soportar deep links

- Facilitar la navegación web y móvil

## 🗄️ Persistencia y datos

- **Dio** para consumo de APIs

- **Drift** como base de datos local

- **flutter_dotenv** para manejo de variables de entorno

- Almacenamiento local para cache y datos persistentes

## ✨ UI y experiencia visual

La interfaz utiliza componentes y librerías como:

- **animate_do** para animaciones

- **card_swiper** y **flutter_staggered_grid_view** para layouts dinámicos

- **Material Design** como base visual

El enfoque principal fue lograr una UI clara y funcional, manteniendo una buena experiencia de usuario sin perder simplicidad.

## 🛠️ Tecnologías utilizadas

- **Flutter** (SDK ^3.9.2)

- **Riverpod**

- **go_router**

- **Dio**

- **Drift**

- **Material Design**

## 🚀 Instalación y ejecución

1. Clona el repositorio:

```bash
git clone https://github.com/irradev/fh-flutter-cinemapedia.git
```

2. Instala dependencias:

```bash
flutter pub get
```

3. Copiar el .env.template y renombrarlo a .env

4. Cambiar las variables de entorno (https://developer.themoviedb.org/)

5. Ejecutar la app:

```bash
flutter run
```

## 📝 Notas finales

Este proyecto está enfocado en buenas prácticas de arquitectura en Flutter, más que en una app comercial final.
Sirve como base sólida para proyectos más grandes y como demostración de criterio técnico en Flutter.

