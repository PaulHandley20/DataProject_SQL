# 📊 Proyecto SQL: Consultas y Análisis de Datos

Este repositorio contiene la resolución de una serie de consultas SQL diseñadas para analizar una base de datos de un negocio de alquiler de películas. Se incluyen consultas para la extracción, manipulación y análisis de datos, abordando conceptos clave como `JOINs`, `GROUP BY`, `ORDER BY`, `HAVING`, `SUBQUERIES` y `VIEWS`.

---

## 📋 Tabla de Contenidos
- [📖 Descripción del Proyecto](#-descripción-del-proyecto)
- [🗂 Estructura del Proyecto](#-estructura-del-proyecto)
- [🛠 Instalación y Requisitos](#-instalación-y-requisitos)
- [💡 Ejemplos de Consultas](#-ejemplos-de-consultas)
- [📊 Resultados Destacados](#-resultados-destacados)
- [🔄 Próximos Pasos](#-próximos-pasos)
- [✒ Autores y Agradecimientos](#-autores-y-agradecimientos)

---

## 📖 Descripción del Proyecto
El propósito de este proyecto es aplicar conocimientos de SQL para realizar consultas sobre una base de datos que contiene información de un negocio de alquiler de películas. Se incluyen consultas que permiten:
- Obtener información de actores y películas.
- Analizar la duración y clasificación de películas.
- Evaluar estadísticas de alquileres y pagos.
- Determinar las películas más populares basándose en la cantidad de alquileres.
- Identificar a los clientes más activos en términos de alquileres.
- Aplicar `JOINS` para relacionar múltiples tablas.
- Utilizar funciones de agregación para cálculos avanzados.

Este proyecto también ayuda a comprender mejor el uso de SQL en un entorno comercial, proporcionando datos útiles para la toma de decisiones en un negocio de alquiler de películas.

---

## 🗂 Estructura del Proyecto
├── RESPUESTAS PARA ENTREGAR.sql   # Archivo con las consultas SQL
├── EnunciadoDataProject_SQL.Lógica.pdf   # Documento con las consignas del proyecto
├── Paso a paso del trabajo.docx   # Explicación detallada de cada consulta
├── README.md   # Descripción del proyecto

---

## 🛠 Instalación y Requisitos
Para ejecutar las consultas, necesitarás un gestor de bases de datos SQL. Puedes utilizar:
- **Dbeaver**
- **PostgreSQL**
- **SQLite**
- **MySQL**

---

## 💡 Ejemplos de Consultas

Aquí se presentan algunas consultas incluidas en el proyecto:

1. **Películas con clasificación 'R':**
   ```sql
   SELECT title FROM film WHERE rating = 'R';
   ```

2. **Actores con un `actor_id` entre 30 y 40:**
   ```sql
   SELECT first_name, last_name FROM actor WHERE actor_id BETWEEN 30 AND 40;
   ```

3. **Películas cuyo idioma coincide con su idioma original:**
   ```sql
   SELECT title FROM film WHERE language_id = original_language_id;
   ```

4. **Clientes con mayor número de alquileres:**
   ```sql
   SELECT customer_id, COUNT(*) AS total_rentals 
   FROM rental 
   GROUP BY customer_id 
   ORDER BY total_rentals DESC 
   LIMIT 10;
   ```

Más ejemplos y detalles están disponibles en `RESPUESTAS PARA ENTREGAR.sql` y `Paso a paso del trabajo.docx`.

---

## 📊 Resultados Destacados
- **Análisis de clasificaciones de películas.**
- **Cálculo de ingresos totales por alquileres.**
- **Identificación de clientes con mayor número de alquileres.**
- **Determinación de las películas más alquiladas.**
- **Estadísticas avanzadas con funciones de agregación y filtros personalizados.**

---

## 🔄 Próximos Pasos
1. Implementar procedimientos almacenados para automatizar reportes.
2. Desarrollar reportes visuales en Power BI o Tableau basados en los datos analizados.
4. Explorar estrategias de segmentación de clientes para mejorar las recomendaciones de películas.

---

## ✒ Autores y Agradecimientos
- **Autor:** Paul Handley
- **Contacto:** [paulhandley2001@gmail.com.]
- **GitHub:** [@PaulHandley20](https://github.com/PaulHandley20)

Agradecimientos a los instructores y compañeros que contribuyeron al desarrollo de este proyecto.

---

¡Gracias por visitar este proyecto! 😊
