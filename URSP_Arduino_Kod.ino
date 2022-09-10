/* 
 *  Yıldıray KARACA USRS Projesi İçin Arduino Kodları.
 *  mail: yildiraykaraca@icloud.com
 *  github: https://github.com/yildiraykaraca
*/
#include <Servo.h>  //Serve Kütüphanesini Dahil Ettik.
Servo servomotor;  // Servo Motorumuza "myservo" adını verdik. 

#define echo 6    //Echo pin
#define trigger 7 //Trigger pin

#define G_led 8 // Yeşil Ledi "G_led" Adında Tutturup 8. Pine Tanımladım.
#define R_led 9 // Kırmızı Ledi "R_led" Adında Tutturup 8. Pine Tanımladım.

int mesafe; // Uzaklığı Tutturabilmek için Oluşturduğum Değişken.
int derece;   // Açıyı Tutturabilmek için Oluşturduğum Değişken.
 
void setup() { // Yüklendiğinde

Serial.begin(9600); // Seri Haberleşmeyi Başlattım.

servomotor.attach(2); // Servonun Kurulumunu Belirttim.

pinMode(echo, INPUT );// Ultrasonik Sensörde Echo pini bir Giriş
pinMode(trigger, OUTPUT); // Ultrasonik Sensörde Trigger pini bir Çıktı

pinMode(R_led,OUTPUT); // Kırmızı Led Bir Çıkış
pinMode(G_led,OUTPUT); // Yeşil Led Bir Çıkış

delay(100); // 100ms Bekle
} 
 
 
void loop() // Sonsuz Döngüde
{ 
for(derece=1; derece<180; derece+=1) // Açı 180 Derece Olana Kadar Açı Değerini 1 Arttır.
{ 
servomotor.write(derece);   // Açı Değerini Değişkene Yaz
delay(80); // 80MS Bekle
data();   // Veri
}

for(derece=180; derece>1; derece-=1) // Servoyu Eski Konumuna Döndür.
{ 
servomotor.write(derece);   // Açı Değerini Değişkene Yaz
delay(80);  // 80MS Bekle
data();    // Veri
}

}


void data()
{
digitalWrite(trigger, LOW); //Triggerı  Geçersiz Kırdık.
delayMicroseconds(2); //Programı Duraklat
digitalWrite(trigger, HIGH);  //Triggerı Aktif Ettik
delayMicroseconds(10); //Programı Duraklat
long time = pulseIn(echo, HIGH); // Hıgh Değerini Zamana Eşitle
mesafe = time / 28.5 / 2; // Mesafeyi Hesapladık

if(mesafe>100) // Eğer Uzaklık 100 Den Büyükse
{
 mesafe = 100; // Uzaklık = 100
}
  
if(mesafe>50) // Eğer Uzaklık 50 Den Büyükse
{ 
digitalWrite(G_led, HIGH); // LED'i Yak   
digitalWrite(R_led, LOW); // LED'i Kapat 
}
else //Değilse
{ 
digitalWrite(G_led, LOW); // LED'i Kapat   
digitalWrite(R_led, HIGH); // LED'i Yak
}
  
Serial.print(derece); Serial.print( " "); Serial.println(mesafe);
}
