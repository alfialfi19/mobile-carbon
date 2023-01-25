import 'package:flutter/material.dart';

import '../commons/commons.dart';

class DetailArticleScreen extends StatelessWidget {
  const DetailArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                  top: 10.0,
                ),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: ColorPalettes.white,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: const Icon(
                  Icons.chevron_left_rounded,
                  size: 32.0,
                  color: ColorPalettes.dark,
                ),
              ),
            ),
            expandedHeight: 300.0,
            floating: true,
            pinned: true,
            snap: true,
            elevation: 50.0,
            flexibleSpace: Stack(
              children: [
                FlexibleSpaceBar(
                  background: Image.asset(
                    Images.dummyPlant3,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 310.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    width: double.maxFinite,
                    height: 30.0,
                    decoration: const BoxDecoration(
                      color: ColorPalettes.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(40.0),
                  decoration: const BoxDecoration(
                    color: ColorPalettes.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        24.0,
                      ),
                      topRight: Radius.circular(
                        24.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            height: 24.0,
                            width: 24.0,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                Images.dummyProfile,
                              ),
                            ),
                          ),
                          Text(
                            "Serean Waiyene",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.dark,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            height: 5.0,
                            width: 5.0,
                            decoration: BoxDecoration(
                              color: ColorPalettes.line,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          Text(
                            "11 April 2022",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.grayZill,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Bagi Anda yang memiliki hobi bercocok tanam namun tinggal di daerah perkotaan, sering kali mengalami hambatan ketika ingin menyalurkan hobi Anda tersebut. Kendala yang dirasakan tidak lain adalah ketersediaan lahan yang sangat terbatas untuk dapat dimanfaatkan sebagai media bercocok tanam. Untuk mengatasi masalah tersebut, kini sudah dikembangkan berbagai teknik bercocok tanam khususnya untuk membudidayakan tanaman hias. Berbagai media bisa digunakan mulai dari tanah hingga air. Namun, yang akan dibahas dalam artikel ini adalah khusus cara menanam dan perawatan tanaman hias dalam pot. Mengembangbiakkan tanaman hias di dalam pot memiliki banyak manfaat, salah satunya adalah tidak memerlukan lahan yang luas. Selain itu, dengan meletakkannya dalam pot, Anda dapat memanfaatkan tanaman hias tersebut sebagai salah satu hiasan dekorasi interior rumah.',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.black,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                        textAlign: TextAlign.justify,
                      ),
                      Text(
                        'Bagi Anda yang memiliki hobi bercocok tanam namun tinggal di daerah perkotaan, sering kali mengalami hambatan ketika ingin menyalurkan hobi Anda tersebut. Kendala yang dirasakan tidak lain adalah ketersediaan lahan yang sangat terbatas untuk dapat dimanfaatkan sebagai media bercocok tanam.',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.black,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        titleSpacing: 0.0,
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.only(
              left: 20.0,
              top: 10.0,
            ),
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: ColorPalettes.white,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: const Icon(
              Icons.chevron_left_rounded,
              size: 32.0,
              color: ColorPalettes.dark,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      floatingActionButton: InkWell(
        onTap: () => print("===> Pressed"),
        child: Container(
          margin: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
          ),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: ColorPalettes.primary,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: const Icon(
            Icons.mark_chat_unread_outlined,
            size: 32.0,
            color: ColorPalettes.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: double.maxFinite,
          child: Stack(
            children: [
              Container(
                height: 330,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Images.dummyPlant3,
                    ),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                      ColorPalettes.black.withOpacity(0.4),
                      BlendMode.luminosity,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                top: 300.0,
                child: Container(
                  padding: const EdgeInsets.all(40.0),
                  decoration: const BoxDecoration(
                    color: ColorPalettes.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        24.0,
                      ),
                      topRight: Radius.circular(
                        24.0,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Cara Budidaya Tanaman Hias Di Dalam Media Pot",
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                              height: 1.5,
                            ),
                        overflow: TextOverflow.visible,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
                            height: 24.0,
                            width: 24.0,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                Images.dummyProfile,
                              ),
                            ),
                          ),
                          Text(
                            "Serean Waiyene",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.dark,
                                      fontWeight: FontWeight.w700,
                                    ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            height: 5.0,
                            width: 5.0,
                            decoration: BoxDecoration(
                              color: ColorPalettes.line,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          Text(
                            "11 April 2022",
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: ColorPalettes.grayZill,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        'Bagi Anda yang memiliki hobi bercocok tanam namun tinggal di daerah perkotaan, sering kali mengalami hambatan ketika ingin menyalurkan hobi Anda tersebut. Kendala yang dirasakan tidak lain adalah ketersediaan lahan yang sangat terbatas untuk dapat dimanfaatkan sebagai media bercocok tanam. Untuk mengatasi masalah tersebut, kini sudah dikembangkan berbagai teknik bercocok tanam khususnya untuk membudidayakan tanaman hias. Berbagai media bisa digunakan mulai dari tanah hingga air. Namun, yang akan dibahas dalam artikel ini adalah khusus cara menanam dan perawatan tanaman hias dalam pot. Mengembangbiakkan tanaman hias di dalam pot memiliki banyak manfaat, salah satunya adalah tidak memerlukan lahan yang luas. Selain itu, dengan meletakkannya dalam pot, Anda dapat memanfaatkan tanaman hias tersebut sebagai salah satu hiasan dekorasi interior rumah.',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.black,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
