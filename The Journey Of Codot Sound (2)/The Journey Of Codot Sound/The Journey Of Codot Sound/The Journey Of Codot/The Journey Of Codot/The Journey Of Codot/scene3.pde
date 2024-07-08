class Scene4 {
  int scene = 4;
  float t = 0; // time for animation
  float[] x = {700}; // initial x positions for the teenagers
  float[] cloudX = {200, 600, 400}; // initial x positions for the clouds
  float[] cloudY = {200, 150, 100};
  float cloudSpeed = 0.5; // speed of the clouds
  // Variables to store bird positions
  float birdX1, birdY1;
  float birdX2, birdY2;
  float birdSpeed = 1.5; // Bird speed

  // Unique attributes for each teenager
  color[] bodyColors = {color(255, 204, 0)};
  float[] bodyHeights = {50};
  float[] headSizes = {20};
  color[] hairColors = {color(0)};

  // Global variables for pocong position, movement, and fading effect
  float pocongX = 160; // Initial X position of pocong
  float pocongY = height / 2 + 230; // Initial Y position of pocong
  float pocongSpeed = 0.5; // Horizontal movement speed of pocong
  float jumpAmplitude = 5; // Jump amplitude
  float jumpSpeed = 0.1; // Jump frequency
  float pocongAlpha = 0; // Alpha for fading effect
  boolean pocongVisible = false; // Indicates if pocong is visible
  int frameCount = 0;
  int numClouds = 3;

  // Stop point for pocong at the end of the rightmost tree row with additional right offset
  float stopPointX = 50 + 4 * 70 + 60; // X position of the rightmost tree in the front row plus offset
  float stopPointY = height / 2 + 200; // Y position of the rightmost tree in the front row

  // Array to store distances traveled by each character
  float[] distanceTraveled;

  Scene4() {
    distanceTraveled = new float[x.length]; // Initialize array for each character
    // Initialize bird positions
    birdX1 = 200;
    birdY1 = 100;
    birdX2 = 600;
    birdY2 = 200;
  }

  void display() {
    drawSky();
    drawGround();
    drawSun(); // Change drawSun() to drawMoon()
    drawClouds(); // Keep drawing clouds
    drawTrees(); // Keep drawing trees
    drawTeenagers(); // Draw teenagers
    moveBird();
    drawBird(birdX1, birdY1); // Draw first bird
    drawBird(birdX2, birdY2); // Draw second bird

    // Move pocong and animate jumping
    if (pocongX < stopPointX) {
      pocongX += pocongSpeed;
      pocongY = height / 2 + 230 + sin(frameCount * jumpSpeed) * jumpAmplitude;
      frameCount++;
    }

    // Logic for randomly appearing pocong
    if (pocongAlpha < 255) { // If pocong is not fully visible
      pocongAlpha += 0.5; // Gradually increase alpha
    }

    if (pocongAlpha > 0) { // If pocong is not transparent
      fill(255, 182, 193, pocongAlpha); // Pocong color with changing alpha
      noStroke();

      // Draw pocong with adjusted position, scale, and alpha
      drawPocong(pocongX, pocongY, 0.8, pocongAlpha);
    }
  }

  void drawSky() {
    background(25, 25, 112); // Dark blue for approaching night sky
  }

  void drawGround() {
    fill(100, 50, 0); // Brown color for forest ground
    noStroke();
    rect(0, height / 2, width, height / 2); // Bottom half of the screen
  }

  void drawSun() {
    fill(255, 165, 0); // Orange color for setting sun
    noStroke();
    ellipse(700, 100, 100, 100); // Draw sun at the same position as before
  }

  void drawClouds() {
    // Draw each cloud using drawCloud function
    for (int i = 0; i < numClouds; i++) {
      drawCloud(cloudX[i], cloudY[i], 1.5);

      // Update cloud positions
      cloudX[i] += cloudSpeed;

      // Reset cloud position if it moves off screen
      if (cloudX[i] > width + 50) {
        cloudX[i] = -50;
      }
    }
  }

  void drawCloud(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    fill(150);
    noStroke();
    ellipse(0, 0, 50, 50);
    ellipse(20, 0, 50, 50);
    ellipse(40, 0, 50, 50);
    ellipse(20, -20, 50, 50);
    popMatrix();
  }

  void drawTrees() {
    float startXTrees = 50; // Starting from left edge of screen for trees
    float startYTrees = height / 2 + 200; // Lower on the ground
    float treeSpacing = 70; // Reduced tree spacing for denser forest
    float treeHeight = 100; // Tree height

    for (int i = 0; i < 3; i++) { // 3 rows of trees horizontally
      for (int j = 0; j < 5; j++) { // Draw 5 trees on the left side of screen only
        float offsetXTrees = j * treeSpacing; // Horizontal distance between trees
        float offsetYTrees = i * 80; // Vertical distance between tree rows tighter
        drawTree(startXTrees + offsetXTrees, startYTrees + offsetYTrees, treeHeight);
      }
    }
  }

  void drawTree(float x, float y, float height) {
    pushMatrix();
    translate(x, y);

    // Tree trunk
    fill(139, 69, 19); // Dark brown
    rect(-5, 0, 10, -height);

    // Tree leaves
    fill(34, 139, 34); // Leaf green
    ellipse(0, -height, 80, 80);
    ellipse(-20, -height - 20, 60, 60);
    ellipse(20, -height - 20, 60, 60);

    popMatrix();
  }

  void drawTeenager(float x, float y, color bodyColor, float bodyHeight, float headSize, color hairColor) {
    float armSwing = sin(frameCount * 0.1) * 2;
    float legSwing = cos(frameCount * 0.1) * 2;

    // Draw body
    fill(bodyColor);
    rect(x - 10, y, 20, bodyHeight); // body

    // Draw head
    fill(255, 220, 177);
    ellipse(x, y - 20, headSize, headSize); // head

    // Draw facial details
    fill(0);
    ellipse(x - 4, y - 22, 3, 3); // eye

    // Draw hair
    fill(hairColor);
    arc(x, y - 27, 25, 15, PI, TWO_PI);

    // Draw arms (reverse direction for left and right arms)
    fill(bodyColor);
    pushMatrix();
    translate(x - 15, y + 10);
    rotate(radians(-armSwing)); // Negate arm swing for left arm
    rect(0, 0, 10, 30); // left arm
    popMatrix();

    pushMatrix();
    translate(x + 5, y + 10);
    rotate(radians(armSwing)); // Positive arm swing for right arm
    rect(0, 0, 10, 30); // right arm
    popMatrix();

    // Draw legs (reverse direction for left and right legs)
    fill(0);
    pushMatrix();
    translate(x - 5, y + bodyHeight);
    rotate(radians(-legSwing)); // Negate leg swing for left leg
    rect(0, 0, 10, 30); // left leg
    popMatrix();

    pushMatrix();
    translate(x + 5, y + bodyHeight);
    rotate(radians(legSwing)); // Positive leg swing for right leg
    rect(0, 0, 10, 30); // right leg
    popMatrix();
  }

  void drawTeenagers() {
    for (int i = 0; i < x.length; i++) {
      // Determine orientation based on movement direction
      float scaleX = (x[i] < width) ? 1 : -1; // Flip if moving left

      pushMatrix();
      translate(x[i], height * 0.75 - 50);
      scale(scaleX, 1); // Scale to flip horizontally if moving left

      // Draw the teenager
      drawTeenager(0, 0, bodyColors[i], bodyHeights[i], headSizes[i], hairColors[i]);

      popMatrix();

      // Update position based on movement direction
      x[i] -= 1; // Move left

      // Calculate arm and leg swing
      float armSwing = sin(frameCount * 0.1) * 20;
      float legSwing = cos(frameCount * 0.1) * 20;

      // Stop when arm and leg swing stop
      if (x[i] <= width * 3 / 4) {
        x[i] = width * 3 / 4; // Ensure character stops at the middle of the screen
      }
    }
  }

  void drawPocong(float x, float y, float scale, float alpha) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Set alpha for fading effect
    tint(255, alpha); // Use alpha value for transparency effect

    // Body with polkadot pattern
    fill(255, 182, 193, alpha);
    noStroke();
    rect(-15, -30, 30, 60, 10);

    // Polkadot pattern
    fill(255, 0, 0, alpha);
    ellipse(-5, -15, 4, 4); // Dot 1
    ellipse(5, -10, 4, 4); // Dot 2
    ellipse(0, 0, 4, 4); // Dot 3
    ellipse(7, 5, 4, 4); // Dot 4
    ellipse(1, 9, 4, 4); // Dot 5

    // Head
    fill(255, 182, 193, alpha);
    ellipse(0, -45, 30, 30);

    // Eyes
    fill(0, alpha);
    ellipse(-5, -50, 5, 5);
    ellipse(5, -50, 5, 5);

    // Mouth
    fill(0, alpha);
    ellipse(0, -40, 10, 5);

    // Wrapping
    stroke(255, 182, 193, alpha);
    strokeWeight(2);

    // Triangle above head
    fill(255, 182, 193, alpha);
    triangle(-15, -75, 15, -75, 0, -60); // Sharp angle below

    // Triangle below feet
    triangle(-10, 45, 0, 25, 10, 40); // Adjusting position of triangle below feet

    popMatrix();
  }

  void drawBird(float x, float y) {
    // Draw bird shape
    pushMatrix();
    translate(x, y); // Translate to bird position

    fill(255, 215, 0); // Yellow color for bird body
    ellipse(0, 0, 30, 15); // Body

    fill(0); // Black color for wing
    beginShape();
    vertex(-15, 0);
    vertex(0, -30);
    vertex(0, 0);
    endShape(CLOSE); // Wing

    fill(255); // White color for eye
    ellipse(10, -3, 8, 8); // Eye

    popMatrix();
  }

  void moveBird() {
    // Move birds at a specific speed
    birdX1 += birdSpeed;
    birdX2 += birdSpeed;

    // Reset bird position when it exceeds the right screen boundary
    if (birdX1 > width + 20) {
      birdX1 = -20;
      birdY1 = random(50, height/2 - 50); // Randomize height within sky range
    }
    if (birdX2 > width + 20) {
      birdX2 = -20;
      birdY2 = random(50, height/2 - 50); // Randomize height within sky range
    }
  }
}
