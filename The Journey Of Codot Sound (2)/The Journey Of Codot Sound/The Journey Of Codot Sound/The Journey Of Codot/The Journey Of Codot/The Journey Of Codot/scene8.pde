class Scene8 {
 int scene = 8;
// Variabel global untuk posisi dan properti pocong
float pocongX = 400; // Koordinat X pocong
float pocongY = 700; // Koordinat Y pocong
float pocongAlpha = 150; // Nilai alpha untuk transparansi
boolean showText = true; // Kondisi untuk menampilkan teks
float textAlpha = 0; // Transparansi awal teks

void setup() {
  size(800, 800); // Mengatur ukuran kanvas menjadi 800x800
  backgroundGradient(0, 119, 190, 0, 0, 139); // Warna biru laut dengan gradien
}

void display() {
  backgroundGradient(0, 119, 190, 0, 0, 139); // Gambar ulang latar belakang dengan gradien
  drawRocks(); // Gambar batu karang
  drawSeaweed(100, 750); // Gambar tanaman laut
  drawSeaweed(400, 780);
  drawSeaweed(650, 760);

  moveFish(); // Perbarui posisi ikan
  drawFish(fishX, fishY); // Gambar ikan

  moveFish2(); // Perbarui posisi ikan kedua
  drawFish2(fish2X, fish2Y); // Gambar ikan kedua

  moveJellyfish(); // Perbarui posisi ubur-ubur
  drawJellyfish(jellyfishX, jellyfishY); // Gambar ubur-ubur

  drawBubbles(); // Gambar gelembung udara
  drawStarfish(600, 740); // Gambar bintang laut
  drawShell(300, 760); // Gambar kerang

  drawPocong(pocongX, pocongY, pocongAlpha); // Gambar pocong dengan nilai alpha

  if (showText) {
    // Tingkatkan alpha untuk efek "fade in"
    if (textAlpha < 255) {
      textAlpha += 2; // Sesuaikan kecepatan efek "fade in" dengan menambah nilai alpha
    }
    drawText(textAlpha); // Panggil fungsi untuk menggambar teks dengan nilai alpha yang diatur
  }
}

// Fungsi untuk menggambar latar belakang dengan gradien
void backgroundGradient(int r1, int g1, int b1, int r2, int g2, int b2) {
  for (int y = 0; y < height; y++) {
    float inter = map(y, 0, height, 0, 1);
    int r = int(lerp(r1, r2, inter));
    int g = int(lerp(g1, g2, inter));
    int b = int(lerp(b1, b2, inter));
    stroke(r, g, b);
    line(0, y, width, y);
  }
}

// Menggambar batu karang di dasar laut
void drawRocks() {
  noStroke();
  fill(139, 69, 19); // Warna coklat untuk batu
  ellipse(200, 750, 250, 120); // Batu besar
  ellipse(500, 780, 300, 150); // Batu sedang
  ellipse(700, 740, 180, 100);  // Batu kecil
}

// Menggambar tanaman laut
void drawSeaweed(float x, float y) {
  fill(34, 139, 34); // Warna hijau untuk tanaman laut
  beginShape();
  vertex(x, y);
  bezierVertex(x - 20, y - 80, x + 20, y - 80, x, y - 160);
  bezierVertex(x - 20, y - 240, x + 20, y - 240, x, y - 320);
  endShape();
}

// Menggambar ikan pertama
float fishX = 0;
float fishY = 400;

void drawFish(float x, float y) {
  fill(255, 165, 0); // Warna oranye untuk ikan
  ellipse(x, y, 60, 30); // Badan ikan
  triangle(x - 30, y, x - 50, y - 15, x - 50, y + 15); // Ekor ikan
}

void moveFish() {
  fishX += 2; // Gerakkan ikan ke kanan
  if (fishX > width) {
    fishX = -60; // Kembalikan ikan ke kiri jika keluar dari layar
  }
}

// Menggambar ikan kedua
float fish2X = 800;
float fish2Y = 500;

void drawFish2(float x, float y) {
  fill(0, 191, 255); // Warna biru untuk ikan kedua
  ellipse(x, y, 50, 25); // Badan ikan
  triangle(x + 25, y, x + 45, y - 12, x + 45, y + 12); // Ekor ikan
}

void moveFish2() {
  fish2X -= 1.5; // Gerakkan ikan ke kiri
  if (fish2X < -50) {
    fish2X = width + 50; // Kembalikan ikan ke kanan jika keluar dari layar
  }
}

// Menggambar gelembung udara yang naik ke atas
void drawBubbles() {
  fill(173, 216, 230, 150); // Warna biru terang dan transparan untuk gelembung
  noStroke();
  float[] bubbleX = {200, 300, 400, 500, 600};
  float[] bubbleY = {700, 650, 600, 550, 500};
  float[] bubbleSize = {20, 15, 25, 18, 22};

  for (int i = 0; i < bubbleX.length; i++) {
    ellipse(bubbleX[i], bubbleY[i], bubbleSize[i], bubbleSize[i]);
    bubbleY[i] -= 1; // Naikkan gelembung ke atas
    if (bubbleY[i] < 0) {
      bubbleY[i] = height; // Kembalikan gelembung ke bawah jika keluar dari layar
    }
  }
}

// Fungsi untuk menggambar pocong
void drawPocong(float x, float y, float alpha) {
  pushMatrix();
  translate(x, y);
  
  // Mengatur alpha untuk efek fading
  tint(255, alpha); // Gunakan nilai alpha untuk efek transparansi
  
  // Tubuh dengan motif polkadot
  fill(255, 182, 193);
  noStroke();
  rect(-15, -30, 30, 60, 10);
  
  // Motif polkadot
  fill(255, 0, 0);
  ellipse(-5, -15, 4, 4); // Titik 1
  ellipse(5, -10, 4, 4); // Titik 2
  ellipse(0, 0, 4, 4); // Titik 3
  ellipse(7, 5, 4, 4); // Titik 4
  ellipse(1, 9, 4, 4); // Titik 5
  
  // Kepala
  fill(255, 182, 193);
  ellipse(0, -45, 30, 30);
  
  // Mata
  fill(0);
  ellipse(-5, -50, 5, 5);
  ellipse(5, -50, 5, 5);
  
  // Mulut
  ellipse(0, -40, 10, 5);
  
  // Bungkusan
  stroke(255, 182, 193);
  strokeWeight(2);
  
  // Segitiga di atas kepala
  fill(255, 182, 193);
  triangle(-15, -75, 15, -75, 0, -60); // Sudut lancip di bawah
  
  // Segitiga di bawah kaki
  triangle(-10, 45, 0, 25, 10, 45); // Menyesuaikan posisi segitiga di bawah kaki
  
  popMatrix();
}

// Fungsi untuk menggambar bintang laut
void drawStarfish(float x, float y) {
  fill(255, 105, 180); // Warna merah muda untuk bintang laut
  noStroke();
  beginShape();
  for (int i = 0; i < 5; i++) {
    float angle = TWO_PI / 5 * i;
    float xOffset = cos(angle) * 20;
    float yOffset = sin(angle) * 20;
    vertex(x + xOffset, y + yOffset);
  }
  endShape(CLOSE);
}

// Fungsi untuk menggambar kerang
void drawShell(float x, float y) {
  fill(255, 228, 181); // Warna krem untuk kerang
  noStroke();
  arc(x, y, 50, 50, PI, TWO_PI); // Setengah lingkaran
  for (int i = 0; i < 5; i++) {
    float xOffset = cos(PI / 4 * i) * 25;
    float yOffset = sin(PI / 4 * i) * 25;
    line(x, y, x + xOffset, y - yOffset); // Gambar garis ke luar dari pusat
  }
}

// Menggambar ubur-ubur
float jellyfishX = 600;
float jellyfishY = 100;
float jellyfishSpeed = 0.5;

void drawJellyfish(float x, float y) {
  fill(240, 128, 128, 150); // Warna merah muda dengan transparansi untuk ubur-ubur
  noStroke();
  ellipse(x, y, 60, 40); // Kepala ubur-ubur
  for (int i = 0; i < 5; i++) {
    float tentacleX = x - 20 + i * 10;
    float tentacleY1 = y + 20;
    float tentacleY2 = y + 40;
    line(tentacleX, tentacleY1, tentacleX, tentacleY2); // Gambar tentakel
  }
}

void moveJellyfish() {
  jellyfishY += jellyfishSpeed;
  if (jellyfishY > height - 60 || jellyfishY < 60) {
    jellyfishSpeed *= -1; // Ubah arah gerakan ketika mencapai batas atas atau bawah
  }
}

// Fungsi untuk menampilkan teks dengan efek fade in
void drawText(float alpha) {
  fill(255, 255, 255, alpha); // Warna putih dengan transparansi yang dikendalikan oleh alpha
  textSize(32); // Ukuran teks
  textAlign(CENTER, CENTER);
  text("Jangan membully makhluk ciptaan tuhan, karena kita tidak pernah tahu latar belakang mereka.", width / 2, height / 2); // Menampilkan teks di tengah layar
}

// Fungsi untuk memulai menampilkan teks (misalnya, bisa dipanggil saat suatu event terjadi)
void startShowText() {
  showText = true;
}

// Untuk menguji, panggil fungsi ini di setup() atau draw()
void mousePressed() {
  startShowText();
}
}
