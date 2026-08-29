class Gift {
  final String id;
  final String name;
  final int cost;
  final String icon;

  Gift({
    required this.id,
    required this.name,
    required this.cost,
    required this.icon,
  });

  static List<Gift> getGiftList() {
    return [
      Gift(id: '1', name: 'Rose', cost: 10, icon: '🌹'),
      Gift(id: '2', name: 'Microphone', cost: 100, icon: '🎤'),
      Gift(id: '3', name: 'Crown', cost: 500, icon: '👑'),
      Gift(id: '4', name: 'Sports Car', cost: 2000, icon: '🏎️'),
      Gift(id: '5', name: 'Rocket', cost: 10000, icon: '🚀'),
    ];
  }
}
