class ProfileModel {
  final String displayName;
  final String subTitle;
  final String anonymityNote;
  final String walletBalance;
  final bool isDarkMode;

  const ProfileModel({
    this.displayName = 'Anonymous User',
    this.subTitle = 'Your identity is always private',
    this.anonymityNote = 'End-to-end anonymous sessions',
    this.walletBalance = '₹45',
    this.isDarkMode = false,
  });

  ProfileModel copyWith({
    String? displayName,
    String? subTitle,
    String? anonymityNote,
    String? walletBalance,
    bool? isDarkMode,
  }) {
    return ProfileModel(
      displayName: displayName ?? this.displayName,
      subTitle: subTitle ?? this.subTitle,
      anonymityNote: anonymityNote ?? this.anonymityNote,
      walletBalance: walletBalance ?? this.walletBalance,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}