class TravellarsClass {
  String nationality;
  String dateOfBirth;
  String passwordNumber;
  String issuingCountry;
  String expertDate;

  TravellarsClass(
      {required this.dateOfBirth,
      required this.expertDate,
      required this.issuingCountry,
      required this.nationality,
      required this.passwordNumber});
}

List<TravellarsClass> travellarsDetails = [
  TravellarsClass(
      dateOfBirth: '2001',
      expertDate: '2025',
      issuingCountry: 'Syria',
      nationality: 'Syrian',
      passwordNumber: '551151555'),
  TravellarsClass(
      dateOfBirth: '2001',
      expertDate: '2025',
      issuingCountry: 'Syria',
      nationality: 'Syrian',
      passwordNumber: '551151555'),
  TravellarsClass(
      dateOfBirth: '2001',
      expertDate: '2025',
      issuingCountry: 'Syria',
      nationality: 'Syrian',
      passwordNumber: '551151555'),
  TravellarsClass(
      dateOfBirth: '2001',
      expertDate: '2025',
      issuingCountry: 'Syria',
      nationality: 'Syrian',
      passwordNumber: '551151555'),
];
