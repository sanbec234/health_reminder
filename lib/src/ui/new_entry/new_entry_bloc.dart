import 'package:health_app/src/models/errors.dart';
import 'package:health_app/src/models/medicine.dart';
import 'package:health_app/src/models/medicine_type.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  late BehaviorSubject<MedicineType> _selectedMedicineType$;
  ValueStream<MedicineType> get selectedMedicineType =>
      _selectedMedicineType$.stream;

  late BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  late BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  late BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
        BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>.seeded(EntryError.None);
  }

  void dispose() {
    _selectedMedicineType$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
    _errorState$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$.add(time);
  }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$.value;
    if (type == _tempType) {
      _selectedMedicineType$.add(MedicineType.None);
    } else {
      _selectedMedicineType$.add(type);
    }
  }
}
