part of 'pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 2), () async {
      context.read<PageCubit>().goToMainPage();
    });
  }

  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage("assets/images/si-soil.png"),
                  fit: BoxFit.contain,
                  colorFilter: ColorFilter.mode(
                    scaffoldBgColor.withOpacity(0.8),
                    BlendMode.dstATop,
                  ),
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Support by :", style: blackTextFontTitle),
              const SizedBox(height: 8),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage("assets/images/support-by.png"),
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        scaffoldBgColor.withOpacity(0.8),
                        BlendMode.dstATop,
                      ),
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
      //bottomNavigationBar: Container(
      //  height: 50,
      //  decoration: BoxDecoration(
      //    color: greenColor1,
      //    borderRadius: const BorderRadius.only(
      //      topLeft: Radius.circular(10),
      //      topRight: Radius.circular(10),
      //    ),
      //  ),
      //  child: Center(
      //    child: Text(
      //      "SI - SOIL",
      //      style: whiteTextFontTitle.copyWith(
      //        fontStyle: FontStyle.italic,
      //        fontSize: 20,
      //      ),
      //    ),
      //  ),
      //),
    );
  }
}
