import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:med_manager_app/core/errors/failures.dart';
import 'package:med_manager_app/core/utils/dio_helper.dart';
import 'package:med_manager_app/features/authentication/data/models/patient_model.dart';
import 'package:med_manager_app/features/doctor_features/features/home_doctor/data/repos/home_doctor_repo.dart';
import 'package:med_manager_app/features/patient_features/my_appointments/data/models/appointment_model.dart';

class HomeDoctorRepoImpl extends HomeDoctorRepo {
  @override
  Future<Either<Failure, List<PatientModel>>> indexDoctorPatients({
    required String token,
  }) async {
    try {
      var response = await DioHelper.getData(
        url: 'doctor/DoctorPatient',
        token: token,
      );
      List<PatientModel> patients = [];
      for (var item in response.data['patients']) {
        patients.add(PatientModel.fromJson(item));
      }
      return right(patients);
    } catch (ex) {
      log('There is an error in indexDoctorPatients method in HomeDoctorRepoImpl');
      if (ex is DioException) {
        log(ex.toString());
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentModel>>>
      indexApprovedAppointmentsByDate({
    required String secretaryToken,
    required int doctorID,
    required String date,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'indexApproveAppointmentByDate',
        token: secretaryToken,
        body: {
          'doctor_id': doctorID,
          'date': date,
        },
      );
      List<AppointmentModel> approvedAppointments = [];
      for (var item in response.data['Appointment']) {
        approvedAppointments.add(AppointmentModel.fomJson(item));
      }
      return right(approvedAppointments);
    } catch (ex) {
      log('There is an error in getApprovedAppointmentsOfToday method in HomeDoctorRepoImpl');
      if (ex is DioException) {
        log(ex.toString());
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> indexApprovedAppointmentsDates({
    required String secretaryToken,
    required int doctorID,
  }) async {
    try {
      var response = await DioHelper.postData(
        url: 'indexApproveAppointment',
        token: secretaryToken,
        body: {
          'doctor_id': doctorID,
        },
      );
      List<String> dates = [];
      for (var item in response.data['Appointment']) {
        dates.add(item['date']);
      }
      return right(dates);
    } catch (ex) {
      log('There is an error in indexApprovedAppointmentsDates method in HomeDoctorRepoImpl');
      if (ex is DioException) {
        log(ex.toString());
        log(ex.response?.data.toString() ?? '');
        return left(ServerFailure.fromDioException(ex));
      }
      return left(ServerFailure(ex.toString()));
    }
  }
}
