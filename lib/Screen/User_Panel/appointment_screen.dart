import 'package:docapp/Screen/User_Panel/user_dashboard.dart';
import 'package:docapp/Widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9E4EE),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.4,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/doctor1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0C84FF).withOpacity(0.9),
                    const Color(0xFF0C84FF).withOpacity(0),
                    const Color(0xFF0C84FF).withOpacity(0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.offAll(() => const UserDashBoard());
                            },
                            child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFF2F8FF),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        spreadRadius: 2,
                                      )
                                    ]),
                                child: const Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xFF0C84FF),
                                    size: 28,
                                  ),
                                )),
                          ),
                          Container(
                              margin: const EdgeInsets.all(8),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF2F8FF),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      spreadRadius: 2,
                                    )
                                  ]),
                              child: const Center(
                                child: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Color(0xFF0C84FF),
                                  size: 28,
                                ),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: 'Patients',
                                fontsize: 20.0,
                                fontweight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              TextWidget(
                                text: '1.8K',
                                fontsize: 18.0,
                                fontweight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: 'Experience',
                                fontsize: 20.0,
                                fontweight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              TextWidget(
                                text: '10 Yr',
                                fontsize: 18.0,
                                fontweight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextWidget(
                                text: 'Rating',
                                fontsize: 20.0,
                                fontweight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              SizedBox(height: 5),
                              TextWidget(
                                text: '4.9',
                                fontsize: 18.0,
                                fontweight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextWidget(
                    text: 'Dr Looney',
                    fontsize: 25.0,
                    fontweight: FontWeight.w500,
                    color: Color(0xFF0C84FF),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.heartPlus,
                        color: Colors.red,
                        size: 24.3,
                      ),
                      const SizedBox(width: 5),
                      TextWidget(
                        text: 'Surgeon',
                        fontsize: 15.5,
                        color: Colors.black.withOpacity(0.6),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextWidget(
                    text:
                        'Lorem Ipsum Is Simply Dummy Text of The Printing And Typesetting Industry. Lorem Ipsum has Been The industry',
                    fontsize: 15.0,
                    fontweight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.6),
                    textalign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextWidget(
                    text: 'Book Appointment',
                    fontsize: 18.0,
                    color: Colors.black.withOpacity(0.6),
                    fontweight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 22),
                            decoration: BoxDecoration(
                                color: index == 1
                                    ? const Color(0xFF0C84FF)
                                    : const Color(0xFFF2F8FF),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    spreadRadius: 2,
                                  )
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextWidget(
                                  text: "${index + 8}",
                                  fontsize: 17.0,
                                  color: index == 1
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.6),
                                ),
                                TextWidget(
                                  text: "Dec",
                                  fontsize: 17.0,
                                  fontweight: FontWeight.w500,
                                  color: index == 1
                                      ? Colors.white
                                      : Colors.black.withOpacity(0.6),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextWidget(
                    text: 'Book Time',
                    fontsize: 18.0,
                    color: Colors.black.withOpacity(0.6),
                    fontweight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 7),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          decoration: BoxDecoration(
                              color: index == 2
                                  ? const Color(0xFF0C84FF)
                                  : const Color(0xFFF2F8FF),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: Center(
                            child: TextWidget(
                              text: '${index + 8}: 00 AM',
                              color: index == 2
                                  ? Colors.white
                                  : Colors.black.withOpacity(0.6),
                            ),
                          ),
                        );
                      }),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Material(
                    color: const Color(0xFF0C84FF),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: TextWidget(
                            text: 'Book Appointment',
                            fontsize: 20.0,
                            color: Colors.white,
                            fontweight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
