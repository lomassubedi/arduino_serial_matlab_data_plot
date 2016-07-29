void setup() {
  Serial.begin(38400); 
} 
void loop() { 
  int a = analogRead(A0); 
  Serial.println(a); 
  delay(80); 
}
