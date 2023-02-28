import 'package:flutter/material.dart';
import 'package:mobile_carbon/routes.dart';

import '../commons/commons.dart';
import '../widgets/widgets.dart';

class DetailArticleScreen extends StatelessWidget {
  const DetailArticleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () => Navigator.pushNamed(
          context,
          Routes.detailComment,
        ),
        child: Container(
          height: 54.0,
          width: 54.0,
          margin: const EdgeInsets.only(
            left: 20.0,
            top: 10.0,
          ),
          decoration: BoxDecoration(
            color: ColorPalettes.primary,
            borderRadius: BorderRadius.circular(100.0),
          ),
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: Image.asset(
              CarbonIcons.comment,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorPalettes.white,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      AuthorItem(
                        author: "Serena Waiyene",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
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
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Tempat Kegiatan",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Lorem ipsum",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Waktu Kegiatan",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "20 Januari 1104",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Kontak",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Lorem ipsum",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Batas Waktu Donasi",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Lorem ipsum",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.grayZill,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Link Donasi",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.dark,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      Text(
                        "Lorem ipsum",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: ColorPalettes.primary,
                              fontWeight: FontWeight.w400,
                            ),
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
  }
}
