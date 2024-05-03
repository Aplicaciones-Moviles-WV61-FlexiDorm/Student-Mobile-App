package pe.edu.upc.flexistudentmobile.factories.repositories

import pe.edu.upc.flexistudentmobile.factories.StudentDaoFactory
import pe.edu.upc.flexistudentmobile.factories.services.StudentServiceFactory
import pe.edu.upc.flexistudentmobile.repositories.StudentRepository

class StudentRepositoryFactory {
    companion object {
        private var studentRepository: StudentRepository? = null

        fun getStudentRepository(token:String): StudentRepository {
            if (studentRepository == null) {
                studentRepository = StudentRepository(
                    studentService = StudentServiceFactory.getStudentService(token),
                    studentDao = StudentDaoFactory.getStudentDao()
                )
            }
            return studentRepository as StudentRepository
        }
    }
}