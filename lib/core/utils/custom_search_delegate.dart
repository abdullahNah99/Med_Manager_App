import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';

class CustomSearchDelegate extends SearchDelegate {
  final List<PatientModel> searchTerms;

  CustomSearchDelegate({required this.searchTerms});

  @override
  String? get searchFieldLabel => 'Search On Patient';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<PatientModel> matchQuery = [];
    for (PatientModel item in searchTerms) {
      if (_getName(item).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: matchQuery.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          log(matchQuery[index].toString());
        },
        child: ListTile(
          title: Text(_getName(matchQuery[index])),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PatientModel> matchQuery = [];
    for (PatientModel item in searchTerms) {
      if (_getName(item).toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: matchQuery.length,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemBuilder: (context, index) => InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(_getName(matchQuery[index])),
        ),
      ),
    );
  }

  String _getName(PatientModel patientModel) {
    return '${patientModel.userModel.firstName} '
        '${patientModel.userModel.lastName}';
  }
}
