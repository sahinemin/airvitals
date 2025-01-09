#include <Arduino.h>
#if defined(ESP32)
#include <WiFi.h>
#elif defined(ESP8266)
#include <ESP8266WiFi.h>
#endif
#include <Firebase_ESP_Client.h>
#include "Network.h"

// For proper connection to the Firebase database
#include "addons/TokenHelper.h"
#include "addons/RTDBHelper.h"

// User credentials
#define USER_EMAIL      "agu@test.com"
#define PASSWORD        "Aa123456."
#define ROOM_NAME       "SogukHava"

// Your network credentials
#define WIFI_SSID       "AGU-Student"
#define WIFI_PASSWORD   "Un7a38uN"

// Firebase project API key
#define API_KEY         "AIzaSyACAwMuIerLkFM9KbsxWclouUmdAmqivbY"

// Your Firebase Realtime Database URL
#define DATABASE_URL    "https://airvitals-project-default-rtdb.firebaseio.com/"

// Create a Firebase Data object
FirebaseData fbdo;
// Auth and config objects
FirebaseAuth auth;
FirebaseConfig config;

// Global variables
unsigned long sendDataPrevMillis = 0; 
String uid;                         

Network::Network() { }

void Network::Networkinit() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to the network");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected. IP Address: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  // Assign the API key
  config.api_key = API_KEY;

  // Assign the database URL
  config.database_url = DATABASE_URL;

  // Provide user credentials
  auth.user.email    = USER_EMAIL;
  auth.user.password = PASSWORD;

  // Token-related callback function
  config.token_status_callback = tokenStatusCallback;

  // Allow automatic Wi-Fi reconnection
  Firebase.reconnectWiFi(true);

  // Initialize Firebase
  Firebase.begin(&config, &auth);

  // Retrieve the user’s UID from the auth token
  uid = auth.token.uid.c_str();
  Serial.println("User UID: " + uid);
}

void Network::Networksend(float h, float tc, float tf) {
  // Send data every 15 seconds
  if (Firebase.ready() && (millis() - sendDataPrevMillis > 15000 || sendDataPrevMillis == 0)) {
    sendDataPrevMillis = millis();

    String dataPath = uid + "/rooms"+ "/" + ROOM_NAME + "/";
    
    // Build database paths dynamically using the UID
    String humidityPath    = dataPath+ "/humidity";
    String temperaturePath = dataPath+ "/temperature";
    
    // Send humidity data
    if (Firebase.RTDB.setInt(&fbdo, humidityPath,h)) {
      Serial.println("Humidity data written successfully.");
      Serial.println("Path: " + fbdo.dataPath());
      Serial.println("Data type: " + fbdo.dataType());
    } else {
      Serial.println("Error writing humidity data.");
      Serial.println("Reason: " + fbdo.errorReason());
    }

    // Send temperature data
    if (Firebase.RTDB.setInt(&fbdo, temperaturePath, tc)) {
      Serial.println("Temperature data written successfully.");
      Serial.println("Path: " + fbdo.dataPath());
      Serial.println("Data type: " + fbdo.dataType());
    } else {
      Serial.println("Error writing temperature data.");
      Serial.println("Reason: " + fbdo.errorReason());
    }
  }
}
