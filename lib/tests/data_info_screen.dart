import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/response_data_provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Response Data'),
      ),
      body: Consumer<ResponseProvider>(
        builder: (context, responseProvider, child) {
          if (responseProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (responseProvider.errorMessage.isNotEmpty) {
            return Center(child: Text(responseProvider.errorMessage));
          } else if (responseProvider.response == null) {
            return const Center(child: Text('No data available'));
          } else {
            final response = responseProvider.response!;
            return ListView.builder(
              itemCount: response.dataModel.configurationModel.provinceList.length,
              itemBuilder: (context, index) {
                final province = response.dataModel.configurationModel.provinceList[index];
                return ExpansionTile(
                  title: Text(province.nameEn),
                  children: province.district.map((district) {
                    return ExpansionTile(
                      title: Text(district.nameEn),
                      children: district.commune.map((commune) {
                        return ExpansionTile(
                          title: Text(commune.nameEn),
                          children: commune.villages.map((village) {
                            return ListTile(
                              title: Text(village.nameEn),
                              subtitle: Text(village.nameKh),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ResponseProvider>().fetchResponse();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
