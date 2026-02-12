# Enunciado
Escribe el pseudocódigo de un objeto Singleton (por ejemplo teniendo en mente los Autoload de Godot) que permita gestionar un ECS. Para ello:

Define tres componentes distintos.
Define dos sistemas diferentes. El primer sistema trataría el comportamiento de dos de los componentes anteriores y el segundo sistema el comportamiento del tercer componente.
A modo de ejemplo, define varias entidades que ganen y pierdan componentes a lo largo del tiempo dentro del entorno.
Explica qué señales que habría que tener y dónde, qué grupos tendríamos y qué métodos tendría nuestro singleton. También explica que tipo de estructura necesitamos para cada entidad y sistema.

Ten en cuenta que no hay una única solución correcta, pero hay soluciones incorrectas. Usa un ejemplo distinto al de las diapositivas de clase.

Para este ejercicio utiliza la siguiente plantilla:
1. Mis tres componentes son:
2. Mis entidades se representan computacionalmente como:
3. Mis componentes se representan computacionalmente como:
4. Mis sistemas se representan computacionalmente como:
5. Las estructuras empleadas son:
- Nodos: ...
- Scripts: ...
- Métodos: ...
...
6. El pseudo algoritmo que uniría las estructuras del punto 5 sería el siguiente:
7. Dadas estas entidades: _______________________, el ejemplo de funcionamiento sería el siguiente:

Para este ejemplo (punto 7) , ten en cuenta que las entidades se crearán y destruirán de forma dinámica en el mundo, y que también será dinámica la asignación de componentes a las entidades (todo según la interacción del usuario en tiempo real). Indica en el ejemplo como afecta el cambio de asignación de componentes en las entidades a los sistemas propuestos.

# Solución
1. Mis tres componentes son:

- ComponenteSaludCliente: representa el bienestar de un cliente(para activar alarmas médicas o asistencia)
- ComponenteMovimiento: para entidades móviles como clientes o robots
- ComponenteLuzInteligente: para controlar las luces automatizadas que cambian según presencia/estado del huésped
  
2. Mis entidades se representan computacionalmente como:

    Entidad = {
    
        id: int,
    
        componentes: Set<ComponenteTipo>
    
    
    }

Las entidades son los clientes, robot de servicio, lámpara y habitación

3. Mis componentes se representan computacionalmente como:

        ComponenteSaludCliente = {
        
            nivel_energia: float,
        
            nivel_estres: float
        
        }
        
        ComponenteMovimiento = {
        
            velocidad: float,
        
            destino: Vector2
        
        }
        
        ComponenteLuzInteligente = {
        
            intensidad: float,
        
            modo_automatico: bool
        
        
        }

4. Mis sistemas se representan computacionalmente como:

SistemaConfortCliente: afecta a entidades con SaludCliente y Movimiento. Si están estresados, ralentiza su velocidad o les redirige a zonas de descanso
SistemaLuzAmbiente: procesa entidades con LuzInteligente. Si hay un cliente cerca y el modo automático está activado, se ajusta la intensidad.
5. Las estructuras empleadas son:

Nodos: ECSHotelManager (singleton añadido como Autoload)
Scripts: ecs_hotel_manager.gd, sistema_confort_cliente.gd, sistema_luz_ambiente.gd

Métodos:

    signal componente_agregado(entidad_id, tipo)
    
    signal componente_eliminado(entidad_id, tipo)
    
    signal cliente_entra_habitacion(entidad_id)
    
    
    
    var entidades = {} 
    
    var componentes = {
    
        "SaludCliente": {},
    
        "Movimiento": {},
    
        "LuzInteligente": {}
    
    }

    var sistemas = []
    
    
    
    func add_entidad(entidad):
    
        entidades[entidad.id] = entidad
    
    
    
    func remove_entidad(id):
    
        entidades.erase(id)
    
        for tipo in componentes:
    
            componentes[tipo].erase(id)



    func add_componente(id_entidad, tipo, componente):
    
        componentes[tipo][id_entidad] = componente
    
        entidades[id_entidad].componentes.add(tipo)
    
        emit_signal("componente_agregado", id_entidad, tipo)



    func remove_componente(id_entidad, tipo):
    
        componentes[tipo].erase(id_entidad)
    
        entidades[id_entidad].componentes.erase(tipo)
    
        emit_signal("componente_eliminado", id_entidad, tipo)



    func get_entidades_con(componentes_requeridos: Array) -> Array:
    
        var resultado = []
    
        for entidad in entidades.values():
    
            var tiene_todos = true
    
            for c in componentes_requeridos:
    
                if not entidad.componentes.has(c):
    
                    tiene_todos = false
    
                    break
    
            if tiene_todos:
    
                resultado.append(entidad.id)
    
        return resultado



    func update(delta):
    
        for sistema in sistemas:
    
            sistema.procesar(self, delta)

6. El pseudo algoritmo que uniría las estructuras del punto 5 sería el siguiente:

        update(delta):
        
            para sistema en sistemas:
        
                sistema.procesar(self, delta)



# Sistema de confort

    SistemaConfortCliente.procesar(manager, delta):
    
        var entidades = manager.get_entidades_con(["SaludCliente", "Movimiento"])
    
        for id in entidades:
    
            var salud = manager.componentes["SaludCliente"][id]
    
            var movimiento = manager.componentes["Movimiento"][id]
    
            if salud.nivel_estres > 0.8:
    
                movimiento.destino = Vector2(100, 200)  # zona de relax
    
    
                movimiento.velocidad *= 0.5



# Sistema de iluminación

    SistemaLuzAmbiente.procesar(manager, delta):
    
        var entidades = manager.get_entidades_con(["LuzInteligente"])
    
        for id in entidades:
    
            var luz = manager.componentes["LuzInteligente"][id]
    
            if luz.modo_automatico:
    
                if cliente_cerca(id, manager):
    
                    luz.intensidad = 1.0
    
                else:
    
                    luz.intensidad = 0.2
    
    
    
    func cliente_cerca(entidad_id, manager):
    
        var posicion_luz = get_posicion(entidad_id)
    
        for cliente_id in manager.get_entidades_con(["Movimiento"]):
    
            var pos_cliente = get_posicion(cliente_id)
    
            if posicion_luz.distance_to(pos_cliente) < 100:
    
                return true
    
        return false

7. Dadas estas entidades:

- E1: Cliente con Movimiento y SaludCliente
- E2: Robot con Movimiento
- E3: Lámpara con LuzInteligente
- E4: Habitación con LuzInteligente
  
, el ejemplo de funcionamiento sería el siguiente:

1. Inicio:

    El cliente E1 camina hacia su habitación
    
    E3 (una lámpara del pasillo) está apagada porque no detecta movimiento cerca
    
    E4 (lámpara de la habitación) detecta la presencia de E1 cuando entra y sube su intensidad automáticamente
    
    Se emite la señal cliente_entra_habitacion(E1)

2. Aumento de estrés:

    E1 tiene una interacción que le molesta (ruido, temperatura ...), su nivel_estres sube a 0.9.
    
    SistemaConfortCliente lo detecta y:
    
    - Redirige su destino al spa
    - Reduce su velocidad para simular cansancio
   
4. Cambio dinámico:

Se le añade el componente ComponenteLuzInteligente al robot (E2), que ahora puede iluminar pasillos por donde camina

    ECSHotelManager.add_componente(E2, "LuzInteligente", {intensidad = 0.5, modo_automatico = true})

SistemaLuzAmbiente ahora también gestiona al robot
A medida que el robot camina por los pasillos, su luz se ajusta si hay personas cerca

Señales:

- "componente_agregado(entidad_id, tipo)", para actualizar interfaces (por ejemplo, mostrar icono de estrés)
- "componente_eliminado(entidad_id, tipo)", para desconectar un sistema (como una lámpara que se apaga porque se rompe)
- "cliente_entra_habitacion(entidad_id)", para encender luces o activar música
