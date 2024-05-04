package pe.edu.upc.flexistudentmobile.factories.room

import pe.edu.upc.flexistudentmobile.repositories.RoomRepository

class RoomRepositoryFactory {
    companion object {
        private var roomRepository: RoomRepository? = null
        fun getRoomRepositoryFactory(token:String): RoomRepository {
            println( "Token en RoomRepositoryFactory: " + token)
            if (roomRepository == null) {
                println( "Token en RoomRepositoryFactory22: " + token)
                roomRepository = RoomRepository(
                    roomService = RoomServiceFactory.getRoomServiceFactory(token),
                    token
                )
            }
            return roomRepository as RoomRepository
        }
    }
}