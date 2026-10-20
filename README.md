# Sano y Fresco — Análisis de Ventas y Market Basket Analysis

Análisis de ventas, productos y clientes en SQL, y un motor de recomendación por reglas de asociación (Market Basket Analysis) para un e-commerce de productos frescos y saludables.

## Contexto de negocio

Un e-commerce de productos frescos necesita entender qué se vende, quién compra y qué productos tienden a comprarse juntos. Esto último es clave para dos decisiones de negocio muy concretas: qué recomendar a un cliente en el momento de la compra, y cómo organizar promociones cruzadas entre productos que ya se compran juntos de forma natural.

## Resultados

Datos: 4.975.718 líneas de venta, 2.060.188 pedidos y 181.903 clientes de 2023 (40 productos).

- **Ventas**: 39,85 M€ en el año. Caen todos los meses (de 6,7 M€ en enero a 1,2 M€ en diciembre) porque se pierden clientes: los activos pasan de 149.775 a 17.349 y solo el 11 % de los clientes de enero sigue comprando en diciembre. Los que se quedan gastan más por pedido (de 18,7 € a 23,1 €).
- **Error de importación en Power BI**: los importes con un solo decimal (por ejemplo, 9,80 €) se leían divididos entre 10 o entre 100 (0,98 €). Afectaba al 31 % de las líneas y el dashboard mostraba 27,5 M€ en lugar de 39,85 M€. Se corrigió recalculando el importe como precio unitario × cantidad.
- **Market Basket**: **258 reglas útiles** de 1.560 posibles, con confianza media del 13,5 % y lift medio de 1,51. Las asociaciones más fuertes son cilantro ↔ limones (lift 3,58), ajo ↔ cebolla amarilla (3,53) y apio ↔ cebolla amarilla (2,84).

## Qué hace este proyecto

- **Análisis exploratorio en SQL**, de lo general a lo específico:
  - Visión general de ventas totales y su tendencia mensual.
  - Rendimiento por departamento y por sección.
  - Los 10 productos más vendidos en cantidad y los 10 que más ingresos generan.
  - Los 20 clientes con mayor volumen de compra y la compra media por cliente.
  - Número total de pedidos y valor promedio por pedido.
- **Market Basket Analysis**: detección de reglas de asociación entre parejas de productos (qué se compra junto con qué), usada como base para un motor de recomendación:
  - **Soporte**: en qué porcentaje de pedidos aparece cada producto y cada pareja.
  - **Confianza**: de los pedidos con A, cuántos llevan también B.
  - **Lift**: cuántas veces más se compran juntos de lo que cabría esperar por azar. Las reglas con lift > 1 son candidatas a recomendación o venta cruzada; las de lift < 1 señalan productos sustitutivos que no conviene promocionar juntos.
- **Reglas enriquecidas** con los datos del producto, la sección y el departamento de cada lado de la regla, y exportadas a CSV para el dashboard.

## Revisión y correcciones (octubre 2026)

La primera versión del Market Basket Analysis se revisó a fondo. Las correcciones más importantes:

- **Faltaba la mitad de las reglas**: con `combinations` solo se calculaba un sentido de cada pareja (A → B, pero no B → A), y la confianza no es simétrica.
- **Reglas útiles y no útiles mezcladas**: ahora se filtran por lift > 1 y un soporte mínimo, y los productos que se compran juntos menos de lo esperado van en una tabla aparte.
- **Rendimiento**: el cálculo filtraba millones de filas por cada pareja; ahora se resuelve con una multiplicación de matrices (`X.T @ X`) sobre una matriz de cestas mucho más ligera, y se comprueba que da los mismos resultados que las funciones originales.
- **Enriquecimiento completo**: antes solo se añadían los datos del antecedente; ahora también los del consecuente, con nombre de sección y control de duplicados en los `merge`.
- **Cifras de la versión anterior**: con los mismos datos, el método original daba 399 reglas, 48 de ellas con lift < 1, una confianza media de 8,33 % y un lift medio de 1,46.
- **Robustez**: la conexión a la base de datos se cierra siempre y se comprueba antes que el archivo existe (si no, SQLite crea una base vacía sin avisar).

El detalle de todas las correcciones está al final del notebook.

## Herramientas

- **SQL** (sintaxis SQLite) para el análisis exploratorio de ventas, productos y clientes
- **Python** (pandas, numpy, matplotlib) para el Market Basket Analysis y las reglas de asociación
- **Power BI** para el dashboard interactivo (disponible en el portfolio)

## Estructura del repositorio

- `consultas_analisis_sano_y_fresco.sql`: consultas de análisis de ventas, productos y clientes
- `TPE_MarketBasketAnalysis_colab_corregido.ipynb`: el Market Basket Analysis, explicado paso a paso
- `TPE_MarketBasketAnalysis_colab_corregido.pdf`: el mismo notebook en PDF

## Cómo ejecutarlo

1. Ejecuta las consultas de `consultas_analisis_sano_y_fresco.sql` contra la base de datos de tickets de venta (`sanoyfresco.db`).
2. Abre el notebook en Google Colab o Jupyter y coloca `sanoyfresco.db` en la misma carpeta (en Colab, súbelo al panel de Archivos). El archivo `secciones.xlsx` es opcional: añade el nombre de cada sección a las reglas.
3. Ejecuta todas las celdas en orden. Las reglas se exportan a `reglas.csv`.

## Autor

Javier Sotoca — portfolio completo: https://sites.google.com/view/javiersotoca/home
