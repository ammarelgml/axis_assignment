import 'dart:convert';

import 'package:axis_assignment/data/models/person.dart';
import 'package:axis_assignment/data/models/person_image.dart';
import 'package:axis_assignment/data/network/handlers/failure.dart';
import 'package:axis_assignment/data/network/responses/people_response.dart';
import 'package:axis_assignment/data/sources/local/cache/people/people_local.dart';
import 'package:axis_assignment/data/sources/remote/people_remote.dart';
import 'package:axis_assignment/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

abstract class PeopleRepository {
  Future<Either<Failure, PeopleResponse>> getPeople({int? page});

  Future<Either<Failure, List<PersonImage>>> getPersonImages(int personId);
}

class PeopleDataRepository implements PeopleRepository {
  final PeopleRemote _peopleRemote = PeopleRemote();
  final PeopleLocal _peopleLocal = PeopleLocal();

  @override
  Future<Either<Failure, PeopleResponse>> getPeople({int? page}) async {
    if (!(await Utils.networkIsConnective())) {
      /// No internet connection, fetch from local storage
      try {
        final people = _peopleLocal.getPeopleFromLocal();
        people.sort((a, b) => a.id.compareTo(b.id));
        return Right(PeopleResponse(people: people, isLastPage: true));
      } catch (exception) {
        return Left(Failure(code: 400, message: exception.toString()));
      }
    } else {
      try {
        /// Internet connection available, fetch from remote and save to local
        Response response = await _peopleRemote.getPeople(page: page);
        dynamic responseData = json.decode(response.body);

        if (response.statusCode == 200) {
          List<People> people = [];

          bool lastPage = false;

          try {
            responseData['results'].map((json) {
              people.add(People.fromJson(json));
            }).toList();
          } catch (e) {
            return Left(Failure(code: 400, message: e.toString()));
          }

          if (responseData['page'] != responseData['total_pages']) {
            lastPage = false;
          }

          /// Save to local storage if it is the same page will replace the old data
          /// Cache only the first page (20 people)
          if (responseData['page'] == 1) {
            await _peopleLocal.savePeopleToLocal(people, true);
          }

          people.sort((a, b) => a.id.compareTo(b.id));
          PeopleResponse peopleResponse = PeopleResponse(people: people, isLastPage: lastPage);
          return Right(peopleResponse);
        } else {
          return Left(Failure(code: 400, message: responseData['error']));
        }
      } catch (exception) {
        return Left(Failure(code: 400, message: exception.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<PersonImage>>> getPersonImages(int personId) async {
    try {
      Response response = await _peopleRemote.getPersonImages(personId);
      dynamic responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        List<PersonImage> images = [];
        try {
          responseData['profiles'].forEach((json) {
            images.add(PersonImage.fromJson(json));
          });
        } catch (e) {
          return Left(Failure(code: 400, message: e.toString()));
        }
        return Right(images);
      } else {
        return Left(Failure(code: 400, message: responseData['error']));
      }
    } catch (exception) {
      return Left(Failure(code: 400, message: exception.toString()));
    }
  }
}
