import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:weather/features/feature_weather/domain/usecases/get_suggestion_usecase.dart';

class CityTextField extends StatelessWidget {
  final  Function(String) onSubmitted;
  final TextEditingController controller;
  final GetSuggestionUsecase getSuggestionUsecase;
  const CityTextField({required this.onSubmitted, required this.controller,required this.getSuggestionUsecase,super.key});

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: controller,
                        onSubmitted: onSubmitted,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 20, color: Colors.white),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: 'Enter a city name',
                            hintStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            )),
                      ),
                      suggestionsCallback: (query) {
                        return getSuggestionUsecase(query);
                      },
                      itemBuilder: (context, itemData) => ListTile(
                        leading: const Icon(Icons.location_city),
                        title: Text(itemData.name!),
                        subtitle:
                            Text('${itemData.region!}, ${itemData.country!}'),
                      ),
                      onSuggestionSelected: (suggestion) {
                        final cityName = suggestion.name!;
                        onSubmitted(cityName);
                      },
                    );
  }
}