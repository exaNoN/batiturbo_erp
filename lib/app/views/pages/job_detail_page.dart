import 'dart:ui';

import 'package:batiturbo_erp/app/modules/controllers/api_controllers.dart';
import 'package:batiturbo_erp/app/modules/models/api_models.dart';
import 'package:batiturbo_erp/app/utils/theme_data.dart';
import 'package:batiturbo_erp/app/views/pages/home_page.dart';
import 'package:batiturbo_erp/app/views/widgets/base_widgets/base_widgets.dart';
import 'package:batiturbo_erp/app/views/widgets/floating_button.dart';
import 'package:batiturbo_erp/app/views/widgets/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobDetailPage extends StatelessWidget {
  final context;
  final int index;

  JobDetailPage({Key? key, this.context, required this.index})
      : super(key: key);

  final jobC = Get.find<JobController>();
  final customerC = Get.find<CustomerController>();
  final turboC = Get.find<TurboController>();
  final taskC = Get.find<TaskController>();
  final paymentC = Get.find<PaymentController>();
  final returnV = "".obs;

  @override
  Widget build(BuildContext context) {
    Job job = jobC.jobList[index];
    Customer customer = customerC.findCustomer(int.parse(job.customerId));
    Turbo turbo = turboC.findTurbo(int.parse(job.turboId));
    jobC.descriptionController.text = job.description;
    final Size size = Get.size;
    var paymentId;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${job.id} Nolu İş Detayı"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.off(HomePage()),
          ),
        ),
        body: Container(
          width: size.width,
          height: size.height,
          margin: EdgeInsets.all(8),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Müşteri Adı/Numarası/call
                  CustomerWidget(
                    name: customer.name,
                    phone: customer.phone,
                  ),
                  addVerticalSpace(10),
                  //Turbo kodu / açıklaması
                  TurboWidget(
                    code: turbo.code,
                    description: turbo.description,
                  ),
                  addVerticalSpace(15),
                  JobDesciriptionWidget(
                    description: job.description,
                    controller: jobC.descriptionController,
                  ),
                  //TaskList(),
                ],
              ),
              Positioned(
                  width: size.width,
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FloatingButton(
                        icon: Icons.add,
                        text: "Tahsilat Ekle",
                        // width: size.width * 0.50,
                        onPressed: () {
                          Task task = Task(
                              description: "",
                              jobId: job.id.toString(),
                              paymentId: "",
                              updatedBy: "1",
                              isComplated: false);
                          Payment payment = Payment(
                              amount: "",
                              paymentMethod: "",
                              taskId: "",
                              createdBy: "1");
                          Get.defaultDialog(
                              title: "Tahsilat",
                              content: Form(
                                key: paymentC.paymentFormKey,
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(children: [
                                  TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                        labelText: "Açıklama",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
                                    onChanged: (value) {
                                      task.description = value;
                                    },
                                    validator: (value) {
                                      return taskC.validateDescription(value!);
                                    },
                                  ),
                                  addVerticalSpace(8),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        hintText: "₺",
                                        hintTextDirection: TextDirection.rtl,
                                        hintStyle: headline2,
                                        labelText: "Miktar",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))),
                                    onChanged: (value) {
                                      payment.amount = value;
                                    },
                                    validator: (value) {
                                      return paymentC.validateLength(value!);
                                    },
                                  ),
                                  addVerticalSpace(8),
                                  PaymentMethod(
                                      controller:
                                          paymentC.paymentMethodController),
                                  addVerticalSpace(8),
                                  FloatingButton(
                                      text: "Ödemeyi Kaydet",
                                      icon: Icons.save,
                                      onPressed: () {
                                        payment.paymentMethod = paymentC
                                            .paymentMethodController.text;
                                        if (paymentC.checkSave()) {
                                          paymentC.createPayment(payment);
                                          paymentId = (int.parse(paymentC
                                                      .paymentList.last.id
                                                      .toString()) +
                                                  1)
                                              .toString();
                                          task.paymentId = paymentId;
                                          taskC.createTask(task);
                                          Get.back();
                                        }
                                      })
                                ]),
                              ));
                        },
                      ),
                      FloatingButton(
                        icon: Icons.add,
                        text: "İşlem Ekle",
                        // width: size.width * 0.35,
                        onPressed: () {},
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class JobDesciriptionWidget extends StatelessWidget {
  final String description;
  final TextEditingController controller;

  const JobDesciriptionWidget(
      {Key? key, required this.description, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      ),
      child: TextField(
          controller: controller,
          maxLines: null,
          style: headline2,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
              labelText: "İş Açıklaması:",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              floatingLabelStyle: TextStyle(color: color_black, fontSize: 19))),
    );
  }
}

class TurboWidget extends StatelessWidget {
  final String description;
  final String code;

  const TurboWidget({Key? key, required this.description, required this.code})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Turbo Kodu",
                  style: subtitle1,
                ),
                Text(
                  "0x54162197",
                  style: headline1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Turbo Kodu",
                    style: subtitle1,
                  ),
                  Text(
                    "$description",
                    style: headline1,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class CustomerWidget extends StatelessWidget {
  final String name;
  final String phone;

  const CustomerWidget({Key? key, required this.name, required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Müşteri adı",
                  style: subtitle1,
                ),
                Text(
                  name,
                  style: headline1,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
          Flexible(
              child: InkWell(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Telefon",
                  style: subtitle1,
                ),
                Text(
                  "$phone",
                  style: headline1,
                ),
              ],
            ),
            onDoubleTap: () {
              print("calling customer");
            },
            onLongPress: () {
              print("Editing customer");
            },
          )),
        ],
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
