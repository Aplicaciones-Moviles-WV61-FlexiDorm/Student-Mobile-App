package pe.edu.upc.flexistudentmobile.model.remote

import pe.edu.upc.flexistudentmobile.model.data.ApiResponse
import pe.edu.upc.flexistudentmobile.model.data.RequestSignInStudentBody
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentBody
import retrofit2.Call
import retrofit2.http.Body
import retrofit2.http.POST

interface StudentService {
    @POST("auth/signUp/student")
    fun signUpStudent(
        @Body requestSignUpStudentBody: RequestSignUpStudentBody
    ): Call<ApiResponse>

    @POST("auth/signIn")
    fun signInStudent(
        @Body  requestSignInStudentBody: RequestSignInStudentBody
    ): Call<ApiResponse>
}