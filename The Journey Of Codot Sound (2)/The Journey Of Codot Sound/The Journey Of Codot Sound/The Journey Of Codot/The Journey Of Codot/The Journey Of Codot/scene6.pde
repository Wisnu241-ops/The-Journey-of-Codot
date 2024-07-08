class Scene7 {

  int scene = 7;
  float[] cloudX = {200, 600, 400}; // Cloud X coordinates
  float[] cloudY = {100, 150, 80}; // Cloud Y coordinates
  float[] cloudSpeedX = {1.5, 1, 0.8}; // Cloud horizontal movement speed
  float[] cloudSpeedY = {0, 0, 0}; // Cloud vertical movement speed
  float[] fishX = {100, 300, 500, 200, 400}; // Fish X coordinates
  float[] fishY = {600, 500, 800, 450, 700}; // Fish Y coordinates
  float[] fishSpeedX = {0.8, 0.6, 0.7, 0.9, 0.5}; // Fish horizontal movement speed
  float[] fishSpeedY = {0, 0, 0, 0, 0}; // Fish vertical movement speed
  int numFish = 5; // Number of fish
  int numClouds = 3; // Number of clouds
  float ghostY = 800; // Start below the screen
  boolean ghostRising = true;
  float ghostAlpha = 0; // Start with full transparency
  int ghostStartTime; // Start time for ghost appearance
  boolean ghostDisappeared = false; // Whether the ghost has disappeared
  boolean ghostLaughing = false; // Additional property for ghost mouth
  boolean pocongJumping = false; // Status for pocong jumping
  float pocongX = 290; // Initial X coordinate of pocong
  float pocongY = 255; // Initial Y coordinate of pocong
  float pocongAlpha = 255; // Pocong transparency
  float jumpHeight = 150; // Jump height
  float jumpProgress = 0; // Jump progress (0 to 1)
  boolean pocongAscending = true; // Whether pocong is ascending or descending
  boolean pocongFalling = false; // Whether pocong is falling into the ocean

  Scene7() {
    ghostStartTime = millis(); // Initialize start time for ghost
  }

  void draw() {
    display();
  }

  void display() {
    drawSky();
    drawOcean();
    drawCliff();
    drawMoon(); // Replace drawSun() with drawMoon()
    drawClouds(); // Keep drawing clouds
    drawTrees(); // Keep drawing trees
    
    // Call drawPocong with specified position and scale
    if (pocongJumping) {
      jumpProgress += 0.02; // Jump progress speed

      if (pocongAscending) {
        pocongY = 255 - jumpHeight * sin(PI * jumpProgress);
        pocongX += 2; // Horizontal speed
        if (jumpProgress >= 0.5) {
          pocongAscending = false;
        }
      } else {
        pocongY = 255 - jumpHeight * sin(PI * jumpProgress);
        pocongX += 2; // Horizontal speed
        if (jumpProgress >= 1) {
          pocongJumping = false;
          pocongFalling = true;
          jumpProgress = 0;
        }
      }

      pocongAlpha = 255 * (1 - jumpProgress); // Gradually decrease transparency
    }

    if (pocongFalling) {
      pocongY += 2; // Falling speed into the ocean
      pocongAlpha -= 1; // Gradually decrease transparency

      if (pocongAlpha <= 0) {
        pocongFalling = false;
        pocongAlpha = 255;
        pocongY = 255;
        pocongX = 290;
        pocongAscending = true;
      }
    }
    
    drawPocong(pocongX, pocongY, 1, pocongAlpha);
    
    // Call drawGhost with rising animation from the ocean
    if (ghostRising && ghostY > 420) { // Adjust target height to match pocong position
      ghostY -= 1; // Adjust speed as necessary
      // Add water splash effect as the ghost rises
      drawSplash(width / 2, ghostY + 30);
    }
  
    // Gradually increase ghost transparency
    if (ghostAlpha < 255 && !ghostDisappeared) {
      ghostAlpha += 1; // Adjust speed as necessary
    }
  
    // Check if 5 seconds have passed since ghost appeared
    if (millis() - ghostStartTime > 5000 && !ghostDisappeared) {
      ghostLaughing = true; // Ghost starts laughing
      ghostAlpha -= 1; // Ghost starts disappearing
    
      if (ghostAlpha <= 0) {
        ghostRising = false; // Stop ghost movement
        ghostDisappeared = true; // Mark ghost as disappeared
        pocongJumping = true; // Pocong starts jumping
      }
    }
    
    drawGhost(400, ghostY, 1, ghostAlpha); // Draw ghost with transparency
  }

  void drawSky() {
    background(0); // Black color for the night sky
    
    // Draw stars only in the top half of the screen (sky)
    drawStars(0, 0, width, height / 2);
  }

  void drawStars(float xStart, float yStart, float xEnd, float yEnd) {
    randomSeed(10); // To generate random but consistent star coordinates
    
    fill(255); // White color for stars
    
    // Draw 50 stars in the top half of the screen
    for (int i = 0; i < 50; i++) {
      float x = random(xStart, xEnd); // Random X coordinate between xStart and xEnd
      float y = random(yStart, yEnd); // Random Y coordinate between yStart and yEnd
      ellipse(x, y, 2, 2); // Draw star as small ellipse
    }
  }

  void drawOcean() {
    fill(0, 0, 139); // Dark blue color for the ocean
    noStroke();
    rect(0, height / 2, width, height / 2); // Bottom half of the screen
    
    // Create ocean wave effect
    beginShape();
    for (int x = 0; x <= width; x += 10) {
      float y = height / 2 + sin(radians(x + frameCount * 5)) * 10;
      vertex(x, y);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
    drawFish(); // Call function to draw fish
  }

  void drawCliff() {
    fill(139, 125, 107); // Darker cliff color
    noStroke();
    quad(0, height, 0, 300, 300, 300, 150, height); // Draw the cliff
  }

  void drawMoon() {
    fill(255, 255, 204); // Yellowish color for the moon
    noStroke();
    ellipse(700, 100, 100, 100); // Draw the moon at the same position as the previous sun
  }

  void drawClouds() {
    // Call drawCloud function for each cloud
    for (int i = 0; i < numClouds; i++) {
      drawCloud(cloudX[i], cloudY[i], 1.5);

      // Update cloud positions
      cloudX[i] += cloudSpeedX[i];
      cloudY[i] += cloudSpeedY[i];

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
    // Draw trees
    drawTree(20, 300, 100); // First tree
    drawTree(90, 300, 120); // Second tree
    drawTree(50, 300, 80); // Third tree
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

  void drawPocong(float x, float y, float scale, float alpha) {
    pushMatrix();
    translate(x, y);
    scale(scale);
    tint(255, alpha); // Set pocong transparency
    
    // Body with polkadot pattern
    fill(255, 182, 193);
    noStroke();
    rect(-15, -30, 30, 60, 10);

    // Polkadot pattern
    fill(255, 0, 0);
    ellipse(-5, -15, 4, 4); // Dot 1
    ellipse(5, -10, 4, 4); // Dot 2
    ellipse(0, 0, 4, 4); // Dot 3
    ellipse(7, 5, 4, 4); // Dot 4
    ellipse(1, 9, 4, 4); // Dot 5

    // Head
    fill(255, 182, 193);
    ellipse(0, -45, 30, 30);

    // Eyes
    fill(0);
    ellipse(-5, -50, 5, 5);
    ellipse(5, -50, 5, 5);

    // Mouth
    ellipse(0, -40, 10, 5);

    // Wrapping
    stroke(255, 182, 193);
    strokeWeight(2);

    // Triangle above head
    fill(255, 182, 193);
    triangle(-15, -75, 15, -75, 0, -60); // Sharp angle below

    // Triangle below feet
    triangle(-10, 45, 0, 25, 10, 45); // Adjusting position of triangle below feet

    popMatrix();
  }

  void drawFish() {
    // Call drawSingleFish function for each fish
    for (int i = 0; i < numFish; i++) {
      // Call function to draw a single fish
      drawSingleFish(fishX[i], fishY[i], 0.6);

      // Update fish position horizontally only
      fishX[i] += fishSpeedX[i];

      // If fish goes past the right edge of the screen, reverse direction to the left and vice versa
      if (fishX[i] > width) {
        fishSpeedX[i] = -fishSpeedX[i];
      } else if (fishX[i] < 0) {
        fishSpeedX[i] = abs(fishSpeedX[i]);
      }
    }
  }

  void drawSingleFish(float x, float y, float scale) {
    pushMatrix();
    translate(x, y);
    scale(scale);

    // Fish body
    fill(255, 165, 0); // Orange color for fish body
    ellipse(0, 0, 50, 30); // Fish body

    // Fish tail
    beginShape();
    vertex(-25, 0);
    bezierVertex(-40, -10, -40, 10, -25, 0);
    bezierVertex(-30, -5, -30, 5, -25, 0);
    endShape();

    // Tail fin
    fill(255, 140, 0); // Bright orange color for fin
    triangle(-25, -5, -25, 5, -35, 0); // Tail fin

    // Body fins
    triangle(-10, -15, 0, -5, 0, -25); // Top fin
    triangle(-10, 15, 0, 5, 0, 25); // Bottom fin

    // Eyes
    fill(0); // Black color for eyes
    ellipse(20, 0, 10, 10); // Fish eye

    popMatrix();
  }

  void drawGhost(float x, float y, float scale, float alpha) {
    pushMatrix();
    translate(x, y - 150);
    scale(scale * 0.5); // Reduce ghost size by reducing scale value

    // Ghost body with more natural shape
    fill(0, 50, 0, alpha); // Dark green color with transparency
    noStroke();
    beginShape();
    vertex(-30, -100);
    bezierVertex(-50, 0, 50, 0, 30, -100);
    endShape(CLOSE);

    // Feet with kebaya and batik pattern
    fill(255, 235, 205, alpha); // Kebaya color
    rect(-30, -50, 60, 100); // Kebaya shape

    // Batik pattern
    fill(0, 0, 139, alpha); // Dark blue color for batik pattern
    for (int i = -25; i <= 25; i += 10) {
        for (int j = -40; j <= 40; j += 10) {
            ellipse(i, j, 5, 5);
        }
    }

    // Hands with human shape
    fill(144, 238, 144, alpha); // Light green color with transparency
    beginShape();
    vertex(-40, -70); // Left hand
    vertex(-35, -40);
    vertex(-30, -50);
    vertex(-25, -40);
    vertex(-20, -50);
    vertex(-15, -40);
    vertex(-10, -50);
    vertex(-5, -40);
    vertex(0, -50);
    endShape(CLOSE);

    beginShape();
    vertex(40, -70); // Right hand
    vertex(35, -40);
    vertex(30, -50);
    vertex(25, -40);
    vertex(20, -50);
    vertex(15, -40);
    vertex(10, -50);
    vertex(5, -40);
    vertex(0, -50);
    endShape(CLOSE);

    // Long hair
    fill(210, 105, 30, alpha); // Light brown color for hair with transparency
    beginShape();
    vertex(-30, -160);
    vertex(-40, -120);
    vertex(-30, -130);
    vertex(-20, -120);
    vertex(-10, -130);
    vertex(0, -120);
    vertex(10, -130);
    vertex(20, -120);
    vertex(30, -130);
    vertex(40, -120);
    vertex(30, -160);
    endShape(CLOSE);

    // Face
    fill(255, 228, 196, alpha); // Pale skin color for face with transparency
    ellipse(0, -120, 60, 60); // Rounder face

    // Eyes
    fill(0, alpha);
    ellipse(-15, -130, 10, 10); // Left eye
    ellipse(15, -130, 10, 10); // Right eye

    // Laughing mouth
    fill(255, 0, 0, alpha);
    float mouthY = ghostLaughing ? -115 + sin(frameCount * 0.1) * 5 : -115; // Mouth movement
    ellipse(0, mouthY, 20, 10); // Red mouth

    // Fanged teeth
    fill(255, alpha);
    triangle(-5, -110, -5, -100, -2, -105); // Left fang
    triangle(5, -110, 5, -100, 2, -105); // Right fang

    popMatrix();
  }

  void drawSplash(float x, float y) {
    pushMatrix();
    translate(x, y);
    fill(255); // White color for water splash
    for (int i = 0; i < 10; i++) {
      float angle = radians(random(360));
      float distance = random(5, 20);
      ellipse(cos(angle) * distance, sin(angle) * distance, 5, 5);
    }
    popMatrix();
  }
}
