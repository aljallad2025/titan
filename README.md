# Titan — تطبيق سوق قطع غيار السيارات والإطارات وخدمات الصيانة

مشروع Flutter كامل جاهز للبناء عبر [CodeMagic](https://codemagic.io/).

## محتوى المشروع
- `lib/main.dart` — نقطة انطلاق التطبيق
- `lib/theme/` — الهوية البصرية (أسود وأحمر)
- `lib/models/` — نموذج بيانات المنتجات (إطارات وقطع غيار)
- `lib/screens/` — كل شاشات التطبيق:
  - Splash (شاشة البداية)
  - الرئيسية
  - السوق (فلاتر المقاس، القساوة/معدل السرعة، الفصل)
  - تفاصيل المنتج
  - حجز خدمة الصيانة
  - السلة
  - الحساب الشخصي
- `codemagic.yaml` — إعداد جاهز للبناء التلقائي على CodeMagic (Android و iOS)

## خطوات الرفع والبناء على CodeMagic

### 1. رفع المشروع على GitHub
```bash
cd titan_app
git init
git add .
git commit -m "Titan app - initial version"
git branch -M main
git remote add origin <رابط-الريبو-تبعك>
git push -u origin main
```

### 2. ربط الريبو بـ CodeMagic
1. افتح [codemagic.io](https://codemagic.io/) وسجل دخول (بحساب GitHub).
2. اختر "Add application" وحدد الريبو الخاص بـ Titan.
3. CodeMagic رح يكتشف ملف `codemagic.yaml` تلقائياً ويعرض الـ workflows:
   - **Titan - Android Build** → بيطلع لك APK جاهز.
   - **Titan - iOS Build** → بيطلع لك بناء iOS (بدون توقيع، للاختبار).
4. اضغط "Start new build" واختر الـ workflow المطلوب.

> ملاحظة: أول مرة بيشتغل السكربت `flutter create .` تلقائياً لتوليد مجلدي `android` و `ios` لأن المشروع مبني من الكود (lib/) فقط دون هالمجلدات، وهاد أمر طبيعي وآمن.

### 3. للتجربة محلياً (اختياري)
```bash
flutter pub get
flutter run
```

## ملاحظات
- الخطوط: يستخدم التطبيق خط **Cairo** عبر حزمة `google_fonts` (يتحمّل تلقائياً عند أول تشغيل مع اتصال إنترنت).
- البيانات حالياً بيانات تجريبية (Demo) داخل `lib/models/product.dart` — لازم تربطها لاحقاً بـ API حقيقي (مثلاً Firebase أو باك اند خاص فيك).
- الاتجاه: التطبيق بالكامل RTL (عربي).
