import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static registerActions() {
    const QuickActions quickActions = QuickActions();
    
    quickActions.initialize((String shortcutType) {
      print(shortcutType);

      switch (shortcutType) {
        case 'biometrics':
          break;
        case 'compass':
          break;
        case 'pokemons':
          break;
        case 'charmander':
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'biometrics',
        localizedTitle: 'Biometrics',
        // icon: 'ic_fingerprint',
      ),
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        // icon: 'ic_compass',
      ),
      const ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        // icon: 'ic_pokeball',
      ),
      const ShortcutItem(
        type: 'charmander',
        localizedTitle: 'Charmander',
        // icon: 'ic_charmander',
      ),
    ]);
  }
}
