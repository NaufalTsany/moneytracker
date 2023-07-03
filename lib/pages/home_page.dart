import 'package:flutter/material.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:moneytracker/pages/data_page.dart';
import 'package:moneytracker/pages/category_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneytracker/pages/transaction_page.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime selectedDate;
  late List<Widget> _children;
  late int currentIndex;

  @override
  void initState() {
    updateView(0, DateTime.now());
    super.initState();
  }

  void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void updateView(int index, DateTime? date) {
    setState(() {
      if (date != null) {
        selectedDate = DateTime.parse(DateFormat('yyyy-MM-dd').format(date));
      }
      currentIndex = index;
      _children = [
        DataPage(
          selectedDate: selectedDate,
        ),
        CategoryPage()
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              accent: const Color(0xff126F69),
              locale: 'id',
              onDateChanged: (value) {
                setState(() {
                  selectedDate = value;
                  updateView(0, selectedDate);
                  print('SELECTED DATE :' + value.toString());
                });
              },
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                  decoration: const BoxDecoration(color: Color(0xff126F69)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 36, bottom: 20, left: 16),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.montserrat(
                          fontSize: 20, color: Colors.white),
                    ),
                  )),
              preferredSize: const Size.fromHeight(100)),
      body: _children[currentIndex],
      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
                    builder: (context) => const TransactionPage(
                          transactionWithCategory: null,
                        )))
                .then((value) {
              setState(() {});
            });
          },
          backgroundColor: const Color(0xff06342E),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                updateView(0, DateTime.now());
              },
              icon: const Icon(Icons.home)),
          const SizedBox(width: 20),
          IconButton(
              onPressed: () {
                updateView(1, null);
              },
              icon: const Icon(Icons.list))
        ],
      )),
    );
  }
}
