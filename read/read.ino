//const char ADDR[] = {52,50,48,46,44,42,40,38,36,34,32,30,28,26,24,22};
const char ADDR[] = {22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52};
// const char DATA[] = {53,51,49,47,45,43,41,39};
const char DATA[] = {39,41,43,45,47,49,51,53};
#define CLOCK 2
#define R_W 3
void setup(){
  for (int n= 0; n<16; n+=1){
    pinMode(ADDR[n],INPUT);
  }
  for(int n=0; n<8; n+=1){
   pinMode(DATA[n],INPUT);
 }
  pinMode(R_W,INPUT);
  pinMode(CLOCK,INPUT);
  attachInterrupt(digitalPinToInterrupt(CLOCK), onClock, RISING);
  Serial.begin(57600);
}

void onClock(){
  char output[15];
  unsigned int address = 0;
  for(int n=0; n<16; n+=1){
    int bit = digitalRead(ADDR[n]) ? 1:0;
    Serial.print(bit);
    address=(address<<1) + bit;
  }
  Serial.println();
  Serial.print("    ");
  unsigned int data = 0;
  for(int n=0; n<8; n+=1){
    int bit = digitalRead(DATA[n]) ? 1:0;
    Serial.print(bit);
    data =(data<<1) + bit;  // shift the data one bit and add a new bit and forms a string on 8 bits
  }  
  sprintf(output, "    %04x   %c  %02x  ", address,digitalRead(R_W) ? 'r' : 'W' ,data);
  Serial.println(output);
}

void loop(){
//   for(int n=0; n<16; n+=1){
//   int bit = digitalRead(ADDR[n]) ? 1:0;
//   Serial.print(bit);
//   }
//   Serial.println();
}