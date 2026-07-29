part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.selectedImage,
    this.name,
    this.countryCode,
    this.countryName,
  });

  final XFile? selectedImage;

  final String? name;
  final String? countryCode;
  final String? countryName;

  ProfileState copyWith({
    XFile? selectedImage,
    String? name,
    String? countryCode,
    String? countryName,
  }) {
    return ProfileState(
      selectedImage: selectedImage ?? this.selectedImage,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      countryName: countryName ?? this.countryName,
    );
  }

  @override
  List<Object?> get props => [selectedImage, name, countryCode, countryName];
}