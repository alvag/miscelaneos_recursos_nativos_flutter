import 'package:miscelaneos/domain/domain.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final PokemonsDataSource dataSource;

  PokemonsRepositoryImpl(this.dataSource);

  @override
  Future<(Pokemon?, String)> getPokemon(String id) async {
    return await dataSource.getPokemon(id);
  }
}
