int raw;
int mapped;
void setup() {
  Serial.begin(9600);
}

void loop() {
  raw = analogRead(A2);
  mapped = map(raw, 0, 1023, 770, 10); 
  Serial.println(mapped);
  delay(100);
}
