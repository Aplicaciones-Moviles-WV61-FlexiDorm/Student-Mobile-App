package pe.edu.upc.flexistudentmobile.factories.room

import pe.edu.upc.flexistudentmobile.factories.RetrofitFactory
import pe.edu.upc.flexistudentmobile.model.remote.RoomService

class RoomServiceFactory {
    companion object {
        private var roomService: RoomService? = null
        fun getRoomServiceFactory(token:String): RoomService {
            if (roomService == null) {
                roomService = RetrofitFactory.getRetrofit(token).create(RoomService::class.java)
            }
            return roomService as RoomService
        }
    }

}