#include <SoftwareSerial.h>
#include "DHT.h"
#include <ArduinoJson.h>
#include <LiquidCrystal.h>

// Define DHT sensor pin and type
#define DHTPIN 13
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

// Define the pins used by the E32 433T20D LoRa module
#define TX_PIN 8
#define RX_PIN 9

SoftwareSerial mySerial(TX_PIN, RX_PIN); // SoftwareSerial for E32 433T20D

// Create a JSON document to hold the incoming data
DynamicJsonDocument doc(2048);

// Initialize the LCD (RS, EN, D4, D5, D6, D7)
LiquidCrystal lcd(12, 11, 5, 4, 3, 2);

// Function prototypes
void initializeLora();
void sendPacket(String data);
void pushJsonDoc(String name, float data);

// =========================================================

void setup() {
  Serial.begin(9600);       // Start Serial communication
  mySerial.begin(9600);     // Start LoRa communication
  dht.begin();              // Initialize the DHT sensor

  // Initialize the LCD
  lcd.begin(16, 2);         // Set up the LCD's number of columns and rows
  lcd.print("Initializing...");
  delay(2000);
  lcd.clear();

  // Initialize LoRa module
  initializeLora();
  lcd.print("LoRa Ready!");
  delay(2000);
  lcd.clear();
}

// =========================================================

void loop() {
  float h = dht.readHumidity();      // Read humidity
  float t = dht.readTemperature();  // Read temperature in Celsius
  float f = dht.readTemperature(true); // Read temperature in Fahrenheit
  
  // Check if reading failed
  if (isnan(h) || isnan(t) || isnan(f)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    lcd.clear();
    lcd.print("Sensor Error!");
    delay(2000);
    return;
  }

  // Print to Serial Monitor
  Serial.print(F("Humidity: "));
  Serial.print(h);
  Serial.print(F("%  Temperature: "));
  Serial.print(t);
  Serial.print(F("°C "));
  Serial.print(f);
  Serial.println(F("°F"));

  // Display on LCD
  lcd.clear();
  lcd.setCursor(0, 0); // Set cursor to the first row
  lcd.print("Temperature ");
  lcd.print(t, 1); // Show Celsius
  lcd.print("C");
 // lcd.print(f, 1); // Show Fahrenheit
  //lcd.print("F");

  lcd.setCursor(0, 1); // Set cursor to the second row
  lcd.print("Humidity ");
  lcd.print(h, 1); // Show humidity
  lcd.print("%");

  // Prepare JSON and send via LoRa
  pushJsonDoc("Humidity", h);
  pushJsonDoc("Temperature_C", t);
  pushJsonDoc("Temperature_F", f);
  String jsonPacket;
  serializeJson(doc, jsonPacket);
  Serial.print("Send LoRa JSON : ");
  Serial.println(jsonPacket);
  sendPacket(jsonPacket);

  delay(5000);
}

// =========================================================

// Initialize the LoRa module
void initializeLora() {
  Serial.println("Initializing LoRa...");
  mySerial.write("AT+MODE=FU3\r\n"); // Set to Mode FU3 (default)
  delay(100);
  Serial.println("LoRa Initializing Successful!");
}

// =========================================================

// Send a packet via LoRa
void sendPacket(String data) {
  mySerial.print(data);
}

// =========================================================

// Add data to the JSON Document
void pushJsonDoc(String name, float data) {
  doc[name] = data;
}
