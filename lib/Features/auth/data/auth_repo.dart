import 'package:dio/dio.dart';
import 'package:flutter_application_hungray/Core/Network/api_erorr.dart';
import 'package:flutter_application_hungray/Core/Network/api_execptions.dart';
import 'package:flutter_application_hungray/Core/Network/api_service.dart';
import 'package:flutter_application_hungray/Core/utils/pref_helper.dart';
import 'package:flutter_application_hungray/Features/auth/data/user_model.dart';

class AuthRepo {

 ApiService apiService=ApiService();



  // Login method

    Future<UserModel?> login(String email, String password) async {

      try {
  
          final response = await apiService.post('/login',{"email": email, "password":password});

          
          if (response is ApiErorr) {
            throw response;
          }

          if (response is Map<String,dynamic>){
            final msg = response['message'];
            final status = response['status'];
            final data = response['data'];   
           if (status != true || data == null){
            throw ApiErorr(message: msg);
           }
          
          final user = UserModel.fromJson(response ['data']);
          if (user.token != null) {
            await prefHelper.saveToken( user.token!); 
          }
          return user;
          }else {
            throw ApiErorr(message: "Unexpected Erorr form server");
          }


      }on DioException catch (e) {
       throw ApiExecptions.handleErorr(e);
        
      } catch (e) {
        throw ApiErorr(message: e.toString());
      }

    }



  // Signup method
    

   Future<UserModel?> signup(String name , String email, String password) async {
    
    try {
      final response = await apiService.post('/register',{"name": name, "email": email, "password":password});

      if (response is ApiErorr) {
        throw response;
      }

      if (response is Map<String,dynamic>){
        final msg = response['message'];
        final status = response['status'];
        final data = response['data'];

        if (status != true || data == null){
          throw ApiErorr(message: msg);
        }

        final user = UserModel.fromJson(response ['data']);
        if (user.token != null) {
          await prefHelper.saveToken( user.token!); 
        }
        return user;
      }else {
        throw ApiErorr(message: "Unexpected Erorr form server");
      }



    }on DioException catch (e){
      throw ApiExecptions.handleErorr(e);
    }catch (e) {
      throw ApiErorr(message: e.toString());
    }

   }






  //Get profile data method

  

  Future<UserModel?>getProfileData() async {
    
    try {

   
     final response = await apiService.get('/profile');
     

     return UserModel.fromJson(response['data']);

   
   
   
   
   
    }on DioException catch (e){
      throw ApiExecptions.handleErorr(e);

  }catch (e) {
      throw ApiErorr(message: e.toString());
    }

  }

  






  //update profile data method





  //logout method


}
