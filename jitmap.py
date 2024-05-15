# Importamos bibliotecas.
import pandas as pd
import matplotlib.pyplot as plt

# Leemos el archivo.
data = pd.read_csv("./fractal.csv")

# Formateamos la información.
x = data[' #Th1']
y = data[' Th2']
tg = data[' tg']
tl = data[' tl']

# Graficamos el mapa de calor.
plt.scatter(x, y, c=tg, cmap='inferno')
plt.colorbar(label='Tiempo de giro [s]')
plt.xlabel('Th1')
plt.ylabel('Th2')
plt.title('Fractal del tiempo de giro')
plt.savefig('fractal.png', dpi=600)
plt.show()

