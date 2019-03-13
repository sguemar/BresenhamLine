int pixelSize = 50, panelShift = 50;
int x1, y1, x2, y2;
int points = 0;
boolean mainScreen = true;

void setup() {
  size(1200, 800);
  mainScreen();
}

void draw() {
}

void keyPressed() {
  if (key == 'H' || key == 'h') {
    mainScreen = true;
    mainScreen();
  }

  if (!mainScreen && (key == 'L' || key == 'l'))
    if (points == 2) {
      bresenhamLine(x1, y1, x2, y2);
      drawIdealLine(x1, y1, x2, y2);
    }

  if (key == 'R' || key == 'r') {
    points = 0;
    mainScreen = false;
    drawGrid();
  }
}

void mousePressed() {
  if (!mainScreen && mouseX >= panelShift && mouseY >= panelShift) {
    if (points == 0) {
      x1 = mouseX / pixelSize;
      y1 = mouseY / pixelSize;
      points++;
      paintPixel(x1, y1);
    } else if (points == 1) {
      x2 = mouseX / pixelSize;
      y2 = mouseY / pixelSize;
      if (x2 != x1 || y2 != y1) {
        points++;
        paintPixel(x2, y2);
      }
    }
  }
}

void bresenhamLine(int x1, int y1, int x2, int y2) {
  int differenceX = (x2 - x1);
  int differenceY = (y2 - y1);

  int incXI, incYI, incXR, incYR;

  if (differenceY >= 0)
    incYI = 1;
  else {
    differenceY = -differenceY;
    incYI = -1;
  }

  if (differenceX >= 0)
    incXI = 1;
  else {
    differenceX = -differenceX;
    incXI = -1;
  }

  if (differenceX >= differenceY) {
    incYR = 0;
    incXR = incXI;
  } else {
    incXR = 0;
    incYR = incYI;
    int k = differenceX;
    differenceX = differenceY;
    differenceY = k;
  }

  int x = x1, y = y1;
  int aVR = 2 * differenceY;
  int aV = aVR - differenceX;
  int aVI = aV - differenceX;

  do {
    paintPixel(x, y);

    if (aV >= 0) {
      x = x + incXI;
      y = y + incYI;
      aV = aV + aVI;
    } else {
      x = x + incXR;
      y = y + incYR;
      aV = aV + aVR;
    }
  } while (x != x2 || y != y2);

  paintPixel(x2, y2);
}

void drawIdealLine(int x1, int y1, int x2, int y2) {
  x1 = x1 * pixelSize + pixelSize / 2;
  x2 = x2 * pixelSize + pixelSize / 2;
  y1 = y1 * pixelSize + pixelSize / 2;
  y2 = y2 * pixelSize + pixelSize / 2;
  line(x1, y1, x2, y2);
}

void paintPixel(int x, int y) {
  rect(x * pixelSize, y * pixelSize, pixelSize, pixelSize);
}

void drawGrid() {
  background(175);
  textSize(20);
  int numbers = 1;
  for (int i = panelShift; i < height; i += pixelSize) {
    line(panelShift, i, width, i);
    text(str(numbers++), 15, i + 30);
  }
  numbers = 1;
  for (int i = panelShift; i < width; i += pixelSize) {
    line(i, panelShift, i, height);
    text(str(numbers++), i + 15, 35);
  }
}

void mainScreen() {
  background(0);
  textSize(40);
  textAlign(CENTER);
  text("Bresenham Line", width / 2, height / 2 - 250);
  text("by", width / 2, height / 2 - 150);
  text("SAMUEL GUERRA MARRERO", width / 2, height / 2 - 50);
  textSize(30);
  text("Select two pixels with the mouse", width / 2, height / 2 + 100);
  text("Press L to draw a line", width / 2, height / 2 + 140);
  text("Press R to clean the grid", width / 2, height / 2 + 180);
  text("Press H to return to the main screen", width / 2, height / 2 + 220);
  textSize(20);
  text("Press R to continue", width / 2, height / 2 + 300);
}
