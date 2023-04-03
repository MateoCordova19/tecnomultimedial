void setup() {
  size(400, 400);
}

void draw() {
  background(220, 220, 255); // establece el fondo en un color azul claro
  noStroke(); // desactiva el contorno

  // dibuja el cuerpo del pez
  fill(255, 200, 0); // establece el color de relleno en dorado
  ellipse(200, 200, 120, 60);

  // dibuja la cola del pez
  fill(255, 200, 0); // establece el color de relleno en dorado
  triangle(150, 200, 100, 230, 100, 170);

  // dibuja la aleta superior del pez
  fill(255, 200, 0); // establece el color de relleno en dorado
  triangle(200, 180, 220, 160, 240, 180);

  // dibuja la aleta inferior del pez
  fill(255, 200, 0); // establece el color de relleno en dorado
  triangle(200, 220, 220, 240, 240, 220);

  // dibuja el ojo del pez
  fill(255); // establece el color de relleno en blanco
  ellipse(240, 190, 20, 20);
  fill(0); // establece el color de relleno en negro
  ellipse(245, 190, 8, 8);
}
