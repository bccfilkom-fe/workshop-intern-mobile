import 'package:fe_bccintern24/app/cubit/tweet/tweet_cubit.dart';
import 'package:fe_bccintern24/app/pages/detail_page.dart';
import 'package:fe_bccintern24/app/pages/widgets/buttons.dart';
import 'package:fe_bccintern24/app/pages/widgets/loading.dart';
import 'package:fe_bccintern24/app/pages/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/models/tweet.dart';
import '../styles/color_styles.dart';
import 'widgets/text_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TweetCubit>().getAllTweet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController judulController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();

    bool isClickable = false;

    void checkClickable() {
      final judul = judulController.text.trim();
      final deskripsi = deskripsiController.text.trim();
      setState(() {
        isClickable = judul.isNotEmpty && deskripsi.isNotEmpty;
      });
    }

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isDismissible: true,
              isScrollControlled: true,
              context: context,
              builder: (_) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 370 + MediaQuery.of(context).viewInsets.bottom,
                    width: width,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
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
                              width: width,
                              text: "Posting",
                              isClickable: isClickable,
                              onClicked: () {
                                context.read<TweetCubit>().createTweet(
                                    judulController.text,
                                    deskripsiController.text);
                                Navigator.pop(context);
                              })
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
        backgroundColor: ColorStyles.secondary,
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          size: 24,
          color: ColorStyles.primary,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: ColorStyles.primary,
      ),
      body: Column(
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
                    height: 56,
                  ),
                  Text(
                    "Hai Semua",
                    style: GoogleFonts.poppins(
                        color: ColorStyles.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "Selamat datang di Sky",
                    style: GoogleFonts.poppins(
                        color: ColorStyles.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          BlocConsumer<TweetCubit, TweetState>(
            listener: (context, state) {
              if (state is GetTweetEror) {
                showSnackBarWidget(context, state.eror);
              } else if (state is CreateTweetEror) {
                showSnackBarWidget(context, state.eror);
              } else if (state is CreateTweetSuccess) {
                context.read<TweetCubit>().getAllTweet();
              }
            },
            builder: (context, state) {
              if (state is GetTweetLoading ||
                  state is CreateTweetLoading ||
                  state is DeleteTweetLoading) {
                return const Loading();
              } else if (state is GetTweetSuccess) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListTweet(dummyData: state.listTweet, width: width),
                  ),
                );
              }
              return const Center(
                child: Text("Belum ada tweet nih"),
              );
            },
          )
        ],
      ),
    );
  }
}

class ListTweet extends StatefulWidget {
  const ListTweet({
    super.key,
    required this.dummyData,
    required this.width,
  });

  final List<TweetModel> dummyData;
  final double width;

  @override
  State<ListTweet> createState() => _ListTweetState();
}

class _ListTweetState extends State<ListTweet> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dummyData.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailPage(data: widget.dummyData[index]),
              ),
            );
          },
          child: Container(
            width: widget.width,
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
                    widget.dummyData[index].id,
                    style: GoogleFonts.poppins(
                        color: ColorStyles.black,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.dummyData[index].title,
                    style: GoogleFonts.poppins(
                        color: ColorStyles.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    widget.dummyData[index].description,
                    style: GoogleFonts.poppins(
                        color: ColorStyles.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
