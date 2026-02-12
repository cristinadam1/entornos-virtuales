# Enunciado
Ejercicio teórico-práctico 1: Creación de un cubo de forma procedural
Crea los arrays necesarios para dibujar las caras de un cubo, tanto de vértices como de caras. Para ello, revisa el tutorial de Godot para crear geometría (https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/index.html), ignora las normales (normals) y las coordenadas de textura (UV) por ahora.

Introduce el código en un nodo de Godot del tipo que consideres más apropiado, y sube directamente el contenido del fichero del código de GDScript en esta tarea.

Se valorará especialmente la atención a las restricciones vistas en clase y la eficiencia de las estructuras creadas.

# Solución
    extends MeshInstance3D
    
    func _ready():
    
    	var surface_array = []
    
    	surface_array.resize(Mesh.ARRAY_MAX)
    
    	var vertices = PackedVector3Array([
    
    		Vector3(-1, -1, -1), Vector3(1, -1, -1), Vector3(1, 1, -1), Vector3(-1, 1, -1), # Cara trasera
    
    		Vector3(-1, -1, 1), Vector3(1, -1, 1), Vector3(1, 1, 1), Vector3(-1, 1, 1)  # Cara frontal
    
    	])
    
    	var indices = PackedInt32Array([
    
    		0, 1, 2, 2, 3, 0, # Cara trasera
    
    		5, 4, 6, 6, 4, 7, # Cara frontal
    
    		0, 7, 4, 7, 0, 3, # Cara izquierda
    
    		1, 5, 6, 6, 2, 1, # Cara derecha
    
    		3, 2, 6, 6, 7, 3, # Cara superior
    
    		0, 5, 1, 5, 0, 4  # Cara inferior
    
    	])
    
    	surface_array[Mesh.ARRAY_VERTEX] = vertices

	surface_array[Mesh.ARRAY_INDEX] = indices

	mesh = ArrayMesh.new()

	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, surface_array)
