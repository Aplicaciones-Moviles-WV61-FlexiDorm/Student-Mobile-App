package pe.edu.upc.flexistudentmobile.model.local

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "student")
data class StudentEntity(
    @PrimaryKey
    val id: String,

    val username: String,
    val firstname: String,
    val lastname: String,
    val phoneNumber: String,
    val email: String,
    val address: String,
    val birthDate: String,
    val profilePicture: String,
    val gender: String?,
    val university: String,
    val verifier: Boolean,
    val token:String,
)
