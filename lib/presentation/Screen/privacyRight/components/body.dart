import 'package:flutter/material.dart';

import 'background.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "ما چه افرادی هستیم",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'iransans'),
                  ),
                ),
                Text(
                  "گروه مشاوره بازاریابی آژنگ متشکل از افراد خبره در حوزه فروش و آموزش فروشندگان است که با هدف کمک به جامعه بازاریاب های ایران و همچینین رونق کسب و کارها فعالیت میکند آدرس وب سایت ما www.bezangapp.ir می باشد",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "ما چه اطلاعاتی را از کاربران جمع‌آوری می‌کنیم و چرا ؟",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "جهت ثبت نام اطلاعاتی نظیر موبایل , نام , زمینه فعالیت ,سن شما را پرسش میکنیم این اطلاعات صرفا جهت تعامل بهتر با اپلیکیشن است از شماره موبایل شما به عنوان کلید اصلی ثبت نام و ارتباط با دوستان در گروه کاری و از نام شما جهت نمایش در اپلیکیشن استفاده می شود و ما متعهد می شویم که هیچ یک از اطلاعات شما را نه برای استفاده ثالث و خارج از موارد گفته شده نه به فرد و یا سازمان دیگر به فروخته نخواهد شد.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "ما همچنین  هنگام ورود شما به اپلیکیشن اطلاعاتی همچون دفعات بازدید شما از اپلیکیشن، مدت زمان حضور شما در اپلیکیشن، نسخه دستگاه شما، دستگاهی که با آن اپلیکیشن را مشاهده می‌کنید اطلاعات فنی دیگر که جهت بهینه‌سازی و بررسی ترافیک اپلیکیشن به ما کمک خواهد کرد. این اطلاعات به هیچ عنوان به سازمان‌های ثالث فروخته نخواهد شد و فقط جهت بهبود اپلیکیشن استفاده خواهد شد.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "اگر تصویری را در یکی از سرویس‌های ارائه شده در اپلیکیشن قرار می‌دهید باید توجه کنید که این تصویر حاوی داده‌هایی درباره‌ موقعیت مکانی مشخص (EXIF GPS) نباشد. بازدیدکنندگان دیگر می‌توانند بعد از ذخیره سازی تصویر موقعیت مکانی این تصاویر را استخراج کنند.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "تا چه مدت اطلاعات شما را نگهداری می‌کنیم ؟",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "کاربرانی که در اپلیکیشن ما ثبت‌نام می‌کنند، اطلاعات کاربری‌شان نیز حفظ و ذخیره می‌شود. تمام کاربران می‌توانند اطلاعات خود را مشاهده کنند، و یا درخواست ویرایش را ارسال کنند و یا اطلاعات شخصی خود را هر وقت که مایل باشند، پاک کنند. (فقط امکان تغییر شماره وجود ندارد). مدیران اپلیکیشن نیز می‌توانند این اطلاعات را رؤیت و ویرایش کنند.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "تبلیغات",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "امکان دارد شرکت‌های تبلیغاتی که ما از آنها تبلیغات دریافت می‌کنیم سمت کاربر، کوکی‌هایی را ارسال کنند که اطلاعاتی همچون تعداد دفعات نمایش تبلیغ به شما، موقعیت جغرافیایی شما را به این شرکت ارسال کنند، که این اقدام جهت بهبود در امر نمایش تبلیغ است. اپلیکیشن با شرکت‌های تبلیغات غیر معتبر که اطلاعات اضافه از کاربران دریافت می‌کند، همکاری نمی‌کند.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "حقوق شما در رابطه با داده‌های خود چیست؟",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "اگر در این اپلیکیشن، صاحب حساب کاربری باشید، یا نظری به اشتراک بگذارید، حق درخواست فایل داده‌های شخصی خود، یعنی داده‌هایی که ما از شما دریافت و نگهداری کرده‌ایم را دارید. این داده‌ها شامل هر چیزی است که در اپلیکیشن بر جای گذاشته‌اید. ضمنا حق درخواست برای پاک کردن تمام داده‌های شخصی‌تان نیز کاملا محفوظ است. البته این داده‌ها مواردی را که برای اهداف مدیریتی، قانونی و امنیتی در اختیار داریم، شامل نمی‌شود.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "تغییرات در سیاست حفظ حریم خصوصی کاربران",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'iransans'),
                ),
                Text(
                  "تغییرات در این برگه بسیار کم صورت می گیرد، با این وجود در صورت انجام تغییرات جدید در اپلیکیشن، ما آن ها را در این صفحه اعمال خواهیم نمود. توجه داشته باشید که استفاده شما از این اپلیکیشن به منظور پذیرش قوانین ما می باشد.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                      fontFamily: 'iransans'),
                ),
              ]),
            ))));
  }
}
