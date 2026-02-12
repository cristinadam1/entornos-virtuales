# Entornos Virtuales 

Este repositorio contiene la implementación de los ejercicios técnico-prácticos y el desarrollo de las prácticas de la asignatura **Entornos Virtuales**. El proyecto se centra en el uso de **Godot Engine** y **Blender** para la creación y programación de mundos virtuales.

---

## 🚀 Prácticas del Curso

Se han desarrollado las siguientes prácticas integradas en un proyecto personal:

* **Práctica 1: Introducción al entorno jerárquico**: Primeros pasos con la estructura de nodos de Godot y el lenguaje **GDScript**.
* **Práctica 2: Creación e importación de modelos 3D**: Diseño de assets en **Blender**, exportación e importación al motor de juegos y gestión de animaciones.
* **Práctica 3: Cámaras, iluminación y materiales**: Configuración de sistemas de visualización, luces dinámicas y creación de materiales avanzados en Godot.
* **Práctica 4: Programación de entornos virtuales**: Implementación de la lógica de interacción y comportamiento de los objetos mediante scripting.
* **Práctica 5: Simulación física y sensores**: Aplicación de motores físicos, detección de colisiones y uso de sensores para interactuar con el entorno.

---

## 🛠️ Ejercicios Técnico-Prácticos

### 1. Geometría Procedural (Cubo)
Creación de mallas directamente desde código. Se han definido los arrays de vértices e índices necesarios para dibujar las caras de un cubo sin usar archivos de malla externos.
* **Técnica:** Uso de `surface_array` y `ArrayMesh`.
* **Eficiencia:** Implementado mediante `PackedVector3Array` y `PackedInt32Array`.

### 2. Shaders: Bump Mapping
Desarrollo de un shader espacial que calcula la normal de cada téxel en un plano utilizando un mapa de alturas (*height map*).
* **Algoritmo:** Cálculo de derivadas de la textura para generar relieve dinámico.
* **Visualización:** Configurado con `render_mode unshaded` para verificar la precisión del cálculo de iluminación manual.

### 3. Arquitectura ECS (Sistema de Gestión de Hotel)
Diseño de un objeto **Singleton (Autoload)** que gestiona un sistema de Entidad-Componente-Sistema para un entorno virtual inteligente.
* **Entidades:** Clientes, Robots y Dispositivos (Lámparas).
* **Componentes:** Salud/Estrés, Movimiento y Luz Inteligente.
* **Sistemas:** Procesamiento de confort y automatización de luces según la proximidad de entidades.

### 4. Cinemática: Tiro Parabólico FPV
Simulación teórica y práctica del lanzamiento de objetos desde una cámara en primera persona.
* **Fórmulas:** Aplicación de la ecuación de posición para movimiento uniformemente acelerado:
    $$p(t) = p_0 + v_0 \cdot t + \frac{1}{2} \cdot g \cdot t^2$$
* **Consideraciones:** Gravedad constante, velocidad inicial basada en la vista de la cámara y resistencia del aire.

---
**Autor:** [cristinadam1](https://github.com/cristinadam1)
