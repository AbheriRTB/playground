import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trench/models/model_cluster.dart';

class ListClustersPage extends StatelessWidget {
  BuildContext? ctxt;
  ListClustersPage({this.ctxt});

  @override
  Widget build(BuildContext context) {
    final clusters = Provider.of<List<Cluster?>>(ctxt!);

    return Scaffold(
      body: ListView.builder(
          itemCount: clusters.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(clusters[index]!.clusterName!),
            );
          }),
    );
  }
}
