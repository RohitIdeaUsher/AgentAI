import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtualagentchat/app/services/hive_service.dart';

import 'app/modules/ChatRoom/model/chat_message.dart';
import 'app/modules/HomePage/model/chat_session.dart';
import 'app/routes/app_pages.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await initServices();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xFF151721)));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => {runApp(const Soltopiah())},
  );
  // runApp(const Soltopiah());
}

class Soltopiah extends StatelessWidget {
  const Soltopiah({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery.of(context).size.width;
    // MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, __) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              builder: (context, widget) {
                return MediaQuery(
                  ///Setting font does not change with system font size
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(1.0)),
                  child: widget!,
                );
              },
              title: "VirtualAgent",
              initialRoute: AppPages.INITIAL,
              getPages: AppPages.routes,
            ),
          );
        });
  }
}

Future<void> initServices() async {
  // await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
  await Hive.initFlutter();
  // await HiveService().init();
  Hive.registerAdapter(ChatSessionAdapter());
  Hive.registerAdapter(ChatMessageAdapter());
  await HiveService().init();
}
