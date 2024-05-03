package pe.edu.upc.flexistudentmobile.factories
import pe.edu.upc.flexistudentmobile.MyApplication
import pe.edu.upc.flexistudentmobile.core_database.AppDatabaseFactory
import pe.edu.upc.flexistudentmobile.model.local.StudentDao

class StudentDaoFactory {
    companion object{
        private var studentDao: StudentDao? = null
        fun getStudentDao(): StudentDao {
            if(studentDao == null){
                studentDao = AppDatabaseFactory.getAppDatabase(MyApplication.getContext()).studentDao()
            }
            return studentDao as StudentDao
        }
    }
}

