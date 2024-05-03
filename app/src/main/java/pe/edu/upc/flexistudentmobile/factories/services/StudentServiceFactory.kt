package pe.edu.upc.flexistudentmobile.factories.services

import pe.edu.upc.flexistudentmobile.factories.RetrofitFactory
import pe.edu.upc.flexistudentmobile.model.remote.StudentService

class StudentServiceFactory {
    companion object {
        private var studentService: StudentService? = null
        fun getStudentService(token:String): StudentService {
            if (studentService == null) {
                studentService = RetrofitFactory.getRetrofit(token).create(StudentService::class.java)
            }
            return studentService as StudentService
        }
    }
}