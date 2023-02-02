import 'package:flutter/material.dart';
import 'package:mobile_carbon/widgets/widgets.dart';

import '../commons/commons.dart';

class DetailCommentScreen extends StatelessWidget {
  const DetailCommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.backgroundLight,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Komentar",
          style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 18.0,
                color: ColorPalettes.dark,
                fontWeight: FontWeight.w700,
              ),
        ),
        backgroundColor: ColorPalettes.backgroundLight,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: ColorPalettes.dark,
          ),
        ),
        elevation: 0.0,
      ),
      floatingActionButton: InkWell(
        onTap: () => print("==> add new comment"),
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
          child: const Icon(
            Icons.add,
            size: 32.0,
            color: ColorPalettes.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 20.0,
        ),
        child: ListView(
          children: [
            Text(
              "Semua Komentar",
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontSize: 18.0,
                    color: ColorPalettes.dark,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                AuthorItem(
                  author: "Serena Waiyene",
                  dateCreated: "11 April 2022",
                  authorTextColor: ColorPalettes.dark,
                  dateTextColor: ColorPalettes.grayZill,
                  dividerColor: ColorPalettes.line,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _showActionOptions(context),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: ColorPalettes.dots,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 4.0,
              ),
              child: Text(
                "Saya pernah menanam kaktus di polybag tapi hasil yang didapatkan malah tidak bagus, bagaimana ya agar kaktus saya bisa tumbuh di media polybag?",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                "Sembunyikan komentar",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Tere Liye",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Kaktus harus ditanam di pot kak, tidak dapat ditanam di polybag",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Serena Waiyne",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Baik kak, terimakasih masukannya",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),

            // Komentar 2
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                AuthorItem(
                  author: "Tere Liye",
                  dateCreated: "11 April 2022",
                  authorTextColor: ColorPalettes.dark,
                  dateTextColor: ColorPalettes.grayZill,
                  dividerColor: ColorPalettes.line,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => print("Pressed three dot"),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: ColorPalettes.dots,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 4.0,
              ),
              child: Text(
                "Apakah bisa menanam sayur menggunakan media pot ya?",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                "Lihat balasan lainnya (3)",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),

            // Komentar 3
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                AuthorItem(
                  author: "Tere Liye",
                  dateCreated: "11 April 2022",
                  authorTextColor: ColorPalettes.dark,
                  dateTextColor: ColorPalettes.grayZill,
                  dividerColor: ColorPalettes.line,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => print("Pressed three dot"),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: ColorPalettes.dots,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 4.0,
              ),
              child: Text(
                "Saya pernah menanam kaktus di polybag dan hasil oke",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                "Sembunyikan komentar",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Serena Waiyne",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Wah, mantap kak",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),

            // Komentar 4
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                AuthorItem(
                  author: "Serena Waiyene",
                  dateCreated: "11 April 2022",
                  authorTextColor: ColorPalettes.dark,
                  dateTextColor: ColorPalettes.grayZill,
                  dividerColor: ColorPalettes.line,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => print("Pressed three dot"),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.maxFinite,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: ColorPalettes.dots,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 4.0,
              ),
              child: Text(
                "Saya pernah menanam kaktus di polybag tapi hasil yang didapatkan malah tidak bagus, bagaimana ya agar kaktus saya bisa tumbuh di media polybag?",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.dark,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.justify,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 12.0,
              ),
              child: Text(
                "Sembunyikan komentar",
                style: Theme.of(context).textTheme.caption?.copyWith(
                      color: ColorPalettes.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Tere Liye",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Kaktus harus ditanam di pot kak, tidak dapat ditanam di polybag",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Serena Waiyne",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Baik kak, terimakasih masukannya",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Tere Liye",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Kaktus harus ditanam di pot kak, tidak dapat ditanam di polybag",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 36.0),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: ColorPalettes.line,
                    width: 2.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      AuthorItem(
                        author: "Serena Waiyne",
                        dateCreated: "11 April 2022",
                        authorTextColor: ColorPalettes.dark,
                        dateTextColor: ColorPalettes.grayZill,
                        dividerColor: ColorPalettes.line,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => print("Pressed three dot"),
                          child: Container(
                            alignment: Alignment.centerRight,
                            width: double.maxFinite,
                            child: Icon(
                              Icons.more_horiz_rounded,
                              color: ColorPalettes.dots,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 5.0,
                      bottom: 4.0,
                      left: 30.0,
                      right: 4.0,
                    ),
                    child: Text(
                      "Baik kak, terimakasih masukannya",
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: ColorPalettes.dark,
                            fontWeight: FontWeight.w400,
                          ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showActionOptions(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => CommentActionBottomSheet(),
    );

    if (data != null) {
      if (data == 1 || data == 2) {
        _showAddComment.call(context);
      } else if (data == 3) {
        _showDeleteArticle.call(context);
      } else {}
    }
  }

  Future<void> _showAddComment(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => PostCommentBottomSheet(),
    );

    if (data != null) {
      // do something
    }
  }

  Future<void> _showDeleteArticle(BuildContext context) async {
    final data = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: defaultBottomSheetShape,
      builder: (context) => DeleteArticleBottomSheet(
        label: "Hapus Artikel",
        caption:
            "Apakah Anda ingin menghapus artikel? Artikel yang telah dihapus "
            "tidak dapat dikembalikan lagi.",
        negativeCallback: () => Navigator.pop(context),
        positiveLabel: "Hapus",
      ),
    );

    if (data != null) {
      // do something
    }
  }
}
