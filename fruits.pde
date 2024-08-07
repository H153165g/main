class Fruits {
  float x, y;
  int dy;
  int fw, fh;
  PImage img;
  color fallbackColor;
  boolean dragging = false; // ドラッグ中かどうかを示すフラグ
  float offsetX, offsetY; // ドラッグのオフセット

  Fruits(float x, float y, int dy, int fw, int fh, PImage img, color fallbackColor) {
    this.x = x;
    this.y = y;
    this.dy = dy;
    this.fw = fw;
    this.fh = fh;
    this.img = img;
    this.fallbackColor = fallbackColor;
  }

  void display() {
    if (img != null) {
      image(img, x, y, fw, fh);
    } else {
      fill(fallbackColor);
      rect(x, y, fw, fh);
    }
  }

  void fall() {
    if (!dragging) { // ドラッグ中は落下しない
      y += dy;
    }
  }

  boolean isCollidingWith(Basket basket) {
    return (x < basket.bx + basket.bw &&
      x + fw > basket.bx &&
      y + fh > basket.by &&
      y < basket.by + basket.bh);
  }

  boolean isCollidingWith(Wall wall) {
    return (x < wall.wx + wall.ww &&
      x + fw > wall.wx &&
      y < wall.wy + wall.wh &&
      y + fh > wall.wy);
  }

  void startDragging() {
    if (mouseX >= x && mouseX <= x + fw && mouseY >= y && mouseY <= y + fh) {
      dragging = true;
      offsetX = mouseX - x;
      offsetY = mouseY - y;
    }
  }

  void drag() {
    if (dragging) {
      x = mouseX - offsetX;
      y = mouseY - offsetY;
    }
  }

  void stopDragging() {
    dragging = false;
  }
}
