import 'dart:convert';

import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/models/person_image.dart';
import 'package:axis_assignment/data/network/handlers/api/failure.dart';
import 'package:axis_assignment/data/network/responses/people_response.dart';
import 'package:axis_assignment/data/sources/remote/people_service.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

abstract class PeopleRepository {
  Future<Either<Failure, PeopleResponse>> getPeople({int? page});

  Future<Either<Failure, List<PersonImage>>> getPersonImages(int personId);
}

class PeopleDataRepository implements PeopleRepository {
  final PeopleService _peoplesService = PeopleService();

  @override
  Future<Either<Failure, PeopleResponse>> getPeople({int? page}) async {
    try {
      Response response = await _peoplesService.getPeople(page: page);
      dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        List<People> people = [];

        bool lastPage = false;

        try {
          responseData['results'].map((json) {
            people.add(People.fromJson(json));
          }).toList();
        } catch (e) {
          return Left(Failure(code: 400, error: e.toString()));
        }

        if (responseData['page'] != responseData['total_pages']) {
          lastPage = false;
        }

        PeopleResponse peopleResponse = PeopleResponse(people: people, isLastPage: lastPage);
        return Right(peopleResponse);
      } else {
        return Left(Failure(code: 400, error: responseData['error']));
      }
    } catch (exception) {
      return Left(Failure(code: 400, error: exception.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PersonImage>>> getPersonImages(int personId) async {
    try {
      Response response = await _peoplesService.getPersonImages(personId);
      dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        List<PersonImage> images = [];
        try {
          responseData['profiles'].map((json) {
            images.add(PersonImage.fromJson(json));
          }).toList();
        } catch (e) {
          return Left(Failure(code: 400, error: e.toString()));
        }
        return Right(images);
      } else {
        return Left(Failure(code: 400, error: responseData['error']));
      }
    } catch (exception) {
      return Left(Failure(code: 400, error: exception.toString()));
    }
  }
}
