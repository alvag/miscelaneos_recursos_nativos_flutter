import 'package:flutter/material.dart';
import 'package:miscelaneos/domain/domain.dart';
import 'package:workmanager/workmanager.dart';
import 'package:miscelaneos/config/config.dart';

class DbPokemonsScreen extends StatelessWidget {
  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Background process'),
          actions: [
            IconButton(
              onPressed: () {
                Workmanager().registerOneOffTask(
                  fetchBackgroundTaskKey,
                  fetchBackgroundTaskKey,
                  initialDelay: const Duration(seconds: 3),
                  constraints: Constraints(
                    networkType: NetworkType.connected,
                  ),
                  inputData: {
                    'data1': 'value1',
                    'data2': 'value2',
                  },
                );
              },
              icon: const Icon(Icons.add_alarm_sharp),
            ),
          ],
        ),
        body: const CustomScrollView(
          slivers: [
            _PokemonsGrid(
              pokemons: [],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text('Activar fetch periodico'),
          icon: const Icon(Icons.av_timer),
        ));
  }
}

class _PokemonsGrid extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokemonsGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Column(
          children: [
            Image.network(pokemon.spriteFront, fit: BoxFit.contain),
            Text(pokemon.name),
          ],
        );
      },
    );
  }
}
