# Sano y Fresco — Análisis de Ventas y Market Basket Analysis

Análisis de ventas, productos y clientes en SQL, y un motor de recomendación por reglas de asociación (Market Basket Analysis) para un e-commerce de productos frescos y saludables.

## Contexto de negocio

Un e-commerce de productos frescos necesita entender qué se vende, quién compra y qué productos tienden a comprarse juntos. Esto último es clave para dos decisiones de negocio muy concretas: qué recomendar a un cliente en el momento de la compra, y cómo organizar promociones cruzadas entre productos que ya se compran juntos de forma natural.

## Qué hace este proyecto

- **Análisis exploratorio en SQL**, de lo general a lo específico:
  - Visión general de ventas totales y su tendencia mensual.
  - Rendimiento por departamento y por sección.
  - Los 10 productos más vendidos en cantidad y los 10 que más ingresos generan.
  - Los 20 clientes con mayor volumen de compra y la compra media por cliente.
  - Número total de pedidos y valor promedio por pedido.
- **Market Basket Analysis**: detección de reglas de asociación entre productos (qué se compra junto con qué), usada como base para un motor de recomendación.

## Herramientas

- **SQL** (sintaxis SQLite) para el análisis exploratorio de ventas, productos y clientes
- **Python** (pandas, mlxtend) para el Market Basket Analysis y las reglas de asociación
- **Power BI** para el dashboard interactivo (disponible en el portfolio)

## Cómo ejecutarlo

1. Ejecuta las consultas de `consultas_analisis_sano_y_fresco.sql` contra tu propia base de datos de tickets de venta.
2. Abre `TPE_MarketBasketAnalysis_colab.ipynb` en Google Colab o Jupyter, adaptando la ruta de carga de datos a tu entorno, y ejecuta las celdas en orden.

## Autor

Javier Sotoca — portfolio completo: https://sites.google.com/view/javiersotoca/home
