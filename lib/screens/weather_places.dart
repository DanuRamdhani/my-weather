import 'package:flutter/material.dart';
import 'package:my_weather/data/city_names.dart';
import 'package:my_weather/db_helper.dart';
import 'package:my_weather/screens/weather_by_place.dart';

class WeatherPlaces extends StatefulWidget {
  const WeatherPlaces({super.key});

  @override
  State<WeatherPlaces> createState() => _WeatherPlacesState();
}

class _WeatherPlacesState extends State<WeatherPlaces> {
  final SearchController _searchController = SearchController();
  List<Map<String, dynamic>> _yourPlaces = [];

  Future<void> _refreshData() async {
    final data = await SqlHelper().getAllData();
    setState(() {
      _yourPlaces = data;
    });
  }

  Future<void> _addData(String city) async {
    await SqlHelper().createData(city);
    _refreshData();
  }

  Future<void> _deleteData(int id) async {
    try {
      await SqlHelper().deleteData(id);
      _refreshData();
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _searchController;
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('See other location'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SearchAnchor(
              searchController: _searchController,
              builder: (BuildContext context, SearchController controller) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SearchBar(
                    leading: const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(Icons.search),
                    ),
                    onTap: () {
                      _searchController.openView();
                    },
                  ),
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                final keyword = controller.value.text;
                return List.generate(
                        cityNames.length, (index) => cityNames[index])
                    .where((element) =>
                        element.toLowerCase().startsWith(keyword.toLowerCase()))
                    .map((item) => ListTile(
                          title: Text(item),
                          onTap: () {
                            _addData(item);
                            setState(() {
                              controller.closeView(item);
                              FocusScope.of(context).unfocus();
                              _searchController.clear();
                            });
                          },
                        ));
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  itemCount: _yourPlaces.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => WeatherByPlaceScreen(
                              cityName: _yourPlaces[index]['city']),
                        ));
                      },
                      title: Text(
                        _yourPlaces[index]['city'],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _deleteData(_yourPlaces[index]['id']);
                        },
                        icon: const Icon(Icons.delete_forever_rounded),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
