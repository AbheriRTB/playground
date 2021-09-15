import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/models/model_cluster.dart';
import 'package:trench/pages/home/page_list.dart';
import 'package:trench/services/database.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cluster>>.value(
        value: DatabaseService().clustersList,
        initialData: [],
        builder: (context, snapshot) {
          return ListClustersPage(
            ctxt: context,
          );
        });
  }
}
