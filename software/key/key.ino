// Display
#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SharpMem.h>

#define DISPLAY_SCK A5
#define DISPLAY_MOSI A4
#define DISPLAY_SS A3

Adafruit_SharpMem display(DISPLAY_SCK, DISPLAY_MOSI, DISPLAY_SS);

#define BLACK 0
#define WHITE 1

// Bluetooth
#include <Arduino.h>
#if not defined (_VARIANT_ARDUINO_DUE_X_) && not defined (_VARIANT_ARDUINO_ZERO_)
  #include <SoftwareSerial.h>
#endif

#include "Adafruit_BLE.h"
#include "Adafruit_BluefruitLE_SPI.h"
#include "Adafruit_BluefruitLE_UART.h"

#include "BluefruitConfig.h"

#define FACTORYRESET_ENABLE         1
#define MINIMUM_FIRMWARE_VERSION    "0.6.6"
#define MODE_LED_BEHAVIOUR          "DISABLE"

Adafruit_BluefruitLE_SPI ble(BLUEFRUIT_SPI_CS, BLUEFRUIT_SPI_IRQ, BLUEFRUIT_SPI_RST);

// App
enum CurrentState {
  SLEEPING,
  LOADING,
  ACTIVE
};

int loadingIndicatorRadius = 1;

CurrentState currentState = SLEEPING;
String receiveBuffer = "";
String dataName = "";
String dataCategory = "";
String dataAmount = "";

void error(const __FlashStringHelper*err) {
  Serial.println(err);
  while (1);
}

void setupDisplay() {
  display.begin();
  display.setRotation(1);
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(BLACK);
  display.setCursor(0, 0);
}

void setupBluetooth(void) {
  updateDisplay("Initializing");
  
  Serial.print(F("Initialising the Bluefruit LE module: "));

  if (!ble.begin(VERBOSE_MODE)) {
    updateDisplay("Test 3");
    updateDisplay("Bluetooth module error");
    error(F("Couldn't find Bluefruit, make sure it's in CoMmanD mode & check wiring?"));
  }
  
  Serial.println(F("OK!"));
  updateDisplay("Done");

  if (FACTORYRESET_ENABLE) {
    Serial.println(F("Performing a factory reset: "));
    if (!ble.factoryReset()) {
      error(F("Couldn't factory reset"));
    }
  }
  
  ble.echo(false);
  ble.verbose(false);
  updateDisplay("Ready for connection!");
  Serial.println(F("Waiting for Bluetooth connection"));

  /* Wait for connection */
  while (!ble.isConnected()) {
      delay(500);
  }

  Serial.println(F("******************************"));
  
  if (ble.isVersionAtLeast(MINIMUM_FIRMWARE_VERSION)) {
    Serial.println(F("Change LED activity to " MODE_LED_BEHAVIOUR));
    ble.sendCommandCheckOK("AT+HWModeLED=" MODE_LED_BEHAVIOUR);
  }

  // Set module to DATA mode
  Serial.println(F("Switching to DATA mode!"));
  ble.setMode(BLUEFRUIT_MODE_DATA);

  Serial.println(F("******************************"));

  updateDisplay("Connected");

  delay(500);
}

void setup(void) 
{
  Serial.begin(115200);

  // Disable bluetooth via SS
  pinMode(BLUEFRUIT_SPI_CS, OUTPUT);
  digitalWrite(BLUEFRUIT_SPI_CS, HIGH);

  // Disable display via SS
  pinMode(DISPLAY_SS, OUTPUT);
  digitalWrite(DISPLAY_SS, HIGH);
  
  setupDisplay();
  setupBluetooth();

  updateDisplay("Tesla Key 1.0");
}

void loop(void) 
{
  receiveData();
  
  switch (currentState) {
    case SLEEPING:
      // TODO
      break;

    case LOADING:
      receiveData();
      updateLoadingAnimation();
      break;

    case ACTIVE:
      receiveData();
      display.refresh();
      delay(500);
      break;
  }
}

void updateLoadingAnimation() {
  display.fillCircle(display.width() / 2, display.height() / 2, ++loadingIndicatorRadius, BLACK);
  display.refresh();

  if (loadingIndicatorRadius > 27) {
    loadingIndicatorRadius = 0;
    display.clearDisplay();
  }
  
  delay(100);
}

void receiveData() {
  bool gotData = false;
  while (ble.available()) {
    gotData = true;
    int c = ble.read();

    Serial.print((char)c);
    receiveBuffer += String((char)c);
  }

  if (gotData) {
    parseBufferIfComplete();
  }
}

void parseBufferIfComplete() {
  if (receiveBuffer.endsWith("\n\n")) {
    char charBuffer[200];
    receiveBuffer.toCharArray(charBuffer, 200);
    
    char *tmp = strtok(charBuffer, "\n");
    Serial.print("Test");
    Serial.println(tmp);
    dataName = strtok(NULL, "\n");
    dataCategory = strtok(NULL, "\n");
    dataAmount = strtok(NULL, "\n");
    
    renderData();    
    currentState = ACTIVE;
  }
}

void renderData() {
  display.clearDisplay();

  Serial.print("Name:");
  Serial.println(dataName);

  Serial.print("Category:");
  Serial.println(dataCategory);

  Serial.print("Amount:");
  Serial.println(dataAmount);
  
  display.println(dataName);
  display.println(dataCategory);
  display.println(dataAmount);
  display.refresh();
}

void updateDisplay(char *message) {
  Serial.println(message);
  //display.clearDisplay();
  display.println(message);
  display.refresh();
  
  delay(500);
}

