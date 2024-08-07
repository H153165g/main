class Basket {
  float bx, by;
  int bw, bh;
  String fn;
  PImage img;
  color fallbackColor;

  Basket(float bx, float by, int bw, int bh, String fn, PImage img, color fallbackColor) {
    this.bx = bx;
    this.by = by;
    this.bw = bw;
    this.bh = bh;
    this.fn = fn;
    this.img = img;
    this.fallbackColor = fallbackColor;
  }

  void display() {
    if (img != null) {
      image(img, bx, by, bw, bh);
    } else {
      fill(fallbackColor);
      rect(bx, by, bw, bh);
    }
  }

  boolean collect(Fruits fruit) {
    // フルーツがバスケットの範囲内にあるかどうかをチェック
    return (fruit.x + fruit.fw > bx &&
      fruit.x < bx + bw &&
      fruit.y + fruit.fh > by &&
      fruit.y < by + bh);
  }
}
