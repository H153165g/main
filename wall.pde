class Wall {
  float wx, wy, ww, wh;

  Wall(float wx, float wy, float ww, float wh) {
    this.wx = wx;
    this.wy = wy;
    this.ww = ww;
    this.wh = wh;
  }

  boolean collision(Fruits fruit) {
    return (fruit.x + fruit.fw > wx && fruit.x < wx + ww && fruit.y + fruit.fh > wy && fruit.y < wy + wh);
  }
}
