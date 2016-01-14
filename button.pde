class RButton {
  int _width; 
  int _length; 
  String text; 
  PVector position; 
  
  RButton (int w, int l, String _text, PVector pos) {
    _width = w; 
    _length = l; 
    text = _text; 
    position = pos; 
  }
  
  void display() {
    if (mouseHover()) {
      stroke(0); 
      fill (200); 
      rect (position.x, position.y, _width, _length, _width/20); 
    
      textSize (_length/3 -2);
      fill (0); 
      text (text, position.x + _width/10, position.y + 2*_length/3); 
    }
    else {
      stroke(0); 
      fill (255); 
      rect (position.x, position.y, _width, _length, _width/20); 
      
      textSize (_length/3 -2);
      fill (0); 
      text (text, position.x + _width/10, position.y + 2*_length/3); 
    }
  }
  
  boolean mouseHover() {
    return (mouseX > position.x && mouseX < position.x + _width && mouseY > position.y && mouseY < position.y +_length);
  }
}