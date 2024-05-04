package pe.edu.upc.flexistudentmobile.repositories

import android.util.Log
import pe.edu.upc.flexistudentmobile.model.data.ApiResponse
import pe.edu.upc.flexistudentmobile.model.data.RequestSignInStudentBody
import pe.edu.upc.flexistudentmobile.model.data.RequestSignUpStudentBody
import pe.edu.upc.flexistudentmobile.model.data.Student
import pe.edu.upc.flexistudentmobile.model.local.StudentDao
import pe.edu.upc.flexistudentmobile.model.local.StudentEntity
import pe.edu.upc.flexistudentmobile.model.remote.StudentService
import retrofit2.Call
import retrofit2.Callback
import retrofit2.HttpException
import retrofit2.Response

class StudentRepository  (
    private val studentService: StudentService,
    private val studentDao: StudentDao
){
    fun signUpStudent(
        requestSignUpStudentBody: RequestSignUpStudentBody,
        callback: (ApiResponse?, Int?, String?) -> Unit
    ) {
        val call = studentService.signUpStudent(requestSignUpStudentBody)

        call.enqueue(object : Callback<ApiResponse> {
            override fun onResponse(call: Call<ApiResponse>, response: Response<ApiResponse>) {
                if (response.isSuccessful) {
                    val apiResponse = response.body()
                    val statusCode= response.code()
                    callback(apiResponse, statusCode, null)
                } else {
                    val errorCode = response.code()
                    val errorBody = response.errorBody()?.string()
                    callback(null, errorCode, errorBody)
                }
            }

            override fun onFailure(call: Call<ApiResponse>, t: Throwable) {
                var errorCode = -1
                if (t is HttpException) {
                    errorCode = t.code()
                }
                callback(null, errorCode, t.message)
            }
        })
    }

    fun signInStudent(
        requestSignInStudentBody: RequestSignInStudentBody,
        callback:(ApiResponse?, Int?, String?)->Unit
    ) {

        val call = studentService.signInStudent(requestSignInStudentBody)

        call.enqueue(object : Callback<ApiResponse> {
                override fun onResponse(call: Call<ApiResponse>, response: Response<ApiResponse>) {
                    if (response.isSuccessful) {
                        val apiResponse = response.body()
                        val statusCode= response.code()
                        callback(apiResponse, statusCode, null)
                    }else {
                        val errorCode = response.code()
                        val errorBody = response.errorBody()?.string()
                        callback(null, errorCode, errorBody)
                    }
                }

                override fun onFailure(call: Call<ApiResponse>, t: Throwable) {

                    t.message?.let {
                        Log.e("StudentRepository", it)

                    }
                }
            }
        )
    }

    fun insertStudentDataLocal(student: Student){
        studentDao.insert(
            StudentEntity(
                student.userId.toString(),
                student.username,
                student.firstname,
                student.lastname,
                student.phoneNumber,
                student.email,
                student.address,
                student.birthDate,
                student.profilePicture,
                student.gender,
                student.university,
                student.token,
                student.verifier
            )
        )
    }

    fun deleteStudentDataLocal(id: String ){
        studentDao.deleteById(id)
    }

    fun deleteAllStudentDataLocal(){
        studentDao.deleteAllStudentsLocal()
    }

    fun getStudentDataLocal(id:String):StudentEntity?{
        return studentDao.getStudentById(id)
    }

    fun getStudent():List<StudentEntity>{
        return studentDao.getStudent()
    }

    fun getToken(id:String):String{
        return studentDao.getToken(id)
    }

}