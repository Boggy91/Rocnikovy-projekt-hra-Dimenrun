shader_type canvas_item;

void fragment() {
    vec2 uv = UV;
    uv.x = mod(uv.x, 2.0);
    if (uv.x > 1.0) {
        uv.x = 2.0 - uv.x;
    }
    COLOR = texture(TEXTURE, uv);
}
