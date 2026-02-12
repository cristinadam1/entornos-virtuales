# Enunciado
Aprovechando el conocimiento adquirido hasta ahora, plantea a nivel teórico y en pseudocódigo, el lanzamiento de un objeto desde una cámara de primera persona (FPV).

Imagina que, dentro de tu mundo virtual, seleccionas un objeto de tu "inventario", o un objeto que estás sujetando (como hijo de la cámara) y deseas lanzarlo. Sin recurrir al motor de física de Godot, vamos a simular el movimiento de tiro parabólico de este objeto.

 Describe qué fuerzas fundamentales considerarías para lograr una simulación realista: la masa del objeto, la fuerza inicial aplicada al lanzarlo desde la posición y orientación de la cámara virtual, resistencias que se oponen, etc. Justifica cómo cada una de estas fuerzas afectaría la trayectoria del objeto en el espacio virtual.

Para ilustrar tu razonamiento, esboza un diagrama sencillo que muestre la cámara FPV como punto de origen del lanzamiento, la dirección inicial de la fuerza aplicada y la trayectoria parabólica resultante afectada por la gravedad. Acompaña este esquema con las fórmulas básicas del movimiento parabólico que emplearías para calcular la posición del objeto en cada instante, asumiendo una aceleración constante debida a la gravedad virtual, y finalmente escribe el pseudocódigo que emplearías para realizar los cálculos en Godot.
Te recomiendo que te apoyes en la sección de tiro parabólico de la Wikipedia como fuente inicial de conocimiento: https://en.wikipedia.org/wiki/Projectile_motion

# Solución
# Simulación de Trayectoria Parabólica

Este documento detalla las fuerzas físicas, las fórmulas matemáticas y la implementación en pseudocódigo (estilo GDScript para Godot) para simular el lanzamiento de un objeto en un entorno 3D.

---

## 1. Fuerzas Fundamentales a Considerar

### **Gravedad ($g$)**
Es la fuerza principal que influye en la trayectoria. Actúa constantemente hacia abajo en el eje vertical (**Y negativo**). Provoca que el objeto describa una curva balística.
* **Valor estándar:** $9.8 \text{ m/s}^2$ para imitar el mundo real.

### **Fuerza Inicial (Velocidad Inicial)**
Depende de la orientación de la cámara y la intensidad del lanzamiento.
* **Dirección:** Definida por el vector frontal de la cámara.
* **Magnitud:** Determina el alcance máximo y la altura (apogeo) de la trayectoria.

### **Masa del Objeto**
En esta simulación cinemática, la **masa se ignora**. Al calcular posiciones mediante fórmulas matemáticas directas en lugar de un motor de colisiones de cuerpo rígido (*RigidBody*), la masa no afecta la aceleración resultante.

### **Resistencia del Aire**
Fuerza secundaria que actúa en dirección opuesta al movimiento.
* **Efecto:** Desaceleración progresiva que reduce la velocidad con el tiempo, haciendo que la parábola no sea perfecta y el objeto "caiga" más verticalmente al final.

---

## 2. Definición de Ejes y Fórmulas

Siguiendo el estándar de **Godot Engine**:
* **Ejes X / Z:** Movimiento horizontal.
* **Eje Y:** Movimiento vertical (Altura).



### **Fórmula de Posición**
Para calcular la posición $p$ en un tiempo $t$, utilizamos la ecuación de movimiento uniformemente acelerado:

$$p(t) = p_0 + v_0 \cdot t + \frac{1}{2} \cdot g \cdot t^2$$

**Donde:**
* $p_0$: Posición inicial (`Vector3` desde la cámara).
* $v_0$: Velocidad inicial (`Vector3` con dirección y magnitud).
* $g$: Gravedad constante $\vec{g} = (0, -9.8, 0)$.
* $t$: Tiempo transcurrido desde el lanzamiento.

---

## 3. Implementación (Pseudocódigo / GDScript)

```gdscript
var object_position = Vector3()          
var initial_position = Vector3()         # Posición de lanzamiento (cámara)
var initial_velocity = Vector3()         # Dirección * magnitud
var gravity = Vector3(0, -9.8, 0)        # Aceleración de gravedad
var time = 0.0                          
var is_launched = false
var air_resistance = 0.1                 # Coeficiente de fricción aerodinámica

func launch_object():
    initial_position = camera.global_transform.origin
    object_position = initial_position   
    
    # Obtener dirección hacia donde mira la cámara
    var direction = -camera.global_transform.basis.z.normalized()
    var speed = 16.0  
    
    initial_velocity = direction * speed
    time = 0.0
    is_launched = true

func _process(delta):
    if is_launched:
        time += delta        
        
        # Calcular velocidad actual incluyendo gravedad
        var velocity = initial_velocity + gravity * time
        
        # Aplicar resistencia del aire (desaceleración simple)
        velocity *= (1.0 - air_resistance * delta)
        
        # Actualizar posición
        object_position += velocity * delta
        $Object.global_transform.origin = object_position

        # Condición de parada (Suelo o límite inferior)
        if object_position.y < -10:
            is_launched = false
