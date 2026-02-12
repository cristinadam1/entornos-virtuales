extends Camera3D

var velocidad_rotacion = 1.5
var pivote_z: Node3D
var pivote_y: Node3D

# Limites para la rotacion
var limite_superior = 25
var limite_inferior = -160
var angulo_actual = 0  

# Para el zoom
var fov_min = 30 
var fov_max = 90 
var velocidad_zoom = 5

func _ready():
	pivote_z = get_parent().get_parent()
	pivote_y = get_parent()
	
func _process(delta):
	# Derecha e Izquierda
	if Input.is_action_pressed("camara_girar_izq"):
		pivote_y.rotate_y(deg_to_rad(velocidad_rotacion))
	if Input.is_action_pressed("camara_girar_der"):
		pivote_y.rotate_y(deg_to_rad(-velocidad_rotacion))

	# Arriba y abajo
	if Input.is_action_pressed("camara_arriba"):
		rotar_camara_z(-velocidad_rotacion)
	if Input.is_action_pressed("camara_abajo"):
		rotar_camara_z(velocidad_rotacion)
	
	# Zoom
	if Input.is_action_pressed("zoom_in"):
		aplicar_zoom(-velocidad_zoom)
	if Input.is_action_pressed("zoom_out"):
		aplicar_zoom(velocidad_zoom)
			
func rotar_camara_z(rotacion):
	var nuevo_angulo = clamp(angulo_actual + rotacion, limite_inferior, limite_superior)
	var diferencia = nuevo_angulo - angulo_actual
	pivote_z.rotate_object_local(Vector3(0, 0, 1), deg_to_rad(diferencia))
	angulo_actual = nuevo_angulo
	
func aplicar_zoom(cambio_zoom):
	fov = clamp(fov + cambio_zoom, fov_min, fov_max)
