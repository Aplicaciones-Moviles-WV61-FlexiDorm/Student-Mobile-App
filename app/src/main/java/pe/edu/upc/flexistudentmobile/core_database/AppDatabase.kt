package pe.edu.upc.flexistudentmobile.core_database

import androidx.room.Database
import androidx.room.RoomDatabase
import pe.edu.upc.flexistudentmobile.model.local.StudentDao
import pe.edu.upc.flexistudentmobile.model.local.StudentEntity


@Database(entities=[StudentEntity::class], version=1)
abstract class AppDatabase: RoomDatabase() {
    abstract fun studentDao(): StudentDao
}