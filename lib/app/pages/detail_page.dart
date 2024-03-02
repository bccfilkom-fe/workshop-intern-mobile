import 'package:fe_bccintern24/app/cubit/tweet/tweet_cubit.dart';
import 'package:fe_bccintern24/app/pages/widgets/loading.dart';
import 'package:fe_bccintern24/app/pages/widgets/snackbar.dart';
import 'package:fe_bccintern24/data/models/tweet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/color_styles.dart';
import 'home_page.dart';
import 'widgets/buttons.dart';
import 'widgets/text_fields.dart';

class DetailPage extends StatefulWidget {
  final TweetModel data;

  const DetailPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController judulController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();

  //agar text controller memiliki nilai dari tweet yang sudah ada
  @override
  void initState() {
    judulController.text = widget.data.title;
    deskripsiController.text = widget.data.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    bool isClickable = false;

    void checkClickable() {
      final judul = judulController.text.trim();
      final deskripsi = deskripsiController.text.trim();
      setState(() {
        isClickable = judul.isNotEmpty && deskripsi.isNotEmpty;
      });
    }

    return Scaffold(
      body: BlocConsumer<TweetCubit, TweetState>(
        listener: (context, state) {
          if (state is DeleteTweetEror) {
            showSnackBarWidget(context, state.eror);
          } else if (state is UpdateTweetEror) {
            showSnackBarWidget(context, state.eror);
          } else if (state is DeleteTweetSuccess ||
              state is UpdateTweetSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is DeleteTweetLoading || state is UpdateTweetLoading) {
            return const Loading();
          }
          return Column(
            children: [
              Container(
                height: 123,
                width: width,
                decoration: BoxDecoration(
                    color: ColorStyles.primary,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 65,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorStyles.white,
                              size: 24,
                            ),
                          ),
                          Text(
                            "Postingan",
                            style: GoogleFonts.poppins(
                                color: ColorStyles.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(
                            Icons.arrow_back,
                            color: ColorStyles.primary,
                            size: 24,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: ColorStyles.softGrey,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.id,
                          style: GoogleFonts.poppins(
                              color: ColorStyles.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.data.title,
                          style: GoogleFonts.poppins(
                              color: ColorStyles.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.data.description,
                          style: GoogleFonts.poppins(
                              color: ColorStyles.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 128,
                        height: 46,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title:
                                    const Text("Anda yakin ingin menghapus?"),
                                content: const Text(
                                    "Postingan anda akan terhapus jika anda meng-klik tombol Iya di bawah ini."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<TweetCubit>()
                                          .deleteTweet(widget.data.id);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Iya"),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Tidak"),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorStyles.error),
                          child: Text(
                            "Hapus",
                            style: GoogleFonts.poppins(
                              color: ColorStyles.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 128,
                        height: 46,
                        child: OutlinedButton(
                          onPressed: () {
                            showModalBottomSheet(
                                isDismissible: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (_) {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                      height: 370 +
                                          MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                      width: width,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: 24,
                                          left: 16,
                                          right: 16,
                                          bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom +
                                              32,
                                        ),
                                        child: Column(
                                          children: [
                                            TextFields(
                                              controller: judulController,
                                              text: "Judul",
                                              textInputType: TextInputType.name,
                                              onChanged: (text) {
                                                setState(() {
                                                  checkClickable();
                                                });
                                              },
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            TextFields(
                                              controller: deskripsiController,
                                              text: "Deskripsi",
                                              textInputType: TextInputType.name,
                                              onChanged: (text) {
                                                setState(() {
                                                  checkClickable();
                                                });
                                              },
                                            ),
                                            const Expanded(child: SizedBox()),
                                            Buttons(
                                              text: "Ubah",
                                              isClickable: isClickable,
                                              onClicked: () {
                                                context
                                                    .read<TweetCubit>()
                                                    .updateTweet(
                                                      widget.data.id,
                                                      judulController.text,
                                                      deskripsiController.text,
                                                    );
                                                Navigator.pop(context);
                                              },
                                              width: width,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: ColorStyles.primary),
                          ),
                          child: Text(
                            "Ubah",
                            style: GoogleFonts.poppins(
                              color: ColorStyles.primary,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
