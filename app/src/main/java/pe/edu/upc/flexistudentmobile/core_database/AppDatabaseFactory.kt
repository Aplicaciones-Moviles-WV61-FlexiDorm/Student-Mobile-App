package pe.edu.upc.flexistudentmobile.core_database

import android.content.Context
import androidx.room.Room

class AppDatabaseFactory{
    companion object {
        private var appDatabase: AppDatabase? = null

        fun getAppDatabase(context: Context): AppDatabase {
            if(appDatabase == null){
                appDatabase = Room.databaseBuilder(context, AppDatabase::class.java, "flexistudentDb")
                    .allowMainThreadQueries().build()
            }
            return appDatabase as AppDatabase
        }
    }
}