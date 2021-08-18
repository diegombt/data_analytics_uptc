# Instalar y usar SQLite

1. Seleccionar y descargar la versión apropiada (Para este caso recomiendo SQLite Tools ) de [SQLite](https://www.sqlite.org/download.html)
2. Desde el explorador del sistema operativo, ubicar la ruta donde se extrajo SQLite y lanzar una consola del sistema
3. Ejecutar el comando: _SQLite3_ _>_ _Fifa19.db_. Esto creará un archivo de bases de datos en la ruta seleccionada
4. Seleccionar y descargar la versión apropiada de [SQLite Studio](https://sqlitestudio.pl/), descomprimir y ejecutar el programa
5. Desde el menu _Database_ agregar una nueva base de datos, buscar la ruta donde previamente creamos el archivo y seleccionarlo
6. Crear una nueva hoja de edición de SQL, pegar el contenido del archivo [create_table_fifa19.sql](https://github.com/diegombt/data_analytics_uptc/blob/main/sqlite/create_table_fifa19.sql) y ejecutarlo. Esto creará una nueva tabla en la BD
7. Ir al menú _Tool_ > _import_, seleccionar la BD y tabla Fifa19, hacer clic en siguiente y ubicar el archivo CSV [Fifa_2019_Ajustado](https://github.com/diegombt/data_analytics_uptc/blob/main/sqlite/Fifa_2019_Ajustado.csv). 
8. Indicar que el primer registro tiene los nombres de las columnas, seleccionar punto y coma como separador de columnas y hacer clic en Finish. Esto importará los datos de Fifa19