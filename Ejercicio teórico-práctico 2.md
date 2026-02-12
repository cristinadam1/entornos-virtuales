# Enunciado
Realiza un pequeño shader (puedes probarlo usándolo como material en Godot) que, usando el algoritmo de Bump Mapping que hemos visto en clase, calcule la normal para cada uno de los téxeles de una textura en un plano. Puedes usar la definición de la derivada u operaciones de convolución mediante máscaras.

Para entregarlo, puedes adjuntar el fichero del material del shader o copiar el código del shader directamente en el texto de esta tarea.

# Solución
    shader_type spatial;
    
    render_mode unshaded;
    
    
    
    uniform sampler2D height_map;
    
    uniform float height_scale = 0.05;
    
    void fragment() {
    
        // coordenadas de textura
    
        vec2 uv = UV;
    
        // tamaño del texel 
    
        float texel_size = 1.0 / float(textureSize(height_map, 0).x); 
    
        float height_center = texture(height_map, uv).r;
    
        float height_left   = texture(height_map, uv - vec2(texel_size, 0.0)).r;
    
        float height_right  = texture(height_map, uv + vec2(texel_size, 0.0)).r;
    
        float height_up     = texture(height_map, uv + vec2(0.0, texel_size)).r;
    
        float height_down   = texture(height_map, uv - vec2(0.0, texel_size)).r;
    
        float dHx = (height_right - height_left) * 0.5;
    
        float dHy = (height_up - height_down) * 0.5;
    
    
    
        vec3 normal = normalize(vec3(-dHx * height_scale, -dHy * height_scale, 1.0));
    
    
    
        // paso a espacio del mundo para que se vea bien en un plano
    
        NORMAL = normal;
    
    
    
        // uso la normal para iluminar 
    
        ALBEDO = vec3(1.0, 1.0, 1.0) * dot(normal, vec3(0.0, 0.0, 1.0));
    
    }
