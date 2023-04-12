import 'package:hdc_remake/app_dependencies.dart';

class BuildSong extends StatelessWidget {
  const BuildSong({Key? key}) : super(key: key);

  static const String textValue = ""
  "Iglesia de Cristo, reanima tu amor.\n"
  "Y sigue la senda que Cristo trazó.\n"
  "Anuncia constante con fe y con valor.\n"
  "El Santo Evangelio que Cristo enseñó.\n\n"
  "Iglesia de Cristo, sé fiel al Señor.\n"
  '"Id por todo el mundo" es la comisión.\n'
  "Conduce a las al buen Salvador.\n"
  "Todo el obediente tendrá salvación.\n\n"
  "Conserva de Cristo la antorcha de luz.\n"
  "Y sigue alumbrando con fe y con tesón.\n"
  "Enseña a las gentes que Cristo en la cruz.\n"
  "Murió para darles paz, gozo y perdón.\n\n"
  "Unidos en Cristo y en su santo amor.\n"
  "Con fe primitiva, sencilla, y fervor.\n"
  '"Una fe, un bautismo y un sólo Señor."\n'
  '"Un solo rebaño y un sólo Pastor."';

  @override
  Widget build(BuildContext context) {

    final fontSizeProvider = Provider.of<FontSizeProvider>(context);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(top: 50, bottom: 30, left: 30, right: 30),
          child: Container(
            width: double.infinity,
            child: Text(
              textValue,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeProvider.fontSize,
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
