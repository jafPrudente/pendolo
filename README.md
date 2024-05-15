## Pendolo

Este proyecto soluciona varias veces el sistema diferencial del péndulo doble para obtener un fractal a partir del tiempo de giro de uno de los dos péndulos. Se considera que no necesariamente los dos péndulos son iguales.

Se usa el formalismo hamiltoniano para obtener las ecucaciones de evolución, que están definidas en la subrutina `derivadas`, ahí se define $ \alpha $ como el cociente entre las masas y $ \beta $ como el cociente entre las longitudes de los péndulos.

Se usó como guia el siguiente artículo:
- Heyl, J. S. (2008). The double pendulum fractal. Department of Physics and Astronomy.

Para poder ejecutar el proyecto se debe hacer lo siguiente:
1. Llenar el archivo `input.par` con los parámetros de entrada
2. Ejecutar el comando `make` sobre la carpeta raíz del documento. Esto compilará y creará una carpeta llamada `data` con una copia del `input.par`, el graficador y el ejecutable `pendulito`.
3. Ejecutar con `./pendulito` dentro de la carpeta `data`.
4. Una vez terminada la ejecución se grafica con `python3 jitmap.py`.
