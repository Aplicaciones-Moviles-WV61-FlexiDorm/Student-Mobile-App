package pe.edu.upc.flexistudentmobile.model.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.Delete
import androidx.room.Query


@Dao
interface StudentDao {
    @Insert
    fun insert(studentEntity: StudentEntity)

    @Query("DELETE FROM student WHERE id = :heroId")
    fun deleteById(heroId: String)

    @Query("DELETE FROM student")
    fun deleteAllStudentsLocal()

    @Query("SELECT * FROM student")
    fun getStudent(): List<StudentEntity>

    @Query("SELECT * FROM student WHERE id = :id")
    fun getStudentById(id: String): StudentEntity?

    @Query("SELECT token FROM student WHERE id = :id")
    fun getToken(id: String): String

}