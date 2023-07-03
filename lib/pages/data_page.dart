import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneytracker/models/database.dart';
import 'package:moneytracker/models/transaction_with_category.dart';
import 'package:moneytracker/pages/transaction_page.dart';

class DataPage extends StatefulWidget {
  final DateTime selectedDate;
  const DataPage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  final MyDatabase database = MyDatabase();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: const Icon(
                              Icons.attach_money,
                              color: Colors.green,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Income",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Rp. 3.800.000",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.red,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          const SizedBox(width: 15),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expense",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Rp. 1.200.000",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white, fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ]),
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: const Color(0xff06342E),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Transactions",
                style: GoogleFonts.montserrat(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<List<TransactionWithCategory>>(
                stream: database.getTransactionByDateRepo(widget.selectedDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Card(
                                  elevation: 10,
                                  child: ListTile(
                                    trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () async {
                                                await database
                                                    .deleteTransactionRepo(
                                                        snapshot.data![index]
                                                            .transaction.id);
                                                setState(() {});
                                              }),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TransactionPage(
                                                            transactionWithCategory:
                                                                snapshot.data![
                                                                    index],
                                                          )));
                                            },
                                          )
                                        ]),
                                    title: Text("Rp. " +
                                        snapshot.data![index].transaction.amount
                                            .toString()),
                                    subtitle: Text(snapshot
                                            .data![index].category.name +
                                        " (" +
                                        snapshot.data![index].transaction.name +
                                        ")"),
                                    leading: Container(
                                      child: (snapshot
                                                  .data![index].category.type ==
                                              2)
                                          ? Icon(
                                              Icons.shopping_cart,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.attach_money,
                                              color: Colors.green,
                                            ),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: Text("Tidak ada transaksi"));
                      }
                    } else {
                      return Center(child: Text("Tidak ada data"));
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
