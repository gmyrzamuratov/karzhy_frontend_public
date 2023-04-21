import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karzhy_frontend/functions/catalogs/company/add/controllers/add_company_controller.dart';
import 'package:karzhy_frontend/models/company.dart';

class AddCompanyView extends StatefulWidget {

  Company? company;

  AddCompanyView({this.company});

  @override
  State<AddCompanyView> createState() => _AddCompanyViewState();
}

class _AddCompanyViewState extends State<AddCompanyView> {

  final List<String> _companyTypes = ['ЖК', 'ЖШС'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCompanyController>(
      init: AddCompanyController(initialCompany: widget.company),
      builder: (controller) => Scaffold(
      appBar: AppBar(title: Text('Компания мәліметін енгіз')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child:  Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Аты'),
                initialValue: widget.company?.name,
                onChanged: (value) {
                  controller.company.value.name = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'ЖСН'),
                initialValue: widget.company?.bin,
                onChanged: (value) {
                  controller.company.value.bin = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Мекен-жай'),
                initialValue: widget.company?.address,
                onChanged: (value) {
                  controller.company.value.address = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Кбе'),
                initialValue: widget.company?.kbe,
                maxLength: 2,
                onChanged: (value) {
                  controller.company.value.kbe = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Банк атауы'),
                initialValue: widget.company?.bankName,
                onChanged: (value) {
                  controller.company.value.bankName = value;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Банктағы шот'),
                initialValue: widget.company?.bankAccount,
                onChanged: (value) {
                  controller.company.value.bankAccount = value;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: controller.company.value.companyType == null ?
                _companyTypes[0]
                    : _companyTypes[controller.company.value.companyType!],
                items: _companyTypes.map((String companyType) {
                  return DropdownMenuItem<String>(
                    value: companyType,
                    child: Text(companyType),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    controller.company.value.companyType = _companyTypes.indexOf(newValue!);
                  });
                },
                decoration: InputDecoration(labelText: 'Компания түрі'),
              ),
              SizedBox(height: 70),
            ],
          ),
        ),
        bottomSheet: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50), // NEW
          ),
          child: Text("Сақтау"),
          onPressed: () {
            if(widget.company == null) {
              controller.add();
            } else {
              controller.updateCompany();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the text editing controllers when the widget is removed from the widget tree
    super.dispose();
  }
}
