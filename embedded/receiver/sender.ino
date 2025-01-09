#include <Arduino.h>
#include <SoftwareSerial.h>
#include <ArduinoJson.h>

// Include your new Network class
#include "Network.h"

// -------------------------------------------------------------------
// LoRa module pins
// Adjust if needed for your hardware
#define TX_PIN 17
#define RX_PIN 16

SoftwareSerial mySerial(TX_PIN, RX_PIN); // LoRa serial
DynamicJsonDocument doc(2048);

String LoRaData;
float h = 0.0, tc = 0.0, tf = 0.0;

// Create a global Network object
Network network;

// -------------------------------------------------------------------
// Function Prototypes
void initializeLora();
void readPacket();
void deserializePacket(const String &jsonPacket);

// -------------------------------------------------------------------
void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  Serial.print("hello");
  // Initialize Wi-Fi and Firebase (handled in Network class)
  //network.initWiFi();
  network.Networkinit();
  

  //network.firestoreDataAdd(23, 36);
  // Initialize LoRa
  //initializeLora();
}

// -------------------------------------------------------------------
void loop() {
  readPacket();
  delay(50);
  
}

// -------------------------------------------------------------------
// Initialize LoRa communication
void initializeLora() {
  Serial.println("LoRa Initializing...");
  mySerial.write("AT+MODE=FU3\r\n");  // Example command for your LoRa module
  delay(100);
  Serial.println("LoRa Initialized!");
}

// -------------------------------------------------------------------
// Read LoRa packet from software serial
void readPacket() {
  if (mySerial.available()) {
    LoRaData = mySerial.readStringUntil('\n');
    Serial.print("Received packet: ");
    Serial.println(LoRaData);

    // Parse JSON from the received string
    deserializePacket(LoRaData);
  }
}


// Deserialize the JSON payload (humidity, temperature, etc.)
// and send it to Firestore via the Network class
void deserializePacket(const String &jsonPacket) {

  
  DeserializationError error = deserializeJson(doc, jsonPacket);
  if (error) {
    Serial.print("deserializeJson() failed: ");
    Serial.println(error.f_str());
    return;
  }

  // Extract sensor data with a default fallback (e.g. 0.0)
  h  = doc["Humidity"]       | 0.0;
  tc = doc["Temperature_C"]  | 0.0;
  tf = doc["Temperature_F"]  | 0.0;

  network.Networksend( h, tc, tf);

  Serial.printf("Humidity: %.2f\n", h);
  Serial.printf("Temperature_C: %.2f\n", tc);
  Serial.printf("Temperature_F: %.2f\n", tf);

  // Now send to Firestore:
  //   The new `Network::firestoreDataAdd(temp, humi)` typically expects
  //   "temp" as Celsius, "humi" as humidity. 
  //   The method in Network.cpp can calculate Fahrenheit on its own if needed.

}