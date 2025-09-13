# Flutter Junior Case

Bu proje, Baris Çeliker tarafından geliştirilmiş ve modern, sürdürülebilir, **genişlemeye uygun** bir Flutter uygulaması geliştirme pratiğini amaçlayan bir “junior case” uygulamasıdır.

---

## 📋 İçindekiler

- [📌 Özellikler](#-özellikler)
- [🏗️ Proje Yapısı](#-proje-yapısı)
- [⚙️ Kurulum](#-kurulum)
- [🚀 Çalıştırma](#-çalıştırma)
- [🔌 Kullanılan Paketler](#-kullanılan-paketler)
- [🗂 Klasör Yapısı](#-klasör-yapısı)
- [🛠️ Katkıda Bulunma](#-katkıda-bulunma)
- [📄 Lisans](#-lisans)

---

## 📌 Özellikler

- Modern ve şık UI tasarımı
- Responsive yapı: farklı ekran boyutlarında düzgün görünüm
- Light/Dark tema desteği
- Feature-first modüler yapı
- Routing & Navigation sistemi
- Form doğrulama ve hata yönetimi
- Çoklu dil desteği (l10n)
- Animasyonlar (Custom, GIF, Lottie desteği)
- State Management: (Varsa belirtilecek)
- Kolay test edilebilir yapı

---

## 🏗️ Proje Yapısı

```
lib/
├── core/             # Temel yapı taşları: tema, sabitler, genel widget’lar, yardımcılar
│   ├── constants/
│   ├── widgets/
│   └── ...
├── features/         # Uygulamanın özellik modülleri (örneğin auth, home, profile)
│   ├── auth/
│   ├── home/
│   ├── profile/
│   └── ...
├── l10n/             # Localization (çoklu dil) dosyaları
├── screens/          # Ekran bileşenleri
├── main.dart         # Uygulama başlangıç noktası
└── ...
```



## ⚙️ Kurulum

### Gerekli Ön Koşullar

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (tercihen güncel sürüm)
- Dart SDK (Flutter ile birlikte gelir)
- Gerekli IDE: VS Code veya Android Studio
- (iOS geliştirme için) macOS + Xcode

### Kurulum Adımları

```bash
# 1. Repoyu klonla
git clone https://github.com/BarisCeliker3/flutter_junior_case.git

# 2. Proje dizinine geç
cd flutter_junior_case

# 3. Bağımlılıkları indir
flutter pub get
```

---

## 🚀 Çalıştırma

Uygulamayı çalıştırmak için:

```bash
flutter run
```

Android/iOS simülatör veya bağlı fiziksel cihaz kullanabilirsiniz.




## 🔌 Kullanılan Paketler

Başlıca kullanılan paketler (örnek, senin koduna göre):

- [firebase_auth](https://pub.dev/packages/firebase_auth) – Firebase ile kimlik doğrulama
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) – Firebase Firestore veritabanı
- [provider](https://pub.dev/packages/provider) veya [riverpod](https://pub.dev/packages/riverpod) – State management (varsa)
- [flutter_localizations](https://pub.dev/packages/flutter_localizations) – Çoklu dil desteği
- [intl](https://pub.dev/packages/intl) – Localization işlemleri
- [lottie](https://pub.dev/packages/lottie) – Lottie animasyonları
- [cached_network_image](https://pub.dev/packages/cached_network_image) – Ağdan resim yükleme ve önbellekleme
- [google_fonts](https://pub.dev/packages/google_fonts) – Özel fontlar
- [flutter_svg](https://pub.dev/packages/flutter_svg) – SVG desteği
- Diğer yardımcı paketler (ör: equatable, get_it, ...)

> Kendi `pubspec.yaml` dosyana göre güncelleyebilirim!

---

## 🗂 Klasör Yapısı

```
lib/
├── core/
│   ├── constants/    # Renkler, metin stilleri, padding vs.
│   ├── widgets/      # Ortak widget’lar
│   └── ...
├── features/
│   ├── auth/
│   ├── home/
│   ├── profile/
│   └── ...
├── l10n/             # Localization dosyaları
├── screens/          # Ana ekranlar
├── main.dart         # Giriş noktası
└── ...
```

---

## 🛠️ Katkıda Bulunma

Eğer projeye katkı yapmak istersen:

1. Reponun bir kopyasını forklayın.
2. Yeni bir branch oluşturun (`feature/isim`, `bugfix/isim` vs.)
3. Geliştirmelerinizi yapıp commit’leyin.
4. Pull request açın ve yaptığınız değişiklikleri açıklayın.

---

## 📄 Lisans

MIT License © 2025 Baris Çeliker

---
