class RoomController {
  static bool isMicOn = false;
  static bool areSeatsLocked = false;
  static int userCoins = 1000000;
  static int currentSeats = 8;

  // Toggle Microphone
  static bool toggleMic() {
    isMicOn = !isMicOn;
    return isMicOn;
  }

  // Toggle Seat Lock
  static bool toggleSeatLock() {
    areSeatsLocked = !areSeatsLocked;
    return areSeatsLocked;
  }

  // Deduct Coins for Gifting
  static bool sendGift(int cost) {
    if (userCoins >= cost) {
      userCoins -= cost;
      return true;
    }
    return false;
  }

  // Add Coins
  static void addCoins(int amount) {
    userCoins += amount;
  }
}

