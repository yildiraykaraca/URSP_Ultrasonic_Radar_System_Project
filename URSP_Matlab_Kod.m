% 
 %  Yıldıray KARACA USRS Project İçin Matlab Kodları.
 %  mail: yildiraykaraca@icloud.com
 %  github: https://github.com/yildiraykaraca
%
clc; %Komut Penceresini Temizle.
clear all; %Öğeleri çalışma alanından kaldırdık.

%Grafiği Özelleştir

figure('units','normalized','outerposition',[0 0 1 1]); % Şekil Penceresi Oluşturduk.
whitebg('black'); %Eksen Arka Plan Rengini Değiştirdik.

%Ölçek Verilerini Çiz

th = linspace(0,pi,1000); % Oluşturulan Vektörü th Değişkenine Atadık.
R = 10:10:100;   % R Dizisini Oluşturduk
for i=1:length(R); % 1 Den R Dizisine Kadar x ve y Yazdırdık.
x = R(i)*cos(th);
y = R(i)*sin(th);
plot(x,y,'Color', [0.603922 , 0.803922 , 0.196078] ,'LineWidth',1); % x ve y yi Çizdirdik.
hold on; % Mevcut Grafiği Koru.
end % Bitir.

%Eksen Verilerini Çiz

x0 = [0 100 0 0 0 0 ];  x1 = [0 100 86.60 50 -50 -86.60]; y0 = [0 0 0 0 0 0]; y1 = [100 0 50 86.60 86.60 50]; %x0 a Eksenleri Atadık.
for i=1:length(x0); %x0 Uzunluğu Boyunca Diziler İçin 
hold on; % Mevcut Grafiği Koru.
plot([x0(i),x1(i)],[y0(i),y1(i)] ,'Color', [0.603922 , 0.803922 , 0.196078],'LineWidth',2); % Çizdir.
end % Bitir.

%Sonar Verilerini Çiz

for i=1:180 %1 den 180 Dizisi İçin
hold on; % Mevcut Grafiği Koru.
[x, y] = pol2cart(i*0.0174532925, 100); %Kutupsal veya silindirik koordinatları Kartezyene Dönüştür ve x, y Dizisine Ata %
h(i) = plot([0,x],[0,y],'g','LineWidth',1); % Çizdir ve Değişkene Ata.
end % Bitir.

%Seri Bağlantı Noktası Tanımlanması

s1 = serial('COM13'); %COM13 Bağlantısını s1e Aktar.           
s1.BaudRate=9600; %9600 Haberleşmeyi Değişkene Ata.                              
fopen(s1); %S1 Hakkında Bilgi Aldık.

%Sonar Verilerinin Çizdirilmesi

while(1) % Koşul Gerçekleşene Kadar.
data = fscanf(s1); % s1i tara ve data değişkenine aktar.
[th, r] = strtok(data); % Dizelerin seçilen kısımlarını diziye aktar.
th = real(str2num(th)); %Stringe Dönüştür Gerçek Kısmını al th Değişkenine Aktar.
r = str2num(r); %Stringe Dönüştür.
set(h(th),'color','r'); % Rengi Ayarla.
[x0, y0] = pol2cart(th*0.0174532925, 100); %x0 y0 dizisine Kartezyene Dönüştür Ve Aktar.
[x, y] = pol2cart(th*0.0174532925, r); %x y dizisine Kartezyene Dönüştür Ve Aktar.
set(h(th),'XData',[x0,x]); %Ayarlar
set(h(th),'YData',[y0,y]); %Ayarlar
m = plot([0,x0],[0,y0],'r','LineWidth',3); %m Değişkenine Çizdir.
drawnow %Çizdir.
delete(m);%myi Sil.
end %Bitir.


