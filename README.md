# BudgeTracker-main

INNOVA INSTALL FUTURE

# Mobil Finansal Uygulama

Bu proje, finansal alanda kullanılabilecek bir mobil uygulamayı geliştirmek için tasarlanmıştır.  
Bütce Takibi sistemi dizayn edilmiştir.  
SwiftUI ile geliştirilmiş ilk projemdir.

## Mimariler

Bu projede MVVM (Model-View-ViewModel) mimari yapıları kullanılmıştır.  
MVVM, verilerin ve iş mantığının ayrıştırılmasına yardımcı olmuştur.

## Views

Proje 4 ana sayfadan (ContentView) oluşmaktadır. Bunlar  
-My Expenses (ExpenseView): Gelir Gider sayfasıdır. Aynı zamanda ana sayfadır. Gelir giderlere ait detaylı arama (ExpenseFilterView) sayfası ve gelir/gider ekleme (AddNewExpenseView) sayfalarına bu sayfa üzerinden gidilmektedir.    
-Savings (SavingsView): Saklanan birikimleri gösteren sayfadır. Kumbaram gibi düşünülebilir. Yeni birikim ekleme (NewSavingsView) sayfasına savings üzerinden gidilir.    
-Currency Converter (ExchangeView) : Anlık döviz çevirimi sağlar. API isteği ile (https://api.exchangerate.host/latest?base=USD&amount=1000) yapar. Eğer ki mock servis kullanılırsa exchange_rates_mock.json dosyasındaki verileri ekrana gönderir.    
-Settings (SettingsView) : çıkış (logout) sayfasıdır.

Ayrıca bunlar dışında LoginViews, RegisterViews ve birkaç yardımcı-HelperViews (TransactionCard, SavingCard) daha kullanılmıştır. 

## Models
Projede Expense, Savings, Currency isimli 3 ayrı model kullanılmıştır.


## Servisler

Proje kapsamında 2 farklı servis kullanılmıştır:

1. Veri Alımı Servisi: Bu servis, bir endpoint'ten veri almak için kullanılmıştır. Anlık döviz verileri API ile alınmıştır.

2. Mock Servis 1: İlk mock servis, uygulama içindeki örnek verilerin sağlanmasında kullanılmıştır. Bu servis, geliştirme ve test aşamalarında gerçek veriye bağlı olmadan çalışmamızı sağlar. Exchange_rates_mock.json dosyasındaki verileri gösterir.

## Üçüncü Parti Araçlar

Bu projede, uygulamanın işlevselliğini ve kullanıcı deneyimini artırmak için bazı üçüncü parti araçlar kullanılmıştır:

Firebase: Firebase, uygulamada kullanıcı kimlik doğrulama, veritabanı yönetimi özelliklerin uygulanmasına yardımcı olmuştur. Authentication ile kullanıcı doğrulaması yapılmış FireStore ile girilen değerler db ye kaydedilmiştir.

## Versiyon Kontrolü

Proje, Git versiyon kontrol sistemi kullanılarak yönetilmektedir. Katılımcılar, projeye katkıda bulunurken kendi branch'lerinde çalışmalı ve değişiklikleri uygun bir şekilde commit etmelidir. Proje tek branch "main" üzerinden ilerlemiştir.

## Güvenli İletişim Mekanizmaları

Bu uygulama, kullanıcıların kimlik doğrulama ve yetkilendirme süreçlerini içeren güvenli bir kimlik doğrulama yapısına Firebase Authentication ile sahip olmuştur. Kullanıcıların kaydolması, oturum açması ve kimlik doğrulaması Firebase ile sağlanmıştır.

Ayrıca, kullanıcıların kimliklerini hatırlaması için "Beni Unut" seçeneği de sunulmuştur. Bu seçenek, kullanıcının oturum açtığı cihazda (userdefaults appStorage) kimlik bilgilerinin saklanmasını sağlar.

## Kurulum & Başlama

Firebase ayarları (GoogleService-Info) yapıldıktan sonra kolayca çalıştırılabilir.  
Proje @main sınıfı olan TrackerApp.swift dosyasından firebase.configure() metodu ile başlamaktadır. 

## Görseller

<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/dcc5381a-a378-4af7-b3e1-2fe400f3b370" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/1bdbac22-ff58-4467-a5f4-e72f984103eb" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/222577f5-4a9b-4f7e-85f9-34729dcf9bb5" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/db5210ea-a6ce-47d2-885d-d8568bdbdca8" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/39ccdb43-a5e2-4f72-8d9a-0371f921645d" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/ea76ad5c-e391-4018-9c3b-8ce7b5ebc0c8" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/0da02f92-77c5-40d5-8116-6f83776fc456" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/598dceda-440d-4936-b1b1-56c343234a4f" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/3a3fbcd6-b73e-4eb4-a16d-fe5189b7a63b" alt="alt yazı" width="320">
<img src="https://github.com/shenmali/BudgeTracker-main/assets/77589328/b86cb870-9553-4e97-9632-ab1f99d5e7ba" alt="alt yazı" width="320">





